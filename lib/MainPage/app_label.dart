import 'package:flutter/material.dart';

class AppLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 90),
        height: 60,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          // borderRadius: BorderRadius.only(
          //   topLeft: Radius.circular(14),
          //   topRight: Radius.circular(14),
          //   bottomLeft: Radius.circular(14),
          //   bottomRight: Radius.circular(14),
          // ),
        ),
        child: Center(
          child: Text(
            "ECONOMISER",
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800]),
          ),
        ),
      ),
    );
  }
}
