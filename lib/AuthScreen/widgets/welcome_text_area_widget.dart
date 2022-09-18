// import 'package:flutter/material.dart';

// class WelcomeTextAreaWidget extends StatelessWidget {
//   const WelcomeTextAreaWidget({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var maxWidth = MediaQuery.of(context).size.width;
//     var maxHeight = MediaQuery.of(context).size.height;
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: maxHeight * 0.0122),
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           gradient: LinearGradient(
//             begin: Alignment.topRight,
//             end: Alignment.bottomLeft,
//             colors: [
//               Colors.amber[700],
//               Colors.amber[500],
//             ],
//           ),
//         ),
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//             vertical: maxHeight * 0.0098,
//             horizontal: maxWidth * 0.0185,
//           ), //8
//           child: Text(
//             'Welcome To Economiser',
//             style: TextStyle(
//               fontSize: maxHeight * 0.0367,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
