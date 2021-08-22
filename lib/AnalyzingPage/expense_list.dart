import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import './expenses.dart';
import 'package:flutter/material.dart';
import './ListItems.dart';

class ExpenseList extends StatefulWidget {
  final int selectedDay;
  final String selectedWeek;
  ExpenseList(this.selectedDay, this.selectedWeek);
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
    return Expanded(
      flex: 12,
      child: Padding(
        padding: const EdgeInsets.all(10),
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
                currentList = selectedExpenses(
                    expenseSnapshot, widget.selectedDay, widget.selectedWeek);

                return ListView.builder(
                    itemCount: currentList.length,
                    itemBuilder: (context, index) {
                      return currentList[index].id != null
                          ? Dismissible(
                              key: ValueKey(index),
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

  List<Expenses> selectedExpenses(AsyncSnapshot<QuerySnapshot<Object>> snapshot,
      int selectedDay, String selectedWeek) {
    List<Expenses> list = [];
    isSuccessful = false;
    for (int i = 0; i < snapshot.data.docs.length; i++) {
      Timestamp addingDate = snapshot.data.docs[i].get('addingDate');
      if (addingDate.toDate().weekday == selectedDay &&
          DateFormat.QQQ().format(addingDate.toDate()) == selectedWeek) {
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
}

// print('${(snapshot.data.docs[3].get('expenseName'))}');
// print('selected day is ${widget.selectedDay}');
// print('selected week is ${widget.selectedWeek}');
// for (int i = 0; i < snapshot.data.docs.length; i++) {
//   desiredDate = snapshot.data.docs[i].get('addingDate');
//   if (desiredDate.toDate().weekday ==
//           widget.selectedDay &&
//       DateFormat.QQQ().format(desiredDate.toDate()) ==
//           widget.selectedWeek) {
//     print('it is desired date $i');
//   } else {
//     print('it is not the desired date');
//   }
// }
// desiredDate = snapshot.data.docs.first.get('addingDate');
// print('desired date is ${desiredDate.toDate()}');
