import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:economiser/PopUps/salary_added.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class CurrentBudget extends StatefulWidget {
  @override
  State<CurrentBudget> createState() => _CurrentBudgetState();
}

class _CurrentBudgetState extends State<CurrentBudget> {
  final Stream<QuerySnapshot> _budgetStream =
      FirebaseFirestore.instance.collection('Budget').snapshots();
  CollectionReference budgetRefference =
      FirebaseFirestore.instance.collection('Budget');
  CollectionReference income = FirebaseFirestore.instance.collection('Income');
  final Stream<QuerySnapshot> _incomeStream =
      FirebaseFirestore.instance.collection('Income').snapshots();
  Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 32), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                'current budget',
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
                    stream: _incomeStream,
                    builder: (context, incomeSnapshot) {
                      if (incomeSnapshot.hasError) {
                        return Text('Something went wrong');
                      }
                      if (incomeSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return FittedBox(
                          fit: BoxFit.scaleDown,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.black,
                          ),
                        );
                      }
                      return StreamBuilder<QuerySnapshot>(
                        stream: _budgetStream,
                        builder: (context, budgetSnapshot) {
                          if (budgetSnapshot.hasError) {
                            return Text('Something went wrong');
                          }
                          if (budgetSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return FittedBox(
                              fit: BoxFit.scaleDown,
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.black,
                              ),
                            );
                          }

                          //monthlyIncome(budgetSnapshot, income, incomeSnapshot);

                          return Text(
                            budgetSnapshot.data.docs.isNotEmpty
                                ? '${budgetSnapshot.data.docs.first['currentBudget']}\$'
                                : '0\$',
                            style: TextStyle(fontSize: 18),
                          );
                        },
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

  Future<void> monthlyIncome(
      AsyncSnapshot<QuerySnapshot<Object>> budgetSnapshot,
      CollectionReference<Object> income,
      AsyncSnapshot<QuerySnapshot<Object>> incomeSnapshot) async {
    Timestamp addingDate = await income.get().then((querySnapshot) {
      return querySnapshot.docs.first['monthlySalaryDate'];
    });
    print('current date: ${Jiffy().dateTime}');
    //print(Jiffy(addingDate.toDate()).add(minutes: 28).dateTime);
    print(
        'time left for salary date: ${Jiffy(addingDate.toDate()).add(minutes: 1).dateTime.difference(Jiffy().dateTime)}');

    if (Jiffy(addingDate.toDate())
        .add(minutes: 1)
        .dateTime
        .difference(Jiffy().dateTime)
        .isNegative) {
      income.doc(incomeSnapshot.data.docs.first.id).update({
        'monthlySalaryDate':
            Jiffy(addingDate.toDate()).add(minutes: 1).dateTime,
      });
      budgetRefference.doc(budgetSnapshot.data.docs.first.id).update({
        'currentBudget':
            FieldValue.increment(await income.get().then((querySnapshot) {
          return querySnapshot.docs.first['income'];
        })),
        'extraBudgetAddingDate': DateTime.now(),
      });
      print('Income is added Successfully');
      showDialog(
        context: context,
        builder: (context) => SalaryAddedDialog(),
      );
    }
  }
}
