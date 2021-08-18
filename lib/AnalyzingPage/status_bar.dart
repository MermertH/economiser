import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StatusBar extends StatefulWidget {
  final int index;
  final String selectedWeek;
  StatusBar(
    this.index,
    this.selectedWeek,
  );
  @override
  State<StatusBar> createState() => _StatusBarState();
}

class _StatusBarState extends State<StatusBar> {
  final Stream<QuerySnapshot> _expenseCosts = FirebaseFirestore.instance
      .collection('Expenses')
      .doc("jHu5OmDL8OVt9kVGI7Wl")
      .collection('Expense')
      .snapshots();

  var rng = new Random();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 200,
        width: 20,
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                // border: Border.all(color: Colors.white, width: 1.0),
                color: Colors.red,
                //borderRadius: BorderRadius.circular(10),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
                stream: _expenseCosts,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text('');
                  }
                  return FractionallySizedBox(
                    heightFactor: 1 -
                        showGraphic(
                            snapshot, widget.index, widget.selectedWeek),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }

  double showGraphic(AsyncSnapshot<QuerySnapshot<Object>> snapshot, int index,
      String selectedWeek) {
    double totalCostOfDay = 0;
    for (int i = 0; i < snapshot.data.docs.length; i++) {
      Timestamp gatheredDate = snapshot.data.docs[i].get('addingDate');
      if (DateFormat.QQQ().format(gatheredDate.toDate()) ==
              widget.selectedWeek &&
          gatheredDate.toDate().weekday == (widget.index + 1)) {
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
      if (DateFormat.QQQ().format(gatheredDate.toDate()) ==
          widget.selectedWeek) {
        totalCostOfWeek += snapshot.data.docs[i].get('expenseCost');
      }
    }
    return totalCostOfWeek;
  }
}
