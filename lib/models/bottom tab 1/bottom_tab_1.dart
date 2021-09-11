import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rentalz/models/Customer%20infor/customer_infor.dart';
import 'package:rentalz/models/rentalz_input_form/rental_input_form.dart';
import 'package:rentalz/widgets/custom_buttom/custom_button.dart';

class BottomTab1 extends StatefulWidget {
  const BottomTab1({
    required this.customerInfo,
  }) : super();
  final CustomerInfo customerInfo;
  @override
  _BottomTab1State createState() => _BottomTab1State();
}

class _BottomTab1State extends State<BottomTab1> {
  final customer = CustomerInfo();
  int formState = 0; // 0 là view, 1 là edit,

  late final String documentId;

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('UserRecord').snapshots();
  Future<QuerySnapshot> getUser() async {
    CollectionReference users =
        FirebaseFirestore.instance.collection('UserRecord');
    return await users.get();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FirstPage(customerInfo: customer)));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      (formState == 0) ? formState = 1 : formState = 0;
                    });
                  },
                  icon: Icon(Icons.edit)),
              IconButton(
                  onPressed: () {
                    // code thực hiện delete ở đây
                  },
                  icon: Icon(Icons.delete)),
            ],
          ),
          FutureBuilder<QuerySnapshot>(
            future: getUser(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }

              if (!snapshot.hasData) {
                return Text("Document does not exist");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                List<CustomerInfo> listCustomer = [];
                List<String> docIds = [];
                snapshot.data!.docs.forEach((element) {
                  docIds.add(element.id);
                  listCustomer.add(CustomerInfo.fromJson(
                      element.data() as Map<String, dynamic>));
                });
                return Expanded(
                  child: ListView(
                    children: List.generate(
                      listCustomer.length,
                      (index) => InfoTab(
                        docId: docIds[index],
                        initCustomerInfo: listCustomer[index],
                        callBack: () {
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                );
              }
              return Text("Loading");
            },
          ),
        ],
      ));
}

class InfoTab extends StatefulWidget {
  const InfoTab({
    Key? key,
    required this.docId,
    required this.initCustomerInfo,
    required this.callBack,
  }) : super(key: key);
  final String docId;
  final CustomerInfo initCustomerInfo;
  final void Function() callBack;

  @override
  _InfoTabState createState() => _InfoTabState();
}

class _InfoTabState extends State<InfoTab> {
  late CustomerInfo e;
  bool showComment = false;
  bool isEdit = false;
  TextEditingController commentController = TextEditingController();

  Future<List<String>?> getInfo(String id) async {
    try {
      var docs = await FirebaseFirestore.instance
          .collection("Comment")
          .where("id", isEqualTo: widget.docId)
          .get();
      List<String> ls = [];
      docs.docs.forEach((element) {
        ls.add(element.data()["content"]);
      });
      print(ls);
      return ls;
    } on FirebaseException catch (e) {
      return ["Error"];
    }
  }

  TextEditingController? fullname;
  TextEditingController? email;
  TextEditingController? country;
  TextEditingController? mobile;
  TextEditingController? monthlyRenPrice;
  TextEditingController? address;
  TextEditingController? nameOfProperty;
  TextEditingController? roomType;
  TextEditingController? furnitureType;
  TextEditingController? propertyType;
  List<TextEditingController>? lsController;
  @override
  void initState() {
    // TODO: implement initState
    e = widget.initCustomerInfo;
    fullname = TextEditingController(text: e.fullname);
    email = TextEditingController(text: e.email);
    country = TextEditingController(text: e.country);
    mobile = TextEditingController(text: e.mobile);
    monthlyRenPrice = TextEditingController(text: e.monthlyRenPrice);
    address = TextEditingController(text: e.address);
    nameOfProperty = TextEditingController(text: e.propertyName);
    roomType = TextEditingController(text: e.roomType);
    furnitureType = TextEditingController(text: e.furnitureType);
    propertyType = TextEditingController(text: e.propertyType);
    lsController = [
      fullname!,
      email!,
      country!,
      mobile!,
      monthlyRenPrice!,
      address!,
      nameOfProperty!,
      roomType!,
      furnitureType!,
      propertyType!,
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey, width: 2),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: (!isEdit)
                    ? Column(
                        children: [
                          Text("fullname: ${e.fullname}"),
                          Text("email: ${e.email}"),
                          Text("country: ${e.country}"),
                          Text("mobile: ${e.mobile}"),
                          Text("monthlyRenPrice: ${e.monthlyRenPrice}"),
                          Text("address : ${e.address}"),
                          Text("nameOfProperty: ${e.propertyName}"),
                          Text("roomType: ${e.roomType}"),
                          Text("furnitureType: ${e.furnitureType}"),
                          Text("propertyType: ${e.propertyType}"),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Column(
                              children: List.generate(
                                  lsController!.length,
                                  (index) => TextField(
                                        controller: lsController![index],
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder()),
                                      ))),
                          CustomButton(
                            onTap: () {
                              FirebaseFirestore.instance
                                  .collection("UserRecord")
                                  .doc(widget.docId)
                                  .set({
                                "fullname": fullname!.text,
                                "email": email!.text,
                                "country": country!.text,
                                "mobile": mobile!.text,
                                "monthlyRenPrice": monthlyRenPrice!.text,
                                "address": address!.text,
                                "nameOfProperty": nameOfProperty!.text,
                                "roomType": roomType!.text,
                                "furnitureType": furnitureType!.text,
                                "propertyType": propertyType!.text,
                              });
                              setState(() {
                                isEdit = !isEdit;
                                widget.callBack();
                              });
                            },
                            buttonTitle: "Save",
                            textStyle: TextStyle(),
                            height: 50,
                          )
                        ],
                      ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isEdit = !isEdit;
                        });
                      },
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection("UserRecord")
                              .doc(widget.docId)
                              .delete();
                          widget.callBack();
                        },
                        icon: Icon(Icons.delete)),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            showComment = !showComment;
                          });
                        },
                        icon: Icon(Icons.comment)),
                  ],
                ),
              ),
            ],
          ),
          (showComment)
              ? Container(
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                                child: TextFormField(
                              controller: commentController,
                            )),
                            IconButton(
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection("Comment")
                                    .add({
                                  "id": "${widget.docId}",
                                  "content": "${commentController.text}"
                                });
                                setState(() {});
                              },
                              icon: Icon(Icons.send),
                            ),
                          ],
                        ),
                      ),
                      Text("Comment"),
                      // load comment
                      FutureBuilder<List<String>?>(
                          future: getInfo(widget.docId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Text("Waiting");
                            }
                            if (snapshot.data!.length == 0) {
                              return Text("No comment here");
                            }
                            if (snapshot.data![0] == "Error") {
                              return Text("Has error");
                            }
                            return Column(
                              children:
                                  snapshot.data!.map((e) => Text(e)).toList(),
                            );
                          }),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
