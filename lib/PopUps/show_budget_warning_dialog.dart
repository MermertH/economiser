import 'package:flutter/material.dart';

class BudgetWarningDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;
    var maxHeight = MediaQuery.of(context).size.height;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Theme.of(context).errorColor,
      child: Container(
        height: maxHeight * 0.3676,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: maxHeight * 0.0183,
                horizontal: maxWidth * 0.0347,
              ), //15
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: maxHeight * 0.0122,
                      horizontal: maxWidth * 0.0462),
                  child: Icon(
                    Icons.warning,
                    size: maxHeight * 0.0735,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: maxHeight * 0.0147,
                horizontal: maxWidth * 0.0277,
              ), //12
              child: Text(
                'Your expenses exceed your budget, please bear that in mind!',
                style: TextStyle(
                  fontSize: maxHeight * 0.0245,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
              child: FittedBox(child: Text('Understood')),
            )
          ],
        ),
      ),
    );
  }
}
