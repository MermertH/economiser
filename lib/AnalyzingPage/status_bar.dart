import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StatusBar extends StatelessWidget {
  final int index;
  final String selectedWeek;
  StatusBar(
    this.index,
    this.selectedWeek,
  );
  final _userAuth = FirebaseAuth.instance.currentUser;
  final CollectionReference expenses =
      FirebaseFirestore.instance.collection('Expenses');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: StreamBuilder<QuerySnapshot>(
          stream: expenses.doc(_userAuth.uid).collection('Expense').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                height: 200,
                width: 20,
              );
            }
            return Container(
              height: 200,
              width: 20,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor:
                        1 - showGraphic(snapshot, index, selectedWeek),
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

  double showGraphic(AsyncSnapshot<QuerySnapshot<Object>> snapshot, int index,
      String selectedWeek) {
    double totalCostOfDay = 0;
    for (int i = 0; i < snapshot.data.docs.length; i++) {
      Timestamp gatheredDate = snapshot.data.docs[i].get('addingDate');
      if (DateFormat.QQQ().format(gatheredDate.toDate()) == selectedWeek &&
          gatheredDate.toDate().weekday == (index + 1)) {
        totalCostOfDay += snapshot.data.docs[i].get('expenseCost');
      }
    }
    if (totalCostOfCurrentWeek(snapshot, selectedWeek) == 0) {
      return 0.0;
    } else {
      return totalCostOfDay / totalCostOfCurrentWeek(snapshot, selectedWeek);
    }
  }

  double totalCostOfCurrentWeek(
      AsyncSnapshot<QuerySnapshot<Object>> snapshot, String selectedWeek) {
    double totalCostOfWeek = 0;
    for (int i = 0; i < snapshot.data.docs.length; i++) {
      Timestamp gatheredDate = snapshot.data.docs[i].get('addingDate');
      if (DateFormat.QQQ().format(gatheredDate.toDate()) == selectedWeek) {
        totalCostOfWeek += snapshot.data.docs[i].get('expenseCost');
      }
    }
    return totalCostOfWeek;
  }
}
