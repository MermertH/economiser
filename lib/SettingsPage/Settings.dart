import 'package:economiser/main.dart';

import '/PopUps/logout_verification.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;
    var maxHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(fontSize: maxHeight * 0.0294),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: maxWidth * 0.0347,
                vertical: maxHeight * 0.0183,
              ),
              child: TextButton(
                onPressed: () {
                  showDialog(
                          context: context,
                          builder: (context) => LogoutVerificationDialog())
                      .then((value) {
                    if (value == true) {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => MyApp()));
                    }
                  });
                },
                child: FittedBox(child: const Text('Logout')),
                style: TextButton.styleFrom(
                    primary: Colors.black,
                    backgroundColor: Colors.amber,
                    shape: const BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                    ),
                    textStyle: TextStyle(fontSize: maxHeight * 0.0306),
                    fixedSize: Size(maxWidth * 0.4629, maxHeight * 0.0612)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
