import 'package:flutter/material.dart';

class SelectedWeek extends StatefulWidget {
  final Function selectedWeek;
  SelectedWeek({this.selectedWeek});

  @override
  _SelectedWeekState createState() => _SelectedWeekState();
}

class _SelectedWeekState extends State<SelectedWeek> {
  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    final maxHeight = MediaQuery.of(context).size.height;
    return PopupMenuButton(
        icon: Icon(
          Icons.calendar_view_week_rounded,
        ),
        tooltip: 'Select Week',
        color: Colors.amberAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        onSelected: (value) {
          print('Week $value is selected');
          widget.selectedWeek('Q$value');
        },
        // initialValue: Jiffy().quarter,
        itemBuilder: (context) {
          return List.generate(4, (index) {
            return PopupMenuItem(
              value: index + 1,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: maxWidth * 0.0185,
                  vertical: maxHeight * 0.0098,
                ), //8
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.orange,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: maxWidth * 0.0185,
                      vertical: maxHeight * 0.0098,
                    ), //8
                    child: Center(
                        child: FittedBox(
                            child: Text(
                      'Week ${index + 1}',
                      style: TextStyle(fontSize: maxHeight * 0.0196),
                    ))),
                  ),
                ),
              ),
            );
          });
        });
  }
}
