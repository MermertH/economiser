import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:economiser/PopUps/salary_added.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class CurrentBudget extends StatefulWidget {
  @override
  State<CurrentBudget> createState() => _CurrentBudgetState();
}

class _CurrentBudgetState extends State<CurrentBudget> {
  CollectionReference budgetRefference =
      FirebaseFirestore.instance.collection('Budget');
  CollectionReference income = FirebaseFirestore.instance.collection('Income');
  var _userAuth = FirebaseAuth.instance.currentUser;
  var datetime = new Jiffy();

  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;
    var maxHeight = MediaQuery.of(context).size.height;
    return Container(
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
            Expanded(
              child: Text(
                'current budget',
                style: TextStyle(fontSize: maxHeight * 0.0220),
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
                  padding:
                      EdgeInsets.symmetric(horizontal: maxWidth * 0.0231), //10
                  child: StreamBuilder<QuerySnapshot>(
                    stream: income.snapshots(),
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
                        stream: budgetRefference.snapshots(),
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
                          if (incomeSnapshot.data.docs
                                  .any((doc) => doc.id == _userAuth.uid) ==
                              false) {
                            print('check is successful');
                            // if there is no income, then do not start monthly income function,
                          } else {
                            monthlyIncome(
                                budgetSnapshot, income, incomeSnapshot);
                          }
                          return Text(
                            budgetSnapshot.data.docs
                                    .any((doc) => doc.id == _userAuth.uid)
                                ? '${budgetSnapshot.data.docs.firstWhere((doc) => doc.id == _userAuth.uid).get('currentBudget')}\$'
                                : '0\$',
                            style: TextStyle(fontSize: maxHeight * 0.0220),
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
    AsyncSnapshot<QuerySnapshot<Object>> incomeSnapshot,
  ) async {
    Timestamp addingDate = await income.get().then((querySnapshot) {
      return querySnapshot.docs
          .firstWhere((doc) => doc.id == _userAuth.uid)
          .get('monthlySalaryDate');
    });
    // add income to budget if salary date is selected in incoming days.
    if (addingDate.toDate().isAfter(datetime.dateTime)) {
      print('current date is behing of salary date');
      print(
          'time left for upcoming salary date: ${addingDate.toDate().difference(datetime.dateTime)}');
    } else {
      print('current date is not behing of salary date');
    }
    if (addingDate.toDate().isBefore(datetime.dateTime)) {
      if (addingDate.toDate().difference(datetime.dateTime).isNegative) {
        updateIncome(addingDate);
      }
    }
    // // add income to budget after next month arrives.
    // print('current date: ${Jiffy().dateTime}');
    // print('time left for salary date: ${Jiffy(
    //   addingDate.toDate(),
    // ).add(
    //       months: 1,
    //     ).dateTime.difference(
    //       Jiffy().dateTime,
    //     )}');
    // if (Jiffy(addingDate.toDate())
    //     .add(months: 1)
    //     .dateTime
    //     .difference(Jiffy().dateTime)
    //     .isNegative) {
    //   updateIncome(addingDate);
    // }
  }

  void updateIncome(Timestamp addingDate) async {
    income.doc(_userAuth.uid).update({
      'monthlySalaryDate': Jiffy(addingDate.toDate()).add(months: 1).dateTime,
    });
    budgetRefference.doc(_userAuth.uid).update({
      'currentBudget':
          FieldValue.increment(await income.get().then((querySnapshot) {
        return querySnapshot.docs
            .firstWhere((doc) => doc.id == _userAuth.uid)
            .get('income');
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
