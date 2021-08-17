import 'package:economiser/AnalyzingPage/cost_of_day.dart';
import 'package:economiser/AnalyzingPage/selected_day.dart';
import 'package:economiser/AnalyzingPage/selected_month.dart';
import 'package:economiser/AnalyzingPage/selected_week.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import './status_bar.dart';
import './expense_list.dart';

class AnalyzeShowcase extends StatefulWidget {
  @override
  State<AnalyzeShowcase> createState() => _AnalyzeShowcaseState();
}

class _AnalyzeShowcaseState extends State<AnalyzeShowcase> {
  final currentTime = DateTime.now();
  final currentJiffy = Jiffy();
  var selectedDay;
  var selectedWeek;
  bool dayIsSelected = false;

  @override
  void initState() {
    selectedDay = currentTime.weekday;
    selectedWeek = DateFormat.QQQ().format(currentTime);
    super.initState();
  }

  void currentSelectedDay(int day) {
    setState(() {
      setState(() {
        selectedDay = day;
        dayIsSelected = true;
      });
    });
  }

  void currentSelectedWeek(String week) {
    setState(() {
      selectedWeek = week;
    });
  }

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    final maxHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: const Text(
          'Analyze Showcase',
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: true,
        actions: [
          //PopUpMenus.
          SelectedWeek(selectedWeek: currentSelectedWeek),
          // SelectedMonth(selectedMonth: currentSelectedMonth),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: const BoxDecoration(
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
                            "${dayIsSelected == false ? DateFormat.EEEE().format(currentTime) : DateFormat.EEEE().format(DateTime(
                                    currentTime.year,
                                    currentTime.month,
                                    currentTime.weekday + selectedDay - 1,
                                  ))}, " +
                                "$selectedWeek, " +
                                "${DateFormat.MMMM().format(currentTime)}",
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: const Text(
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
              decoration: const BoxDecoration(
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
                    child: const Text(
                      'Expenses',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: Colors.orange,
                      primary: Colors.black,
                      textStyle: const TextStyle(
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
                      // print(
                      //     'selected day is ${DateFormat.EEEE().format(DateTime(currentTime.year, currentTime.month, currentTime.day + selectedDay - 1))}');
                    },
                    child: const Text('?'),
                  ),
                ],
              ),
            ),
          ),
          ExpenseList(selectedDay, selectedWeek),
        ],
      ),
    );
  }
}
