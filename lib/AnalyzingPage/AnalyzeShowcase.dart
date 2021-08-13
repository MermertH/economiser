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
          Theme(
            data: Theme.of(context).copyWith(
                textTheme: TextTheme().apply(bodyColor: Colors.black),
                dividerColor: Colors.amberAccent,
                iconTheme: IconThemeData(color: Colors.black)),
            child: PopupMenuButton<int>(
              color: Colors.orange,
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                    enabled: true,
                    value: 0,
                    child: Center(child: Text("Week 1"))),
                PopupMenuDivider(),
                PopupMenuItem<int>(
                    value: 1, child: Center(child: Text("Week 2"))),
                PopupMenuDivider(),
                PopupMenuItem<int>(
                    value: 2, child: Center(child: Text("Week 3"))),
                PopupMenuDivider(),
                PopupMenuItem<int>(
                    value: 3, child: Center(child: Text("Week 4"))),
              ],
              onSelected: null,
            ),
          ),
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
                        children: [
                          StatusBar(),
                          StatusBar(),
                          StatusBar(),
                          StatusBar(),
                          StatusBar(),
                          StatusBar(),
                          StatusBar(),
                        ],
                      ),
                    ),
                    Container(
                      width: maxWidth,
                      height: 5,
                      color: Colors.grey[850],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CostOfDay(),
                        CostOfDay(),
                        CostOfDay(),
                        CostOfDay(),
                        CostOfDay(),
                        CostOfDay(),
                        CostOfDay(),
                      ],
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.orange[600],
                        primary: Colors.black,
                      ),
                      icon: Icon(Icons.more_vert),
                      label: Text('Days'),
                      onPressed: () {},
                    ),
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
