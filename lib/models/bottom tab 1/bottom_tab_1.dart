import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rentalz/models/Customer%20infor/customer_infor.dart';
import 'package:rentalz/models/rentalz_input_form/rental_input_form.dart';

class BottomTab1 extends StatefulWidget {
  const BottomTab1({
    required this.customerInfo,
    required this.documentId,
  }) : super();
  final CustomerInfo customerInfo;
  final String documentId;
  @override
  _BottomTab1State createState() => _BottomTab1State();
}

class _BottomTab1State extends State<BottomTab1> {
  final customer = CustomerInfo();
  int formState = 0; // 0 là view, 1 là edit,

  late final String documentId;
  @override
  void initState() {
    super.initState();
    // ignore: unnecessary_statements
    documentId = widget.documentId;
  }

  final fb = Firebase.initializeApp();
  final db = FirebaseFirestore.instance;
  CollectionReference users =
      FirebaseFirestore.instance.collection('UserRecord');
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('UserRecord').snapshots();

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
          FutureBuilder<DocumentSnapshot>(
            future: users.doc(documentId).get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }

              if (snapshot.hasData && !snapshot.data!.exists) {
                print(snapshot.error);
                print(snapshot.data!.data());
                print(documentId);
                return Text("Document does not exist");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                List<String> field =
                    []; // khai báo mảng để lấy thông tin các trường
                List<String> content =
                    []; // khai báo mang để nhận thông tin nội dung của các trường
                data.forEach((key, value) {
                  // data là một cái Map nên mình có thể forEach qua từng phần tử và lấy thông tin của trường thông qua key và nội dung của trường thông qua value
                  if (key != "dateTime") {
                    field.add(key); // lấy thông tin trường thông qua key
                    content.add(
                        value); // lấy nội dung của trường đó thông qua value
                  }
                });
                return Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                        field.length,
                        (index) => (formState == 0)
                            ? Text("${field[index]} : ${content[index]}")
                            : Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Text("${field[index]}")),
                                    Expanded(
                                        flex: 3,
                                        child: TextFormField(
                                          controller: TextEditingController(
                                              text: content[index]),
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder()),
                                        )),
                                  ],
                                ),
                              )),
                    // mình trả về column với children là list các Text hiển thị field : content
                  ),
                );
              }

              return Text("loading");
            },
          ),
        ],
      ));
}
