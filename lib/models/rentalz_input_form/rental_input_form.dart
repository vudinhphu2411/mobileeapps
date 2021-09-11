import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rentalz/constraint.dart';
import 'package:rentalz/models/Customer%20infor/customer_infor.dart';
import 'package:rentalz/widgets/back_button_and_title.dart';
import 'package:rentalz/widgets/custom_buttom/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({
    required this.customerInfo,
  }) : super();
  final CustomerInfo customerInfo;

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  var keyForm = GlobalKey<FormState>();
  var price = TextEditingController();
  var notes = TextEditingController();
  var address = TextEditingController();
  var propertyName = TextEditingController();
  var fullname = TextEditingController();
  var email = TextEditingController();
  var country = TextEditingController();
  var mobile = TextEditingController();
  String dropDownValue = "Select your Property Type";
  String dropDownRoomValue = "Select your Room Type";
  String dropDownFurnitureValue = "Select your Furniture Types";
  bool check = false;
  bool check1 = false;
  bool check2 = false;

  final fb = Firebase.initializeApp();

  final db = FirebaseFirestore.instance;

  String? valueChoose;
  List listItem = ["Flat", "House", "Bungalow"];

  String? valueSelectRoomType;
  List listRoomItem = [
    "Studio",
    "Single bed room (SGL)",
    "Twin bed room (TWN)",
    "Double bed room (DBL)",
    "Triple bed room (TRPL)"
  ];

  String? valueFurniture;
  List listFurnitureItem = ["Furnished", "Unfurnished", "Part Furnished"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BackButtonAndTitle(title: "RentalZ"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 25,
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView(
                  children: [
                    Form(
                      key: keyForm,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(0),
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
                          SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.all(0),
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
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0),
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
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null)
                                return "Fill your Property's Name";
                              if (value.isEmpty) {
                                return "Fill your Property's Name";
                              }
                            },
                            controller: propertyName,
                            decoration: InputDecoration(
                              labelStyle: Constraint.Nunito(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                              labelText: "Name of the Property",
                              fillColor: Colors.white70,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(width: 0),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            validator: (value) {
                              if (value == null) return "Fill your Price";
                              if (value.isEmpty) {
                                return "Fill your Price";
                              }
                            },
                            controller: price,
                            decoration: InputDecoration(
                              labelStyle: Constraint.Nunito(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                              labelText: "Price",
                              fillColor: Colors.white70,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(width: 0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null) return "Fill your full name";
                              if (value.isEmpty) {
                                return "Fill your full name";
                              }
                            },
                            controller: fullname,
                            decoration: InputDecoration(
                              labelStyle: Constraint.Nunito(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                              labelText: "Full Name",
                              fillColor: Colors.white70,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(width: 0),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            validator: (value) {
                              if (value == null) return "Fill your Address";
                              if (value.isEmpty) {
                                return "Fill your Address";
                              }
                            },
                            controller: address,
                            decoration: InputDecoration(
                              labelStyle: Constraint.Nunito(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                              labelText: "Address",
                              fillColor: Colors.white70,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(width: 0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null) return "Fill your Email";
                              if (value.isEmpty) {
                                return "Fill your Email Address";
                              }
                              if (!RegExp(
                                      r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                  .hasMatch(value)) {
                                return 'Please enter a valid Email Address';
                              }
                            },
                            controller: email,
                            decoration: InputDecoration(
                              labelText: "Email Address",
                              labelStyle: Constraint.Nunito(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                              fillColor: Colors.white70,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(width: 0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null) return "Fill your country";
                              if (value.isEmpty) {
                                return "Fill your country";
                              }
                            },
                            controller: country,
                            decoration: InputDecoration(
                              labelStyle: Constraint.Nunito(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                              labelText: "Country",
                              fillColor: Colors.white70,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(width: 0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null)
                                return "Fill your phone number";
                              if (value.isEmpty) {
                                return "Fill your mobile";
                              }
                            },
                            controller: mobile,
                            decoration: InputDecoration(
                              labelStyle: Constraint.Nunito(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                              labelText: "Mobile",
                              fillColor: Colors.white70,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(width: 0),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            controller: notes,
                            decoration: InputDecoration(
                              labelStyle: Constraint.Nunito(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                              labelText: "Notes",
                              fillColor: Colors.white70,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(width: 0),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              CustomButton(
                onTap: () {
                  if (dropDownValue == "Select your Property Type") {
                    setState(() {
                      check = true; // check 1 true
                    });
                  }
                  if (dropDownRoomValue == "Select your Room Type") {
                    setState(() {
                      check1 = true; // check true
                    });
                  }
                  if (dropDownFurnitureValue == "Select your Furniture Types") {
                    setState(() {
                      check2 = false;
                    });
                  }
                  keyForm.currentState!.validate();
                  var finalFurnitureValue;
                  if (dropDownFurnitureValue == "Select your Furniture Types")
                    finalFurnitureValue = null;
                  else
                    finalFurnitureValue = dropDownFurnitureValue;
                  if (dropDownValue != "Select your Property Type" &&
                      dropDownRoomValue != "Select your Room Type" &&
                      keyForm.currentState!.validate()) {
                    var customer = CustomerInfo(
                      fullname: fullname.value.text,
                      monthlyRenPrice: price.value.text,
                      email: email.value.text,
                      country: country.value.text,
                      mobile: mobile.value.text,
                      dateTime: DateTime.now(),
                      address: address.value.text,
                      propertyName: propertyName.value.text,
                      propertyType: dropDownValue,
                      roomType: dropDownRoomValue,
                      furnitureType: finalFurnitureValue,
                      notes: notes.value.text,
                    );
                    db.collection('UserRecord').add({
                      'fullname': customer.fullname,
                      'monthlyRenPrice': customer.monthlyRenPrice,
                      'email': customer.email,
                      'country': customer.country,
                      'mobile': customer.mobile,
                      'dateTime': customer.dateTime,
                      'address': customer.address,
                      'propertyName': customer.propertyName,
                      'propertyType': dropDownValue,
                      'roomType': dropDownRoomValue,
                      'furnitureType': finalFurnitureValue,
                      'notes': customer.notes,
                    });

                    Navigator.pop(context);
                  }
                },
                buttonTitle: "Complete",
                textStyle: Constraint.Nunito(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                height: 65,
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
