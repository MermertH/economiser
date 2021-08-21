import 'package:economiser/main.dart';

import '/PopUps/logout_verification.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
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
                child: const Text('Logout'),
                style: TextButton.styleFrom(
                    primary: Colors.black,
                    backgroundColor: Colors.amber,
                    shape: const BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                    ),
                    textStyle: const TextStyle(fontSize: 25),
                    fixedSize: Size(200, 50)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
