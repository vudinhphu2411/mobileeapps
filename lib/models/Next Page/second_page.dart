import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rentalz/models/Customer%20infor/customer_infor.dart';
import 'package:rentalz/models/bottom%20tab%201/bottom_tab_1.dart';
import 'package:rentalz/models/bottom%20tab%202/bottom_tab_2.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({
    Key? key,
    required this.customerInfo,
    required this.check,
    required this.check1,
    required this.check2,
    this.callBack,
  }) : super(key: key);
  final CustomerInfo customerInfo;
  final bool check;
  final bool check1;
  final bool check2;
  final void Function()? callBack;
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final customer = CustomerInfo();
  final fb = Firebase.initializeApp();

  final db = FirebaseFirestore.instance;

  int _currentIndex = 0;
  final List<Widget> tabs = [
    BottomTab1(
      customerInfo: CustomerInfo(),
    ),
    BottomTab2(
      customerInfo: CustomerInfo(),
      searchString: '',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            // ignore: deprecated_member_use
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            // ignore: deprecated_member_use
            title: Text('Search'),
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
