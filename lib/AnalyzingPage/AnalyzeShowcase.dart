import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:economiser/AnalyzingPage/cost_of_day.dart';
import 'package:economiser/AnalyzingPage/selected_day.dart';
import 'package:economiser/AnalyzingPage/selected_week.dart';
import 'package:economiser/PopUps/informative_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  var _userAuth = FirebaseAuth.instance.currentUser;
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
    final maxHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text(
          'Analyze Showcase',
          style: TextStyle(fontSize: maxHeight * 0.0294),
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
              padding: EdgeInsets.symmetric(
                vertical: maxHeight * 0.0122,
                horizontal: maxWidth * 0.0231,
              ), //10
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
                          padding: EdgeInsets.symmetric(
                            vertical: maxHeight * 0.0171,
                            horizontal: maxWidth * 0.0324,
                          ), //14
                          child: FittedBox(
                            child: Text(
                              "${dayIsSelected == false ? DateFormat.EEEE().format(currentTime) : DateFormat.EEEE().format(DateTime(
                                      currentTime.year,
                                      currentTime.month,
                                      DateTime.monday + selectedDay,
                                    ))}, " +
                                  "$selectedWeek, " +
                                  "${DateFormat.MMMM().format(currentTime)}",
                              style: TextStyle(fontSize: maxHeight * 0.0220),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: maxHeight * 0.0171,
                            horizontal: maxWidth * 0.0324,
                          ), //14
                          child: StreamBuilder<QuerySnapshot>(
                              stream: expenseCosts
                                  .doc(_userAuth.uid)
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
                                return FittedBox(
                                  child: Text(
                                    'Total Expense: ${getTheCostOfTheMonth(snapshot)}\$',
                                    style: TextStyle(
                                        fontSize: maxHeight * 0.0196,
                                        fontWeight: FontWeight.bold),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                    Container(
                      width: maxWidth,
                      height: maxHeight * 0.0061,
                      color: Colors.grey[850],
                    ),
                    Container(
                      height: maxHeight * 0.2450,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                            7, (index) => StatusBar(index, selectedWeek)),
                      ),
                    ),
                    Container(
                      width: maxWidth,
                      height: maxHeight * 0.0061,
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
            padding: EdgeInsets.symmetric(
              vertical: maxHeight * 0.0122,
              horizontal: maxWidth * 0.0231,
            ), //10
            child: Container(
              height: maxHeight * 0.0735,
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
                    padding: EdgeInsets.only(right: maxWidth * 0.0578),
                    child: FittedBox(
                      child: Text(
                        'Expenses',
                        style: TextStyle(
                          fontSize: maxHeight * 0.0269,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: maxWidth * 0.0185,
                      vertical: maxHeight * 0.0098,
                    ), //8
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: Colors.orange,
                        primary: Colors.black,
                        textStyle: TextStyle(
                          fontSize: maxHeight * 0.0367,
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => InformativeDialog());
                        print('selected day is $selectedDay');
                        print('selected week is $selectedWeek');
                        print('max width: $maxWidth');
                        print('max height: $maxHeight');
                      },
                      child: FittedBox(
                        child: Text(
                          '?',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
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
