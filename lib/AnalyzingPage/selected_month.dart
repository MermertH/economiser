import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class SelectedMonth extends StatefulWidget {
  final selectedMonth;
  SelectedMonth({this.selectedMonth});
  @override
  _SelectedMonthState createState() => _SelectedMonthState();
}

class _SelectedMonthState extends State<SelectedMonth> {
  final months = Jiffy();
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: (Icon(Icons.calendar_view_month_rounded)),
      tooltip: 'Select Month',
      color: Colors.amberAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      onSelected: (value) {
        print('Month $value is selected');
        setState(() {
          widget.selectedMonth(value);
        });
      },
      // initialValue: months.month,
      itemBuilder: (context) {
        return List.generate(1, (index) {
          return PopupMenuItem(
            value: months.month,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.orange,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Text('${months.subtract(months: index).MMM}')),
              ),
            ),
          );
        });
      },
    );
  }
}
