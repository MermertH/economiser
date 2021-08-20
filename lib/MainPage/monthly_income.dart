import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MonthlyIncome extends StatelessWidget {
  final CollectionReference income =
      FirebaseFirestore.instance.collection('Income');

  @override
  Widget build(BuildContext context) {
    var _userAuth = FirebaseAuth.instance.currentUser;
    return Container(
      margin: EdgeInsets.only(right: 40),
      height: 80,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Monthly Income',
                style: TextStyle(fontSize: 18),
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
                      return Text(
                        snapshot.data.docs
                                .any((doc) => doc.id == _userAuth.uid)
                            ? '${snapshot.data.docs.firstWhere((doc) => doc.id == _userAuth.uid).get('income')}\$'
                            : '0\$',
                        style: TextStyle(fontSize: 18),
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
