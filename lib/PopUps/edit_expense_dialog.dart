import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditExpenseDialog extends StatefulWidget {
  final String selectedExpenseID;
  final String selectedExpenseTitle;
  final int selectedExpenseCost;
  final DateTime selectedExpenseDate;
  EditExpenseDialog(
    this.selectedExpenseID,
    this.selectedExpenseTitle,
    this.selectedExpenseCost,
    this.selectedExpenseDate,
  );

  @override
  State<EditExpenseDialog> createState() => _EditExpenseDialogState();
}

class _EditExpenseDialogState extends State<EditExpenseDialog> {
  final CollectionReference _expenses =
      FirebaseFirestore.instance.collection('Expenses');

  final CollectionReference _totalBudget =
      FirebaseFirestore.instance.collection('Budget');

  var _userAuth = FirebaseAuth.instance.currentUser;

  final _formKey = GlobalKey<FormState>();

  String expenseName;

  int expenseCost;

  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;
    var maxHeight = MediaQuery.of(context).size.height;
    return Dialog(
      elevation: 5,
      backgroundColor: Colors.yellowAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(14)),
      ),
      child: Container(
        height: maxHeight * 0.4289,
        width: maxWidth * 0.5787,
        child: Column(
          children: [
            Container(
              height: maxHeight * 0.0612,
              decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14),
                  )),
              child: Center(
                  child: Text(
                'Edit Expense',
                style: TextStyle(fontSize: maxHeight * 0.0269),
              )),
            ),
            SizedBox(height: maxHeight * 0.0183),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: maxWidth * 0.0185),
              child: Text(
                'Please enter the new name or cost of your expense',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: maxHeight * 0.0196,
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
                        width: maxWidth * 0.5324,
                        height: maxHeight * 0.0612,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(14),
                          ),
                          color: Colors.amber,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: maxWidth * 0.0347),
                        child: TextFormField(
                          key: ValueKey('Expense Name'),
                          keyboardType: TextInputType.text,
                          decoration: new InputDecoration(
                            hintText: '${widget.selectedExpenseTitle}',
                            constraints: BoxConstraints(
                              maxWidth: maxWidth * 0.4629,
                            ),
                          ),
                          validator: (value) {
                            try {
                              _formKey.currentState.save();
                              return null;
                            } catch (e) {
                              return 'Invalid input!';
                            }
                          },
                          onSaved: (value) {
                            if (value.isEmpty) {
                              expenseName = widget.selectedExpenseTitle;
                            } else {
                              expenseName = value;
                            }
                            print('expense name: $expenseName');
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: maxHeight * 0.0183),
                  // cost of the expense
                  Stack(
                    children: [
                      Container(
                        width: maxWidth * 0.5324,
                        height: maxHeight * 0.0612,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(14),
                          ),
                          color: Colors.amber,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: maxWidth * 0.0347),
                        child: Column(
                          children: [
                            TextFormField(
                              key: ValueKey('Cost'),
                              keyboardType: TextInputType.number,
                              decoration: new InputDecoration(
                                hintText: '${widget.selectedExpenseCost}\$',
                                constraints: BoxConstraints(
                                  maxWidth: maxWidth * 0.4629,
                                ),
                              ),
                              validator: (value) {
                                try {
                                  if (int.parse(value) == 0) {
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
                                  if (value.isEmpty) {
                                    return null;
                                  }
                                  return 'Invalid input!';
                                }
                              },
                              onSaved: (value) {
                                if (value.isEmpty) {
                                  expenseCost = widget.selectedExpenseCost;
                                } else {
                                  expenseCost = int.parse(value);
                                }
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(14),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: FittedBox(
                      child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: maxHeight * 0.0196,
                    ),
                  )),
                ),
                StreamBuilder(
                    stream: _totalBudget.snapshots(),
                    builder: (context, budgetSnapshot) {
                      return StreamBuilder<QuerySnapshot>(
                          stream: _expenses
                              .doc(_userAuth.uid)
                              .collection('Expense')
                              .snapshots(),
                          builder: (context, expenseSnapshot) {
                            return TextButton(
                              onPressed: () {
                                if (!_formKey.currentState.validate()) {
                                  return;
                                } else {
                                  _expenses
                                      .doc(_userAuth.uid)
                                      .collection('Expense')
                                      .doc(widget.selectedExpenseID)
                                      .set({
                                    'expenseName': expenseName,
                                    'expenseCost': expenseCost,
                                    'addingDate': widget.selectedExpenseDate,
                                  });

                                  if (expenseCost ==
                                      widget.selectedExpenseCost) {
                                    // do nothing
                                  } else {
                                    _totalBudget.doc(_userAuth.uid).update({
                                      'currentBudget': FieldValue.increment(
                                          -expenseCost +
                                              widget.selectedExpenseCost),
                                    });
                                  }
                                  Navigator.of(context).pop(true);
                                }
                              },
                              child: FittedBox(
                                  child: Text(
                                'Submit',
                                style: TextStyle(
                                  fontSize: maxHeight * 0.0196,
                                ),
                              )),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.amber,
                                foregroundColor: Colors.black,
                                shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(14),
                                  ),
                                ),
                              ),
                            );
                          });
                    }),
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
