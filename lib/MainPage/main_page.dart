import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:economiser/AnalyzingPage/AnalyzeShowcase.dart';
import 'package:economiser/PopUps/add_budget.dart';
import 'package:economiser/PopUps/add_expense.dart';
import 'package:economiser/PopUps/logout_verification.dart';
import 'package:economiser/PopUps/set_income_dialog.dart';
import 'package:economiser/PopUps/show_budget_warning_dialog.dart';
import 'package:economiser/main.dart';
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
    checkExpenseDate();
    super.initState();
  }

  void checkExpenseDate() async {
    CollectionReference _getExpense = FirebaseFirestore.instance
        .collection('Expenses')
        .doc(_userAuth.uid)
        .collection('Expense');
    var whatIs = _getExpense.snapshots().map((data) {
      return data.docs.map((doc) {
        return [doc.get('addingDate'), doc.id].asMap();
      });
    });
    print('this id is: ${await whatIs.first}');
    Iterable<Map<int, dynamic>> expenseDates = await whatIs.first;
    expenseDates = expenseDates.toList();
    // print(expenseDates);
    // print(expenseDates.elementAt(0).values);
    // print(expenseDates.first.values.first);
    // print(expenseDates.first.values.last);
    for (int i = 0; i < expenseDates.length; i++) {
      Timestamp date = expenseDates.elementAt(i).values.first;
      if (date.toDate().month != DateTime.now().month) {
        _getExpense.doc(expenseDates.elementAt(i).values.last).delete();
      } else {
        print(
            'expense ${expenseDates.elementAt(i).values.last} is not expired yet');
      }
    }
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
    var maxWidth = MediaQuery.of(context).size.width;
    var maxHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          color: Colors.grey[800],
          child: Column(
            children: [
              // Label Name
              AppLabel(),
              // monthly income and current budget
              Container(
                margin: EdgeInsets.only(top: maxHeight * 0.0612),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      padding: EdgeInsets.only(top: maxHeight * 0.0490),
                      child: TextButton(
                        onPressed: () {
                          showDialog(
                                  context: context,
                                  builder: (context) => SetIncomeDialog())
                              .then((value) {
                            if (value == true) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  'Income submitted successfully!',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: maxWidth * 0.0370,
                                  ),
                                ),
                                backgroundColor: Colors.amber,
                              ));
                            }
                          });
                        },
                        child: const Text('Set Income'),
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.amber,
                            shape: const BeveledRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14)),
                            ),
                            textStyle: TextStyle(fontSize: maxHeight * 0.0306),
                            fixedSize:
                                Size(maxWidth * 0.4629, maxHeight * 0.0612)),
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
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.amber,
                          shape: const BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(14)),
                          ),
                          textStyle: TextStyle(fontSize: maxHeight * 0.0306),
                          fixedSize:
                              Size(maxWidth * 0.4629, maxHeight * 0.0612)),
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
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.amber,
                          shape: const BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(14)),
                          ),
                          textStyle: TextStyle(fontSize: maxHeight * 0.0306),
                          fixedSize:
                              Size(maxWidth * 0.4629, maxHeight * 0.0612)),
                    ),
                    //Analyze Showcase Button
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AnalyzeShowcase(checkBudgetWarning)));
                      },
                      child: Text(
                        'Analyze Showcase',
                        textAlign: TextAlign.center,
                      ),
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.amber,
                          shape: const BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(14)),
                          ),
                          textStyle: TextStyle(fontSize: maxHeight * 0.0306),
                          fixedSize:
                              Size(maxWidth * 0.4629, maxHeight * 0.0980)),
                    ),
                    //Settings Button
                    TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) =>
                                LogoutVerificationDialog()).then((value) {
                          if (value == true) {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => MyApp()));
                          }
                        });
                      },
                      child: FittedBox(child: const Text('Logout')),
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.amber,
                          shape: const BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(14)),
                          ),
                          textStyle: TextStyle(fontSize: maxHeight * 0.0306),
                          fixedSize:
                              Size(maxWidth * 0.4629, maxHeight * 0.0612)),
                    ),
                    SizedBox(height: maxHeight * 0.0857),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


/*  TextButton(
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
                        textStyle: TextStyle(fontSize: maxHeight * 0.0306),
                        fixedSize: Size(maxWidth * 0.4629, maxHeight * 0.0612)),
                  ), */