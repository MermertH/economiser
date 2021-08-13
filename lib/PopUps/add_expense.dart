import 'package:flutter/material.dart';

class AddExpenseDialog extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

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
                          onSaved: (value) {},
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
                              onSaved: (value) {},
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
            TextButton(
              onPressed: () {
                if (!_formKey.currentState.validate()) {
                  return;
                } else {
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
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
