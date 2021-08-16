import 'package:economiser/AnalyzingPage/ListItems.dart';
import 'package:economiser/AnalyzingPage/cost_of_day.dart';
import 'package:economiser/AnalyzingPage/selected_day.dart';
import 'package:economiser/AnalyzingPage/selected_month.dart';
import 'package:economiser/AnalyzingPage/selected_week.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './status_bar.dart';

class AnalyzeShowcase extends StatefulWidget {
  @override
  State<AnalyzeShowcase> createState() => _AnalyzeShowcaseState();
}

class _AnalyzeShowcaseState extends State<AnalyzeShowcase> {
  var selectedDay;
  var selectedWeek;
  var selectedMonth;
  final currentTime = DateTime.now();

  void currentSelectedDay(int day) {
    selectedDay = day;
  }

  void currentSelectedWeek(int week) {
    selectedWeek = week;
  }

  void currentSelectedMonth(int month) {
    selectedMonth = month;
  }

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    final maxHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text(
          'Analyze Showcase',
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: true,
        actions: [
          //PopUpMenus.
          SelectedWeek(selectedWeek: currentSelectedWeek),
          SelectedMonth(selectedMonth: currentSelectedMonth),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Text(
                            "${DateFormat.EEEE().format(currentTime)}, " +
                                "${DateFormat.QQQ().format(currentTime)}, " +
                                "${DateFormat.MMMM().format(currentTime)}",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Text(
                            'Total Expense: 1000\$',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: maxWidth,
                      height: 5,
                      color: Colors.grey[850],
                    ),
                    Container(
                      height: 200,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(7, (index) => StatusBar()),
                      ),
                    ),
                    Container(
                      width: maxWidth,
                      height: 5,
                      color: Colors.grey[850],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(7, (index) => CostOfDay()),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.all(Radius.circular(14)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // day selection PopupMenuButton.
                  SelectedDay(selectedDay: currentSelectedDay),
                  Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: Text(
                      'Expenses',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      shape: CircleBorder(),
                      backgroundColor: Colors.orange,
                      primary: Colors.black,
                      textStyle: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    onPressed: () {
                      // print('Max Width: $maxWidth');
                      // print('Max Height: $maxHeight');
                      // final months = Jiffy().subtract(months: 6);
                      // print('${months.add(months: 1).MMM}');
                      print('selected day is $selectedDay');
                      print('selected week is $selectedWeek');
                      print('selected month is $selectedMonth');
                    },
                    child: Text('?'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                ),
                child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) => ListItems(index),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
