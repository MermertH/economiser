import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './expenses.dart';
import 'package:flutter/material.dart';
import './ListItems.dart';

class ExpenseList extends StatefulWidget {
  final int selectedDay;
  ExpenseList(this.selectedDay);
  @override
  _ExpenseListState createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  final CollectionReference expenses =
      FirebaseFirestore.instance.collection('Expenses');
  final CollectionReference _refundBudget =
      FirebaseFirestore.instance.collection('Budget');
  var _userAuth = FirebaseAuth.instance.currentUser;
  List<Expenses> currentList = [];
  final rng = new Random();
  bool isSuccessful;
  // Timestamp desiredDate;

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    final maxHeight = MediaQuery.of(context).size.height;
    return Expanded(
      flex: 12,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: maxHeight * 0.0122,
          horizontal: maxWidth * 0.0231,
        ), //10
        child: Container(
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.all(Radius.circular(14)),
          ),
          child: StreamBuilder<QuerySnapshot>(
              stream:
                  expenses.doc(_userAuth.uid).collection('Expense').snapshots(),
              builder: (context, expenseSnapshot) {
                if (expenseSnapshot.hasError) {
                  return Text('Something went wrong');
                }
                if (expenseSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.black,
                      ),
                    ),
                  );
                }
                currentList =
                    selectedExpenses(expenseSnapshot, widget.selectedDay);

                return ListView.builder(
                    itemCount: currentList.length,
                    itemBuilder: (context, index) {
                      return currentList[0].id != null
                          ? Dismissible(
                              key: UniqueKey(),
                              child: ListItems(
                                index,
                                currentList,
                              ),
                              onDismissed: (direction) {
                                _refundBudget.doc(_userAuth.uid).update({
                                  'currentBudget': FieldValue.increment(
                                      currentList[index].cost),
                                });
                                expenses
                                    .doc(_userAuth.uid)
                                    .collection('Expense')
                                    .doc(currentList[index].id)
                                    .delete();
                              },
                            )
                          : ListItems(
                              index,
                              currentList,
                            );
                    });
              }),
        ),
      ),
    );
  }

  List<Expenses> selectedExpenses(
      AsyncSnapshot<QuerySnapshot<Object>> snapshot, int selectedDay) {
    List<Expenses> list = [];
    isSuccessful = false;
    for (int i = 0; i < snapshot.data.docs.length; i++) {
      Timestamp addingDate = snapshot.data.docs[i].get('addingDate');
      if (addingDate.toDate().weekday == selectedDay) {
        list.add(Expenses(
          cost: snapshot.data.docs[i].get('expenseCost'),
          date: addingDate.toDate(),
          title: snapshot.data.docs[i].get('expenseName'),
          id: '${snapshot.data.docs[i].id}',
        ));
        isSuccessful = true;
      }
    }
    return isSuccessful ? list : [Expenses(id: null)];
  }

  // String currentWeekOfMonthCalculator(DateTime date) {
  //   var currentWeeknum;
  //   var weeknum = date.day / 7;
  //   if (weeknum > 0 && weeknum < 1) {
  //     currentWeeknum = 1;
  //   } else if (weeknum > 1 && weeknum < 2) {
  //     currentWeeknum = 2;
  //   } else if (weeknum > 2 && weeknum < 3) {
  //     currentWeeknum = 3;
  //   } else if (weeknum > 3 && weeknum < 4) {
  //     currentWeeknum = 4;
  //   } else {
  //     currentWeeknum = 4;
  //   }
  //   // print('calculated week: W$currentWeeknum');
  //   return 'W$currentWeeknum';
  // }
}
