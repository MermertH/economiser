import 'package:flutter/material.dart';

class AppLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var maxWidth = MediaQuery.of(context).size.width;
    var maxHeight = MediaQuery.of(context).size.height;
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: maxHeight * 0.1102),
        height: maxHeight * 0.0735,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Center(
          child: Text(
            "ECONOMISER",
            style: TextStyle(
                fontSize: maxHeight * 0.0490,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800]),
          ),
        ),
      ),
    );
  }
}
