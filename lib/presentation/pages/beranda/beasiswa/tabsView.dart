// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class TabsView extends StatelessWidget {
//   TabsView(
//       {Key key,
//       required this.tabIndex,
//       required this.firstTab,
//       required this.secondTab})
//       : super(key: key);

//   final int tabIndex;
//   final Widget firstTab;
//   final Widget secondTab;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         AnimatedContainer(
//           child: firstTab,
//           width: 200.w,
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
//           transform: Matrix4.translationValues(
//               tabIndex == 0 ? 0 : -SizeConfig.screenWidth, 0, 0),
//           duration: Duration(milliseconds: 300),
//           curve: Curves.easeIn,
//         ),
//         AnimatedContainer(
//           child: secondTab,
//           width: SizeConfig.screenWidth,
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
//           transform: Matrix4.translationValues(
//               tabIndex == 1 ? 0 : SizeConfig.screenWidth, 0, 0),
//           duration: Duration(milliseconds: 300),
//           curve: Curves.easeIn,
//         )
//       ],
//     );
//   }
// }
