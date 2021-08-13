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
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.amber,
      child: Container(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.money,
              color: Colors.green,
              size: 60,
            ),
            Center(
              child: Text(
                'Your salary has been added successfully!',
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              'This pop up will close in 5 seconds',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
