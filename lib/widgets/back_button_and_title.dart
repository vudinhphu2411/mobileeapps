import 'package:flutter/material.dart';
import 'package:rentalz/constraint.dart';

class BackButtonAndTitle extends StatelessWidget {
  const BackButtonAndTitle({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: EdgeInsets.only(
        top: 15,
        bottom: 15,
      ),
      padding: EdgeInsets.only(
        left: 0,
        right: 46,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            child: Container(
              height: 30,
              child: Icon(
                Icons.arrow_back_ios,
                size: 30,
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          SizedBox(
            width: 18,
          ),
          Expanded(child: Center(
            child: Text(
                "$title",
                style: Constraint.Nunito(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ),
          ),
        ],
      ),
    );
  }
}
