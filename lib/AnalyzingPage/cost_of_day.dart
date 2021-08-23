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
    final maxWidth = MediaQuery.of(context).size.width;
    final maxHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: maxWidth * 0.0185,
        vertical: maxHeight * 0.0098,
      ), //8
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: maxWidth * 0.0046,
              vertical: maxHeight * 0.0024,
            ), //2
            child: Text(
              '${DateFormat.E().format(DateTime(
                daysOfWeek.year,
                daysOfWeek.month,
                DateTime.monday + widget.index + 1,
              ))}',
              style: TextStyle(
                fontSize: maxHeight * 0.0196,
              ),
            ),
          ),
          Container(
            width: maxWidth * 0.0925,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.orange,
            ),
            child: FittedBox(
              clipBehavior: Clip.hardEdge,
              fit: BoxFit.scaleDown,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: maxWidth * 0.0092,
                  vertical: maxHeight * 0.0049,
                ), //4
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
                      return FittedBox(
                        child: Text(
                          '${getTheCostOfDay(
                            snapshot,
                            widget.index,
                            widget.selectedWeek,
                          )}\$',
                          style: TextStyle(
                              fontSize: maxHeight * 0.0196,
                              fontWeight: FontWeight.bold),
                        ),
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
      if (currentWeekOfMonthCalculator(gatheredDate.toDate()) ==
              widget.selectedWeek &&
          gatheredDate.toDate().weekday == (widget.index + 1)) {
        totalCost += snapshot.data.docs[i].get('expenseCost');
      }
    }
    return totalCost.toString();
  }

  String currentWeekOfMonthCalculator(DateTime date) {
    var currentWeeknum;
    print(8 / 7);
    var weeknum = date.day / 7;
    if (weeknum > 0 && weeknum <= 1) {
      currentWeeknum = 1;
    } else if (weeknum > 1 && weeknum <= 2) {
      currentWeeknum = 2;
    } else if (weeknum > 2 && weeknum <= 3) {
      currentWeeknum = 3;
    } else if (weeknum > 3 && weeknum <= 4) {
      currentWeeknum = 4;
    } else {
      currentWeeknum = 4;
    }
    print('calculated week: W$currentWeeknum');
    return 'W$currentWeeknum';
  }
}
