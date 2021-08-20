import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CostOfDay extends StatefulWidget {
  final int index;
  final String selectedWeek;
  CostOfDay(
    this.index,
    this.selectedWeek,
  );
  @override
  State<CostOfDay> createState() => _CostOfDayState();
}

class _CostOfDayState extends State<CostOfDay> {
  final CollectionReference expenseCosts =
      FirebaseFirestore.instance.collection('Expenses');
      var _userAuth = FirebaseAuth.instance.currentUser;
  final daysOfWeek = DateTime.now();
  bool isExist;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text('${DateFormat.E().format(DateTime(
              daysOfWeek.year,
              daysOfWeek.month,
              DateTime.monday + widget.index + 1,
            ))}'),
          ),
          Container(
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.orange,
            ),
            child: FittedBox(
              clipBehavior: Clip.hardEdge,
              fit: BoxFit.scaleDown,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: StreamBuilder<QuerySnapshot>(
                    stream: expenseCosts
                        .doc(_userAuth.uid)
                        .collection('Expense')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return FittedBox(
                          fit: BoxFit.cover,
                          clipBehavior: Clip.hardEdge,
                          child: Text('...'),
                        );
                      }
                      return Text(
                        '${getTheCostOfDay(
                          snapshot,
                          widget.index,
                          widget.selectedWeek,
                        )}\$',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      );
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getTheCostOfDay(AsyncSnapshot<QuerySnapshot<Object>> snapshot,
      int index, String selectedWeek) {
    var totalCost = 0;
    for (int i = 0; i < snapshot.data.docs.length; i++) {
      Timestamp gatheredDate = snapshot.data.docs[i].get('addingDate');
      if (DateFormat.QQQ().format(gatheredDate.toDate()) ==
              widget.selectedWeek &&
          gatheredDate.toDate().weekday == (widget.index + 1)) {
        totalCost += snapshot.data.docs[i].get('expenseCost');
      }
    }
    return totalCost.toString();
  }
}
