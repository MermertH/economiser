import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MonthlyIncome extends StatelessWidget {
  final CollectionReference income =
      FirebaseFirestore.instance.collection('Income');

  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;
    var maxHeight = MediaQuery.of(context).size.height;
    var _userAuth = FirebaseAuth.instance.currentUser;
    return Container(
      margin: EdgeInsets.only(right: maxWidth * 0.0925),
      height: maxHeight * 0.0980,
      child: Container(
        padding: EdgeInsets.all(maxWidth * 0.0231),
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: FittedBox(
                child: Expanded(
                  child: Text(
                    'Monthly Income',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                ),
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: income.snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return FittedBox(
                          fit: BoxFit.scaleDown,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.black,
                          ),
                        );
                      }
                      return FittedBox(
                        child: Text(
                          snapshot.data.docs
                                  .any((doc) => doc.id == _userAuth.uid)
                              ? '${snapshot.data.docs.firstWhere((doc) => doc.id == _userAuth.uid).get('income')}\$'
                              : '0\$',
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    },
                  ),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
