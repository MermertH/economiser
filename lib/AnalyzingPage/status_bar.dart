import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StatusBar extends StatelessWidget {
  final int index;
  // final String selectedWeek;
  StatusBar(
    this.index,
    // this.selectedWeek,
  );
  final _userAuth = FirebaseAuth.instance.currentUser;
  final CollectionReference expenses =
      FirebaseFirestore.instance.collection('Expenses');

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    final maxHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: maxWidth * 0.0370),
      child: StreamBuilder<QuerySnapshot>(
          stream: expenses.doc(_userAuth.uid).collection('Expense').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                height: maxHeight * 0.2450,
                width: maxWidth * 0.0462,
              );
            }
            return Container(
              height: maxHeight * 0.2450,
              width: maxWidth * 0.0462,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: 1 - showGraphic(snapshot, index),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  double showGraphic(
    AsyncSnapshot<QuerySnapshot<Object>> snapshot,
    int index,
  ) {
    double totalCostOfDay = 0;
    for (int i = 0; i < snapshot.data.docs.length; i++) {
      Timestamp gatheredDate = snapshot.data.docs[i].get('addingDate');
      if (gatheredDate.toDate().weekday == (index + 1)) {
        totalCostOfDay += snapshot.data.docs[i].get('expenseCost');
      }
    }
    if (getTheCostOfTheMonth(snapshot) == 0) {
      return 0.0;
    } else {
      return totalCostOfDay / getTheCostOfTheMonth(snapshot);
    }
  }

  double getTheCostOfTheMonth(AsyncSnapshot<QuerySnapshot<Object>> snapshot) {
    double totalCostOfMonth = 0;
    for (int i = 0; i < snapshot.data.docs.length; i++) {
      totalCostOfMonth += snapshot.data.docs[i].get('expenseCost');
    }
    return totalCostOfMonth;
  }
}
