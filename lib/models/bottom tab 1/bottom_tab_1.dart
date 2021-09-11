import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rentalz/models/Customer%20infor/customer_infor.dart';
import 'package:rentalz/models/rentalz_input_form/rental_input_form.dart';

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
          FutureBuilder<QuerySnapshot>(
            future: users.get(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }

              if (!snapshot.hasData) {
                print(snapshot.error);
                snapshot.data!.docs.forEach((QueryDocumentSnapshot doc) {
                  print(doc.data());
                });
                print(documentId);
                return Text("Document does not exist");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                List<CustomerInfo> listCustomer = [];
                snapshot.data!.docs.forEach((element) {
                  listCustomer.add(CustomerInfo.fromJson(
                      element.data() as Map<String, dynamic>));
                });
                return Expanded(
                  child: Column(
                    children: listCustomer
                        .map((e) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border:
                                    Border.all(color: Colors.grey, width: 2),
                              ),
                              child: Column(
                                children: [
                                  Text("fullname: ${e.fullname}"),
                                  Text("email: ${e.email}"),
                                  Text("country: ${e.country}"),
                                  Text("mobile: ${e.mobile}"),
                                  Text("monthlyRenPrice: ${e.monthlyRenPrice}"),
                                  Text("address : ${e.address}"),
                                  // Text("dateTime: ${e.dateTime}"),
                                  Text("nameOfProperty: ${e.propertyName}"),
                                  Text("roomType: ${e.roomType}"),
                                  Text("furnitureType: ${e.furnitureType}"),
                                  Text("propertyType: ${e.propertyType}"),
                                  SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                );
              }
              return Text("Loading");
            },
          ),
        ],
      ));
}
