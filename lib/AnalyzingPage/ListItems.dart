import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        onTap: () {},
        title: Text('Taxes'),
        subtitle: Text(
            '${DateFormat("yMMMEd").format(DateTime.now())} ${DateFormat("Hms").format(DateTime.now())}'),
        tileColor: Colors.white,
        leading: CircleAvatar(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              '1',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        trailing: Container(
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              '100\$',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
