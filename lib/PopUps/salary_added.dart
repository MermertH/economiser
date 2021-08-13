import 'dart:async';

import 'package:flutter/material.dart';

class SalaryAddedDialog extends StatefulWidget {
  @override
  State<SalaryAddedDialog> createState() => _SalaryAddedDialogState();
}

class _SalaryAddedDialogState extends State<SalaryAddedDialog> {
  Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      _timer.cancel();
      Navigator.of(context).pop();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.amber,
      child: Container(
        height: 200,
        child: Column(
          children: [
            Center(
              child: Text(
                'Your salary has been added successfully!',
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(),
            Text('This pop up will close in 5 seconds'),
          ],
        ),
      ),
    );
  }
}
