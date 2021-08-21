import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:economiser/AnalyzingPage/AnalyzeShowcase.dart';
import 'package:economiser/PopUps/add_budget.dart';
import 'package:economiser/PopUps/add_expense.dart';
import 'package:economiser/PopUps/set_income_dialog.dart';
import 'package:economiser/PopUps/show_budget_warning_dialog.dart';
import 'package:economiser/SettingsPage/Settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './app_label.dart';
import './monthly_income.dart';
import './current_budget.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  CollectionReference _setBudget =
      FirebaseFirestore.instance.collection('Budget');
  var _userAuth = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    checkBudget();
    checkBudgetWarning();
    super.initState();
  }

  void checkBudget() async {
    print('entered here');
    DocumentReference _budget =
        FirebaseFirestore.instance.collection('Budget').doc(_userAuth.uid);
    /*if there is no initial doc that has budget value, 
      then create it. this behaviour prevents any error that comes
       if user does not add any budget but add an expense */
    var isExist = _budget.snapshots().map((doc) {
      return doc.exists;
    });
    print(await isExist.first);
    if (await isExist.first == false) {
      _setBudget.doc(_userAuth.uid).set({
        'currentBudget': 0,
      });
    }
  }

  void checkBudgetWarning() async {
    DocumentReference _budget =
        FirebaseFirestore.instance.collection('Budget').doc(_userAuth.uid);
    // when app started, check if the budget is lower than 0, then show a warning dialog.
    var budget = _budget.snapshots().map((doc) {
      return doc.get('currentBudget');
    });
    int currentBudget = await budget.first;
    if (currentBudget < 0) {
      showDialog(context: context, builder: (context) => BudgetWarningDialog());
    }
  }

  @override
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
                          checkBudgetWarning();
                          setState(() {
                            value = false;
                          });
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
