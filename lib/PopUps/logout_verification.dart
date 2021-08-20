import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogoutVerificationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.amber,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FittedBox(
                      fit: BoxFit.fitHeight,
                      clipBehavior: Clip.hardEdge,
                      child: CircleAvatar(
                        backgroundColor: Colors.amber[200],
                        radius: 60,
                        child: Icon(
                          Icons.no_accounts_rounded,
                          size: 60,
                        ),
                      ),
                    ),
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Are you sure that you want to logout?',
                        style: TextStyle(fontSize: 18),
                      ),
                    )),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                        primary: Colors.black,
                        textStyle: TextStyle(
                          fontSize: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text('Cancel'),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                        primary: Colors.black,
                        textStyle: TextStyle(
                          fontSize: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.of(context).pop(true);
                    },
                    child: Text('Logout'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
