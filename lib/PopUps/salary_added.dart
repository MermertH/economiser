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
    var maxWidth = MediaQuery.of(context).size.width;
    var maxHeight = MediaQuery.of(context).size.height;
    return Dialog(
      backgroundColor: Colors.amber,
      child: Container(
        height: maxHeight * 0.2450,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.money,
              color: Colors.green,
              size: maxHeight * 0.0735,
            ),
            Center(
              child: Text(
                'Your salary has been added successfully!',
                style: TextStyle(
                  fontSize: maxHeight * 0.0245,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              'This pop up will close in 5 seconds',
              style: TextStyle(fontSize: maxHeight * 0.0196),
            ),
          ],
        ),
      ),
    );
  }
}
