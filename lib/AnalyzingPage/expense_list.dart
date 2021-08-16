import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './ListItems.dart';

class ExpenseList extends StatefulWidget {
  final selectedDay;
  final selectedWeek;
  final selectedMonth;
  ExpenseList(this.selectedDay, this.selectedWeek, this.selectedMonth);
  @override
  _ExpenseListState createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  final CollectionReference expenses =
      FirebaseFirestore.instance.collection('Expenses');
  final Stream<QuerySnapshot> _expenseStream =
      FirebaseFirestore.instance.collection('Expenses').snapshots();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.all(Radius.circular(14)),
          ),
          child: StreamBuilder<QuerySnapshot>(
              stream: _expenseStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.black,
                      ),
                    ),
                  );
                }
                return StreamBuilder<QuerySnapshot>(
                    stream: expenses
                        .doc(snapshot.data.docs.first.id)
                        .collection('Expense')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.black,
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: snapshot.data.size,
                        itemBuilder: (context, index) => ListItems(
                          index,
                          widget.selectedDay,
                          widget.selectedWeek,
                          widget.selectedMonth,
                          snapshot.data,
                        ),
                      );
                    });
                //expenses.doc(snapshot.data.docs.first.id).collection('Expense').snapshots()
              }),
        ),
      ),
    );
  }
}
