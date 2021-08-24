import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InformativeDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;
    var maxHeight = MediaQuery.of(context).size.height;
    return Dialog(
      backgroundColor: Colors.amber[700],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: maxHeight * 0.7965,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FittedBox(
                  child: CircleAvatar(
                    radius: maxHeight * 0.0367,
                    backgroundColor: Colors.amberAccent,
                    foregroundColor: Colors.orange[900],
                    child: Icon(
                      Icons.info_rounded,
                      size: maxHeight * 0.0367 * 2,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: maxWidth * 0.0185,
                    vertical: maxHeight * 0.0098,
                  ), // 8
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: maxHeight * 0.0122,
                        horizontal: maxWidth * 0.0231,
                      ), // 10
                      child: FittedBox(
                        child: Text(
                          'Page Information',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: maxHeight * 0.0196,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                FittedBox(
                  child: CircleAvatar(
                    radius: maxHeight * 0.0367,
                    backgroundColor: Colors.amberAccent,
                    foregroundColor: Colors.orange[900],
                    child: Icon(
                      Icons.info_rounded,
                      size: maxHeight * 0.0367 * 2,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: maxHeight * 0.0036,
              color: Colors.black,
            ),
            Container(
              height: maxHeight * 0.5759,
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: maxWidth * 0.0231,
                      vertical: maxHeight * 0.0122,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'THIS PAGE IS SCROLLABLE. \n It is recommended to read '
                          'all of the information given here carefully',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: maxHeight * 0.0196,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: maxWidth * 0.0231,
                      vertical: maxHeight * 0.0122,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'This page is intended to show you how much you have spent on a month, '
                          'with the functionality of selecting to see in which day.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: maxHeight * 0.0196,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: maxWidth * 0.0231,
                      vertical: maxHeight * 0.0122,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'The button with three vertical dots which also contains "Days" in it allows you to '
                          'select desired day to show what is bought  in what date and how much it costs.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: maxHeight * 0.0196,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: maxWidth * 0.0231,
                      vertical: maxHeight * 0.0122,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          'Total Expense in right upside will show monthly total expense data and the plus sign '
                          'in the right allows you to add expenses from here',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: maxHeight * 0.0196,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: maxWidth * 0.0231,
                      vertical: maxHeight * 0.0122,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          'Graphical data shown in the upper side only shows the monthly data and it will be scaled by '
                          'your expenses. Your expense data will be erased automatically after the month ends',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: maxHeight * 0.0196,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: maxWidth * 0.0231,
                      vertical: maxHeight * 0.0122,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'You can remove any expense you have added by swiping them to right or left. '
                          'this move will refund your budget',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: maxHeight * 0.0196,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: maxWidth * 0.0231,
                      vertical: maxHeight * 0.0122,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'You can edit any expense you have added by tapping on them. ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: maxHeight * 0.0196,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: maxHeight * 0.0036,
              color: Colors.black,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                  backgroundColor: Colors.amberAccent,
                  primary: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
              child: FittedBox(
                  child: Text(
                'Understood',
                style: TextStyle(
                  fontSize: maxHeight * 0.0196,
                ),
              )),
            )
          ],
        ),
      ),
    );
  }
}
