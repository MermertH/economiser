import 'package:economiser/AnalyzingPage/ListItems.dart';
import 'package:economiser/AnalyzingPage/cost_of_day.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './status_bar.dart';

class AnalyzeShowcase extends StatelessWidget {
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
          PopupMenuButton(
              color: Colors.amberAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              onSelected: (value) {
                if (value <= 4) {
                  print('Week $value is selected');
                }
              },
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
              }),
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
                            'March, Week 1',
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
                  PopupMenuButton(
                    offset: Offset(50, 20),
                    color: Colors.amber[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
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
                                size: 30,
                              ),
                              Text(
                                'Days',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    itemBuilder: (context) {
                      return List.generate(7, (index) {
                        return PopupMenuItem(
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Colors.orange,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Center(child: Text('day ${index + 1}')),
                              )),
                          value: index + 1,
                        );
                      });
                    },
                    onSelected: (value) {
                      print('selected day is $value');
                    },
                  ),
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
                      print('Max Width: $maxWidth');
                      print('Max Height: $maxHeight');
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
                  itemCount: 10,
                  itemBuilder: (context, index) => ListItems(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
