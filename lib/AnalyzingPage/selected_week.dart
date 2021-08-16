import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class SelectedWeek extends StatefulWidget {
  @override
  _SelectedWeekState createState() => _SelectedWeekState();
}

class _SelectedWeekState extends State<SelectedWeek> {
  var selectedWeek;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        icon: Icon(Icons.calendar_view_week_rounded),
        tooltip: 'Select Week',
        color: Colors.amberAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        onSelected: (value) {
          print('Week $value is selected');
          setState(() {
            selectedWeek = value;
          });
        },
        // initialValue: Jiffy().quarter,
        itemBuilder: (context) {
          return List.generate(4, (index) {
            return PopupMenuItem(
              value: index + 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.orange,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text('Week ${index + 1}')),
                ),
              ),
            );
          });
        });
  }
}
