import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageTextWidget extends StatelessWidget {
  const MessageTextWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;
    var maxHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: maxHeight * 0.0183,
        horizontal: maxWidth * 0.0347,
      ), //15
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.amber[700],
              Colors.amber[500],
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: maxHeight * 0.0122,
            horizontal: maxWidth * 0.0231,
          ), //10
          child: FittedBox(
            child: Text(
              'Please enter your email and password to login or sign up',
              textAlign: TextAlign.center,
              style: GoogleFonts.abel(
                fontSize: maxHeight * 0.0196,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
