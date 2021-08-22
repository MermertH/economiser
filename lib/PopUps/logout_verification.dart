import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogoutVerificationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   //var maxWidth = MediaQuery.of(context).size.width;
    var maxHeight = MediaQuery.of(context).size.height;
    return Dialog(
      backgroundColor: Colors.amber,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: maxHeight * 0.3676,
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
                        radius: maxHeight * 0.0735,
                        child: Icon(
                          Icons.no_accounts_rounded,
                          size: maxHeight * 0.0735,
                        ),
                      ),
                    ),
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Are you sure that you want to logout?',
                        style: TextStyle(fontSize: maxHeight * 0.0220),
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
                          fontSize: maxHeight * 0.0196,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: FittedBox(child: Text('Cancel')),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                        primary: Colors.black,
                        textStyle: TextStyle(
                          fontSize: maxHeight * 0.0196,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.of(context).pop(true);
                    },
                    child: FittedBox(child: Text('Logout')),
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
