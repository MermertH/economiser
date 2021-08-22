import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SetIncomeDialog extends StatefulWidget {
  @override
  State<SetIncomeDialog> createState() => _SetIncomeDialogState();
}

class _SetIncomeDialogState extends State<SetIncomeDialog> {
  // firebase references.
  CollectionReference _incomes =
      FirebaseFirestore.instance.collection('Income');
  var _userAuth = FirebaseAuth.instance.currentUser;

  // validation key.
  final _formKey = GlobalKey<FormState>();

  // selected salary date.
  DateTime selectedDate = DateTime.now();

  //DatePicker to select salary date.
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(selectedDate.year),
        lastDate: DateTime(selectedDate.year + 100));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;
    var maxHeight = MediaQuery.of(context).size.height;
    String input;
    return Dialog(
      elevation: 5,
      backgroundColor: Colors.yellowAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(14)),
      ),
      child: Container(
        height: maxHeight * 0.3676,
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
                'Set Income',
                style: TextStyle(fontSize: maxHeight * 0.0269),
              )),
            ),
            SizedBox(height: maxHeight * 0.0183),
            Text(
              'Please enter your monthly income',
              style: TextStyle(fontSize: maxHeight * 0.0196),
            ),
            Spacer(),
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
                  child: Form(
                    key: this._formKey,
                    child: TextFormField(
                      key: ValueKey('Income'),
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                        hintText: '1000, 2000, 500, etc',
                        constraints: BoxConstraints(
                          maxWidth: maxWidth * 0.4629,
                        ),
                      ),
                      validator: (value) {
                        try {
                          if (value.isEmpty) {
                            return 'An income must be provided!';
                          } else if (int.parse(value) == 0) {
                            return 'Income cannot be zero';
                          } else if (int.parse(value).isNegative) {
                            return 'Income must be greater than zero!';
                          } else if (int.parse(value) > 100000) {
                            return 'Please enter a reasonable income';
                          } else {
                            _formKey.currentState.save();
                            return null;
                          }
                        } catch (e) {
                          return 'Invalid input!';
                        }
                      },
                      onSaved: (value) {
                        input = value;
                      },
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.orange,
                  primary: Colors.black,
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(14),
                    ),
                  ),
                ),
                onPressed: () => _selectDate(context),
                child: FittedBox(
                    child: Text(
                  'Salary Date',
                  style: TextStyle(
                    fontSize: maxHeight * 0.0196,
                  ),
                ))),
            Spacer(),
            StreamBuilder<QuerySnapshot>(
              stream: _incomes.snapshots(),
              builder: (context, snapshot) {
                return TextButton(
                  onPressed: () {
                    if (!_formKey.currentState.validate()) {
                      return;
                    } else {
                      if (snapshot.data.docs
                              .any((doc) => doc.id == _userAuth.uid) ==
                          false) {
                        _incomes
                            .doc(_userAuth.uid)
                            .set({
                              'income': int.parse(input),
                              'addingDate': selectedDate != DateTime.now()
                                  ? selectedDate
                                  : DateTime.now(),
                              'monthlySalaryDate':
                                  selectedDate != DateTime.now()
                                      ? selectedDate
                                      : DateTime.now(),
                            })
                            .then((value) => print("Income Added"))
                            .catchError((error) =>
                                print("Failed to add income: $error"));
                      } else {
                        _incomes.doc(_userAuth.uid).set({
                          'income': int.parse(input),
                          'addingDate': selectedDate != DateTime.now()
                              ? selectedDate
                              : DateTime.now(),
                          'monthlySalaryDate': selectedDate != DateTime.now()
                              ? selectedDate
                              : DateTime.now(),
                        });
                      }
                      print(input);
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
                    primary: Colors.black,
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(14),
                      ),
                    ),
                  ),
                );
              },
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
