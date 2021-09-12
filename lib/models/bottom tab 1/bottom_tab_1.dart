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
                  icon: Icon(Icons.refresh)),
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
  // cai khung o day nha a
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
      // ignore: unused_catch_clause
    } on FirebaseException catch (e) {
      return ["Error"];
    }
  }

  late String dropDownValue;
  late String dropDownRoomValue;
  late String dropDownFurnitureValue;
  late String districtDropdowValue;
  bool check = false;
  bool check1 = false;
  bool check2 = false;
  bool districtCheck = false;

  List listItem = ["Flat", "House", "Bungalow"];

  TextEditingController? fullname;
  TextEditingController? email;
  TextEditingController? country;
  TextEditingController? mobile;
  TextEditingController? monthlyRenPrice;
  TextEditingController? nameOfProperty;
  TextEditingController? notes;
  List<TextEditingController>? lsController;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    e = widget.initCustomerInfo;
    fullname = TextEditingController(text: e.fullname);
    email = TextEditingController(text: e.email);
    country = TextEditingController(text: e.country);
    mobile = TextEditingController(text: e.mobile);
    monthlyRenPrice = TextEditingController(text: e.monthlyRenPrice);
    nameOfProperty = TextEditingController(text: e.propertyName);
    notes = TextEditingController(text: e.notes);
    dropDownValue = e.propertyType!;
    dropDownRoomValue = e.roomType!;
    dropDownFurnitureValue = e.furnitureType!;
    districtDropdowValue = e.address!;
    lsController = [
      fullname!,
      email!,
      country!,
      mobile!,
      monthlyRenPrice!,
      nameOfProperty!,
      notes!,
    ];
    super.initState();
  }

  List<String> label = [
    "Fullname",
    "Email",
    "Country",
    "Mobile",
    "Monthly Rent Price",
    "Name of Property",
    "Note",
  ];

  List listFurnitureItem = ["Furnished", "Unfurnished", "Part Furnished"];
  List district = [
    "An Giang",
    "Bà Rịa – Vũng Tàu",
    "Bạc Liêu",
    "Bắc Giang",
    "Bắc Kạn",
    "Bắc Ninh",
    "Bến Tre",
    "Bình Dương",
    "Bình Định",
    "Bình Phước",
    "Bình Thuận",
    "Cà Mau",
    "Cao Bằng",
    "Cần Thơ",
    "Đà Nẵng",
    "Đắk Lắk",
    "Đắk Nông",
    "Điện Biên",
    "Đồng Nai",
    "Đồng Tháp",
    "Gia Lai",
    "Hà Giang",
    "Hà Nam",
    "Hà Nội",
    "Hà Tĩnh",
    "Hải Dương",
    "Hải Phòng",
    "Hậu Giang",
    "Hòa Bình",
    "Thành phố Hồ Chí Minh",
    "Hưng Yên",
    "Khánh Hòa",
    "Kiên Giang",
    "Kon Tum",
    "Lai Châu",
    "Lạng Sơn",
    "Lào Cai",
    "Lâm Đồng",
    "Long An",
    "Nam Định",
    "Nghệ An",
    "Ninh Bình",
    "Ninh Thuận",
    "Phú Thọ",
    "Phú Yên",
    "Quảng Bình",
    "Quảng Nam",
    "Quảng Ngãi",
    "Quảng Ninh",
    "Quảng Trị",
    "Sóc Trăng",
    "Sơn La",
    "Tây Ninh",
    "Thái Bình",
    "Thái Nguyên",
    "Thanh Hóa",
    "Thừa Thiên Huế",
    "Tiền Giang",
    "Trà Vinh",
    "Tuyên Quang",
    "Vĩnh Long",
    "Vĩnh Phúc",
  ];

  List listRoomItem = [
    "Studio",
    "Single bed room (SGL)",
    "Twin bed room (TWN)",
    "Double bed room (DBL)",
    "Triple bed room (TRPL)"
  ];

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
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Full Name: ${e.fullname}"),
                                Text("Email: ${e.email}"),
                                Text("Country: ${e.country}"),
                                Text("Mobile: ${e.mobile}"),
                                Text(
                                    "Monthly Rent Price: ${e.monthlyRenPrice}"),
                                Text("Property's Address : ${e.address}"),
                                Text("Property's Name: ${e.propertyName}"),
                                Text("Room Type: ${e.roomType}"),
                                Text("Furniture's Type: ${e.furnitureType}"),
                                Text("Property' Type: ${e.propertyType}"),
                                Text("Note: ${e.notes}"),
                                SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : Column(
                        children: [
                          Column(
                              children: List.generate(
                                  lsController!.length,
                                  (index) => Column(
                                        children: [
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 16, right: 16),
                                            child: TextField(
                                              controller: lsController![index],
                                              decoration: InputDecoration(
                                                labelText: label[index],
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(16),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ))),
                          SizedBox(
                            height: 11,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 17,
                              horizontal: 15,
                            ),
                            child: Container(
                              padding: EdgeInsets.only(left: 16, right: 16),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1.4),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: DropdownButton(
                                hint: (check)
                                    ? Text("You need to choose",
                                        style: TextStyle(
                                          color: Colors.red,
                                        ))
                                    : Text(dropDownValue),
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                                dropdownColor: Colors.white,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 30,
                                isExpanded: true,
                                underline: SizedBox(),
                                // value: dropDownValue,
                                onChanged: (newValue) {
                                  setState(() {
                                    check = false;
                                    dropDownValue = newValue.toString();
                                  });
                                },
                                items: listItem.map((valueItem1) {
                                  return DropdownMenuItem(
                                    value: valueItem1,
                                    child: Text(valueItem1),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 17,
                              horizontal: 15,
                            ),
                            child: Container(
                              padding: EdgeInsets.only(left: 16, right: 16),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1.4),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: DropdownButton(
                                hint: (check1)
                                    ? Text("You need to choose",
                                        style: TextStyle(
                                          color: Colors.red,
                                        ))
                                    : Text(dropDownRoomValue),
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                                dropdownColor: Colors.white,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 30,
                                isExpanded: true,
                                underline: SizedBox(),
                                // value: dropDownRoomValue,
                                onChanged: (newValue) {
                                  setState(() {
                                    check1 = false;
                                    dropDownRoomValue = newValue.toString();
                                  });
                                },
                                items: listRoomItem.map((valueItem2) {
                                  return DropdownMenuItem(
                                    value: valueItem2,
                                    child: Text(valueItem2),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 17,
                              horizontal: 10,
                            ),
                            child: Container(
                              padding: EdgeInsets.only(left: 16, right: 16),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1.4),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: DropdownButton(
                                hint: (check2)
                                    ? Text("You need to choose",
                                        style: TextStyle(
                                          color: Colors.red,
                                        ))
                                    : Text(dropDownFurnitureValue),
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                                dropdownColor: Colors.white,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 30,
                                isExpanded: true,
                                underline: SizedBox(),
                                // value: dropDownValue,
                                onChanged: (newValue) {
                                  setState(() {
                                    check2 = false;
                                    dropDownFurnitureValue =
                                        newValue.toString();
                                  });
                                },
                                items: listFurnitureItem.map((valueItem3) {
                                  return DropdownMenuItem(
                                    value: valueItem3,
                                    child: Text(valueItem3),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 17,
                              horizontal: 10,
                            ),
                            child: Container(
                              padding: EdgeInsets.only(left: 16, right: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border:
                                    Border.all(color: Colors.grey, width: 1.5),
                              ),
                              child: DropdownButton(
                                hint: (districtCheck)
                                    ? Text("You need to choose",
                                        style: TextStyle(
                                          color: Colors.red,
                                        ))
                                    : Text(districtDropdowValue),
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                                dropdownColor: Colors.white,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 30,
                                isExpanded: true,
                                underline: SizedBox(),
                                // value: dropDownValue,
                                onChanged: (newValue) {
                                  setState(() {
                                    districtCheck = false;
                                    districtDropdowValue = newValue.toString();
                                  });
                                },
                                items: district.map((valueItem1) {
                                  return DropdownMenuItem(
                                    value: valueItem1,
                                    child: Text(valueItem1),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 17,
                              horizontal: 10,
                            ),
                            child: CustomButton(
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
                                  "notes": notes!.text,
                                  "address": districtDropdowValue,
                                  "nameOfProperty": nameOfProperty!.text,
                                  "roomType": dropDownRoomValue,
                                  "furnitureType": dropDownFurnitureValue,
                                  "propertyType": dropDownValue,
                                });
                                setState(() {
                                  isEdit = !isEdit;
                                  widget.callBack();
                                });
                              },
                              buttonTitle: "Save",
                              textStyle: TextStyle(),
                              height: 50,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
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
