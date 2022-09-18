import 'package:economiser/AuthScreen/widgets/circle_avatar_widget.dart';
import 'package:economiser/AuthScreen/widgets/message_text_widget.dart';
import 'package:economiser/AuthScreen/widgets/user_input_form_area.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthenticationPage extends StatefulWidget {
  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  @override
  Widget build(BuildContext context) {
    var maxHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.orange[200],
                Colors.amber[400],
                Colors.orange[200],
              ],
            ),
          ),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.amber[700],
                      Colors.amber[500],
                    ],
                  ),
                ),
              ),
              title: Text(
                'Welcome To Economiser'.toUpperCase(),
                style: GoogleFonts.abel(
                  fontSize: maxHeight * 0.0306,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              elevation: 0,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatarWidget(),
                UserInputFormArea(),
                MessageTextWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
