import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:economiser/AnalyzingPage/cost_of_day.dart';
import 'package:economiser/AnalyzingPage/selected_day.dart';
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
  final CollectionReference expenseCosts =
      FirebaseFirestore.instance.collection('Expenses');
  final Stream<QuerySnapshot> _totalExpenseCost =
      FirebaseFirestore.instance.collection('Expenses').snapshots();
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
      selectedDay = day;
      dayIsSelected = true;
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
    //final maxHeight = MediaQuery.of(context).size.height;
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
            flex: 14,
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
                                    currentTime.weekday + selectedDay - 2,
                                  ))}, " +
                                "$selectedWeek, " +
                                "${DateFormat.MMMM().format(currentTime)}",
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: StreamBuilder<QuerySnapshot>(
                              stream: _totalExpenseCost,
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Text('Something went wrong');
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return FittedBox(
                                    fit: BoxFit.cover,
                                    clipBehavior: Clip.hardEdge,
                                    child: Text('...Loading...'),
                                  );
                                }
                                return StreamBuilder<QuerySnapshot>(
                                    stream: expenseCosts
                                        .doc(snapshot.data.docs.first.id)
                                        .collection('Expense')
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        return Text('Something went wrong');
                                      }
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return FittedBox(
                                          fit: BoxFit.cover,
                                          clipBehavior: Clip.hardEdge,
                                          child: Text('...Loading...'),
                                        );
                                      }
                                      return Text(
                                        'Total Expense: ${getTheCostOfTheMonth(snapshot)}\$',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      );
                                    });
                              }),
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
                        children: List.generate(7, (index) => StatusBar(index, selectedWeek)),
                      ),
                    ),
                    Container(
                      width: maxWidth,
                      height: 5,
                      color: Colors.grey[850],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                          7, (index) => CostOfDay(index, selectedWeek)),
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

  int getTheCostOfTheMonth(AsyncSnapshot<QuerySnapshot<Object>> snapshot) {
    var cost = 0;
    for (int i = 0; i < snapshot.data.docs.length; i++) {
      cost += snapshot.data.docs[i].get('expenseCost');
    }
    return cost;
  }
}
