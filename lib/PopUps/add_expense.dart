import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddExpenseDialog extends StatefulWidget {
  @override
  State<AddExpenseDialog> createState() => _AddExpenseDialogState();
}

class _AddExpenseDialogState extends State<AddExpenseDialog> {
  final Stream<QuerySnapshot> _expenseStream =
      FirebaseFirestore.instance.collection('Expenses').snapshots();
  final CollectionReference expenses =
      FirebaseFirestore.instance.collection('Expenses');
  final Stream<QuerySnapshot> _totalBudget =
      FirebaseFirestore.instance.collection('Budget').snapshots();
  final CollectionReference totalBudget =
      FirebaseFirestore.instance.collection('Budget');
  final _formKey = GlobalKey<FormState>();
  String expenseName;
  int expenseCost;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 5,
      backgroundColor: Colors.yellowAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(14)),
      ),
      child: Container(
        height: 350,
        width: 250,
        child: Column(
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14),
                  )),
              child: Center(
                  child: Text(
                'Add Expense',
                style: TextStyle(fontSize: 22),
              )),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Please enter the name and cost of your expense',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Spacer(),
            //expense name
            Form(
              key: this._formKey,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 230,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(14),
                          ),
                          color: Colors.amber,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: TextFormField(
                          key: ValueKey('Expense Name'),
                          keyboardType: TextInputType.text,
                          decoration: new InputDecoration(
                            hintText: 'tax, bill, shopping, etc',
                            constraints: BoxConstraints(
                              maxWidth: 200,
                            ),
                          ),
                          validator: (value) {
                            try {
                              if (value.isEmpty) {
                                return 'An expense name must be provided!';
                              } else {
                                _formKey.currentState.save();
                                return null;
                              }
                            } catch (e) {
                              return 'Invalid input!';
                            }
                          },
                          onSaved: (value) {
                            expenseName = value;
                            print('expense name: $expenseName');
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  // cost of the expense
                  Stack(
                    children: [
                      Container(
                        width: 230,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(14),
                          ),
                          color: Colors.amber,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          children: [
                            TextFormField(
                              key: ValueKey('Cost'),
                              keyboardType: TextInputType.number,
                              decoration: new InputDecoration(
                                hintText: '1000, 2000, 500, etc',
                                constraints: BoxConstraints(
                                  maxWidth: 200,
                                ),
                              ),
                              validator: (value) {
                                try {
                                  if (value.isEmpty) {
                                    return 'A cost must be provided!';
                                  } else if (int.parse(value) == 0) {
                                    return 'cost cannot be zero';
                                  } else if (int.parse(value).isNegative) {
                                    return 'cost must be greater than zero!';
                                  } else if (int.parse(value) > 100000) {
                                    return 'Please enter a reasonable cost';
                                  } else {
                                    _formKey.currentState.save();
                                    return null;
                                  }
                                } catch (e) {
                                  return 'Invalid input!';
                                }
                              },
                              onSaved: (value) {
                                expenseCost = int.parse(value);
                                print('expense cost: $expenseCost');
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // cost

            Spacer(),
            StreamBuilder<QuerySnapshot>(
                stream: _totalBudget,
                builder: (context, budgetSnapshot) {
                  return StreamBuilder<QuerySnapshot>(
                      stream: _expenseStream,
                      builder: (context, expenseSnapshot) {
                        return TextButton(
                          onPressed: () {
                            if (!_formKey.currentState.validate()) {
                              return;
                            } else {
                              expenses
                                  .doc(expenseSnapshot.data.docs.first.id)
                                  .collection('Expense')
                                  .add({
                                'expenseName': expenseName,
                                'expenseCost': expenseCost,
                                'addingDate': DateTime.now(),
                              });
                              // totalBudget
                              //     .doc(budgetSnapshot.data.docs.first.id)
                              //     .update({

                              //     });
                              Navigator.of(context).pop(true);
                            }
                          },
                          child: Text('Submit'),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.amber,
                            primary: Colors.black,
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(14),
                              ),
                            ),
                          ),
                        );
                      });
                }),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
