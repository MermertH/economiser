import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelectedDay extends StatefulWidget {
  final Function selectedDay;
  SelectedDay({this.selectedDay});
  @override
  _SelectedDayState createState() => _SelectedDayState();
}

class _SelectedDayState extends State<SelectedDay> {
  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height;
    final maxWidth = MediaQuery.of(context).size.width;
    final weekday = DateTime.now();

    return PopupMenuButton(
      offset: Offset(maxWidth * 0.1, maxHeight * 0.03),
      color: Colors.amber[200],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FittedBox(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.orange,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.more_vert,
                    size: maxHeight * 0.0367,
                  ),
                  Text(
                    'Days',
                    style: TextStyle(fontSize: maxHeight * 0.0220),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      itemBuilder: (context) {
        weekday.subtract(Duration(days: 7));
        return List.generate(7, (index) {
          return PopupMenuItem(
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.orange,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                      child: Text('${DateFormat.EEEE().format(
                    DateTime(weekday.year, weekday.month,
                        DateTime.monday + index + 1),
                  )}')),
                )),
            value: index +
                1, // due to reversed function, index must be reverted too.
          );
        });
      },
      onSelected: (value) {
        print('selected day is $value');

        widget.selectedDay(value);
      },
    );
  }
}
