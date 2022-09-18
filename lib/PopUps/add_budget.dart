import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddBudgetDialog extends StatefulWidget {
  @override
  _AddBudgetDialogState createState() => _AddBudgetDialogState();
}

class _AddBudgetDialogState extends State<AddBudgetDialog> {
  final _formKey = GlobalKey<FormState>();
  var _userAuth = FirebaseAuth.instance.currentUser;
  CollectionReference _budgetRefference =
      FirebaseFirestore.instance.collection('Budget');
  String amount;

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
        height: maxHeight * 0.3063,
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
                'Add Budget',
                style: TextStyle(fontSize: maxHeight * 0.0269),
              )),
            ),
            SizedBox(height: maxHeight * 0.0183),
            Text(
              'Please enter an amount to add',
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
                      key: ValueKey('Budget'),
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
                            return 'An amount must be provided!';
                          } else if (int.parse(value) == 0) {
                            return 'Amount cannot be zero';
                          } else if (int.parse(value).isNegative) {
                            return 'Amount must be greater than zero!';
                          } else if (int.parse(value) > 100000) {
                            return 'Please enter a reasonable Amount';
                          } else {
                            _formKey.currentState.save();
                            return null;
                          }
                        } catch (e) {
                          return 'Invalid input!';
                        }
                      },
                      onSaved: (value) {
                        amount = value;
                      },
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            StreamBuilder<QuerySnapshot>(
              stream: _budgetRefference.snapshots(),
              builder: (context, snapshot) {
                return TextButton(
                  onPressed: () {
                    if (!_formKey.currentState.validate()) {
                      return;
                    } else {
                      if (snapshot.data.docs
                              .any((doc) => doc.id == _userAuth.uid) ==
                          false) {
                        _budgetRefference.doc(_userAuth.uid).set({
                          'currentBudget': int.parse(amount),
                          'addingDate': DateTime.now(),
                        });
                      } else {
                        _budgetRefference.doc(_userAuth.uid).update({
                          'currentBudget':
                              FieldValue.increment(int.parse(amount)),
                          'extraBudgetAddingDate': DateTime.now(),
                        });
                      }
                      print(amount);
                      Navigator.of(context).pop(true);
                    }
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: maxHeight * 0.0196,
                    ),
                  ),
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
              },
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
