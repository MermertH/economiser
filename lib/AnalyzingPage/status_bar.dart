import 'dart:math';
import 'package:flutter/material.dart';

class StatusBar extends StatefulWidget {
  @override
  State<StatusBar> createState() => _StatusBarState();
}

class _StatusBarState extends State<StatusBar> {
  var rng = new Random();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 200,
        width: 20,
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                // border: Border.all(color: Colors.white, width: 1.0),
                color: Colors.red,
                //borderRadius: BorderRadius.circular(10),
              ),
            ),
            FractionallySizedBox(
              heightFactor: rng.nextDouble(),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
