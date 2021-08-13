import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CostOfDay extends StatefulWidget {
  @override
  State<CostOfDay> createState() => _CostOfDayState();
}

class _CostOfDayState extends State<CostOfDay> {
  var rng = new Random();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.orange,
        ),
        child: FittedBox(
          clipBehavior: Clip.hardEdge,
          fit: BoxFit.scaleDown,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              '${rng.nextInt(1000)}\$',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
