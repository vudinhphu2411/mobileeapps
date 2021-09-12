import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentalz/models/Customer%20infor/customer_infor.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    Key? key,
    required this.onTap,
    required this.buttonTitle,
    required this.textStyle,
    required this.height,
    this.customerInfo,
  }) : super(key: key);
  final void Function() onTap;
  final String buttonTitle;
  final TextStyle textStyle;
  final double height;
  final CustomerInfo? customerInfo;
  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  late CustomerInfo customer = new CustomerInfo();
  final db = FirebaseFirestore.instance;
  @override
  @override
  void initState() {
    customer = new CustomerInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container(
              child: Center(
                child: Text('Eror'),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              height: widget.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [Color(0xFFF8A170), Color(0xFFFFCD61)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              // ignore: deprecated_member_use
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    widget.buttonTitle,
                    style: widget.textStyle,
                  ),
                ),
                onPressed: () {
                  widget.onTap();
                },
              ),
            );
          }

          return Container(
              child: Center(
            child: Text('Loading'),
          ));
        },
      ),
    );
  }
}
