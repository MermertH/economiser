import 'package:economiser/AnalyzingPage/expenses.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListItems extends StatelessWidget {
  final int index;
  final List<Expenses> selectedExpenses;
  ListItems(
    this.index,
    this.selectedExpenses,
  );

  @override
  Widget build(BuildContext context) {
    return selectedExpenses.first.id == null
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 50),
                // color: Colors.orange,
                height: 200,
                width: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.warning,
                      size: 60,
                    ),
                    Center(
                      child: Text(
                        'No Expense Found',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        : Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              onTap: () {
                print('id of this expense is ${selectedExpenses[index].id}');
              },
              title: Text(selectedExpenses[index].title),
              subtitle: Text(
                  '${DateFormat("yMMMEd").format(selectedExpenses[index].date)} ${DateFormat("Hms").format(selectedExpenses[index].date)}'),
              tileColor: Colors.white,
              leading: CircleAvatar(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: FittedBox(
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
              trailing: Container(
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    '${selectedExpenses[index].cost}\$',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          );
  }
}
