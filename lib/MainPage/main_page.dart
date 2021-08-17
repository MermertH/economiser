import 'package:economiser/AnalyzingPage/AnalyzeShowcase.dart';
import 'package:economiser/PopUps/add_budget.dart';
import 'package:economiser/PopUps/add_expense.dart';
import 'package:economiser/PopUps/set_income_dialog.dart';
import 'package:economiser/SettingsPage/Settings.dart';
import 'package:flutter/material.dart';
import './app_label.dart';
import './monthly_income.dart';
import './current_budget.dart';

class MainPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.grey[800],
        child: Column(
          children: [
            // Label Name
            AppLabel(),
            // monthly income and current budget
            Container(
              margin: EdgeInsets.only(left: 50, top: 50),
              child: Row(
                children: [
                  // monthly income
                  MonthlyIncome(),
                  //current budget
                  CurrentBudget(),
                ],
              ),
            ),
            //Buttons
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  //Set Income Button
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: TextButton(
                      onPressed: () {
                        showDialog(
                                context: context,
                                builder: (context) => SetIncomeDialog())
                            .then((value) {
                          if (value == true) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                'Income submitted successfully!',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              backgroundColor: Colors.amber,
                            ));
                          }
                        });
                      },
                      child: const Text('Set Income'),
                      style: TextButton.styleFrom(
                          primary: Colors.black,
                          backgroundColor: Colors.amber,
                          shape: const BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(14)),
                          ),
                          textStyle: const TextStyle(fontSize: 25),
                          fixedSize: Size(200, 50)),
                    ),
                  ),
                  // Add Budget
                  TextButton(
                    onPressed: () {
                      showDialog(
                              context: context,
                              builder: (context) => AddBudgetDialog())
                          .then((value) {
                        if (value == true) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text(
                              'Budget added successfully!',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            backgroundColor: Colors.amber,
                          ));
                        }
                      });
                    },
                    child: const Text('Add Budget'),
                    style: TextButton.styleFrom(
                        primary: Colors.black,
                        backgroundColor: Colors.amber,
                        shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14)),
                        ),
                        textStyle: const TextStyle(fontSize: 25),
                        fixedSize: Size(200, 50)),
                  ),
                  //Add Expense Button
                  TextButton(
                    onPressed: () {
                      showDialog(
                              context: context,
                              builder: (context) => AddExpenseDialog())
                          .then((value) {
                        if (value == true) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.amber,
                              content: const Text(
                                'Expense submitted successfully!',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              )));
                        }
                      });
                    },
                    child: const Text('Add Expense'),
                    style: TextButton.styleFrom(
                        primary: Colors.black,
                        backgroundColor: Colors.amber,
                        shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14)),
                        ),
                        textStyle: const TextStyle(fontSize: 25),
                        fixedSize: Size(200, 50)),
                  ),
                  //Analyze Showcase Button
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AnalyzeShowcase()));
                    },
                    child: Text(
                      'Analyze Showcase',
                      textAlign: TextAlign.center,
                    ),
                    style: TextButton.styleFrom(
                        primary: Colors.black,
                        backgroundColor: Colors.amber,
                        shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14)),
                        ),
                        textStyle: const TextStyle(fontSize: 25),
                        fixedSize: Size(200, 80)),
                  ),
                  //Settings Button
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SettingsPage(),
                          ));
                    },
                    child: const Text('Settings'),
                    style: TextButton.styleFrom(
                        primary: Colors.black,
                        backgroundColor: Colors.amber,
                        shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14)),
                        ),
                        textStyle: const TextStyle(fontSize: 25),
                        fixedSize: Size(200, 50)),
                  ),
                  const SizedBox(height: 70),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
