import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListItems extends StatelessWidget {
  final index;
  final selectedDay;
  final selectedWeek;
  final selectedMonth;
  final expenseData;
  ListItems(this.index, this.selectedDay, this.selectedWeek, this.selectedMonth,
      this.expenseData);

  @override
  Widget build(BuildContext context) {
    return index == 100
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
              onTap: () {},
              title: Text('Taxes'),
              subtitle: Text(
                  '${DateFormat("yMMMEd").format(DateTime.now())} ${DateFormat("Hms").format(DateTime.now())}'),
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
                    '100\$',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          );
  }
}
