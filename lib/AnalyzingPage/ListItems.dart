import 'package:economiser/AnalyzingPage/expenses.dart';
import 'package:economiser/PopUps/edit_expense_dialog.dart';
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
    final maxWidth = MediaQuery.of(context).size.width;
    final maxHeight = MediaQuery.of(context).size.height;
    return selectedExpenses.first.id == null
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: maxHeight * 0.0612),
                // color: Colors.orange,
                height: maxHeight * 0.2450,
                width: maxWidth * 0.4629,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.warning,
                      size: maxHeight * 0.0735,
                    ),
                    Center(
                      child: Text(
                        'No Expense Found',
                        style: TextStyle(
                            color: Colors.black, fontSize: maxHeight * 0.0245),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        : Card(
            margin: EdgeInsets.symmetric(
              vertical: maxHeight * 0.0122,
              horizontal: maxWidth * 0.0231,
            ), //10
            child: ListTile(
              onTap: () {
                print('id of this expense is ${selectedExpenses[index].id}');
                showDialog(
                    context: context,
                    builder: (context) => EditExpenseDialog(
                          selectedExpenses[index].id,
                          selectedExpenses[index].title,
                          selectedExpenses[index].cost,
                          selectedExpenses[index].date,
                        ));
              },
              title: Text(
                selectedExpenses[index].title,
                style: TextStyle(
                  fontSize: maxHeight * 0.0196,
                ),
              ),
              subtitle: Text(
                '${DateFormat("yMMMEd").format(selectedExpenses[index].date)} ${DateFormat("Hms").format(selectedExpenses[index].date)}',
                style: TextStyle(fontSize: maxHeight * 0.0196),
              ),
              tileColor: Colors.white,
              leading: CircleAvatar(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.black,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: maxHeight * 0.0122,
                    horizontal: maxWidth * 0.0231,
                  ), //10
                  child: FittedBox(
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(fontSize: maxHeight * 0.0245),
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
                  padding: EdgeInsets.symmetric(
                    vertical: maxHeight * 0.0122,
                    horizontal: maxWidth * 0.0231,
                  ), //10
                  child: Text(
                    '${selectedExpenses[index].cost}\$',
                    style: TextStyle(fontSize: maxHeight * 0.0196),
                  ),
                ),
              ),
            ),
          );
  }
}
