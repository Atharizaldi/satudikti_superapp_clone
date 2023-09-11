// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class CustomKeselarasanCard extends StatefulWidget {
//   @override
//   _CustomKeselarasanCardState createState() => _CustomKeselarasanCardState();
// }

// class _CustomKeselarasanCardState extends State<CustomKeselarasanCard> {
//   bool isCardOpen = false;

//   void toggleCard() {
//     setState(() {
//       isCardOpen = !isCardOpen;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: AnimatedContainer(
//           width: 358.w, // Ubah ukuran card sesuai kebutuhan
//           height: isCardOpen ? 282.h : 40.h, // Ubah ukuran card sesuai kebutuhan
//           duration: Duration(milliseconds: 200), // Atur durasi animasi
//           child: Card(
//             color: Colors.white,
//             elevation: 4.0,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//             child: Column(
//               children: [
//                 Container(
//                   alignment: Alignment.center,
//                   padding: EdgeInsets.only(left: 20, right: 20),
//                   child: GestureDetector(
//                     onTap: toggleCard,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                          Text(
//                           'Apa itu Keselarasan Horizontal?',
//                           style: TextStyle(
//                             color: Colors.blue,
//                             fontSize: 16.sp,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         Icon(
//                           isCardOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
//                           size: 30,
//                           color: Colors.blue,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 if (isCardOpen)
//                   Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     color: Color(0xFFF2F4FA),
//                     margin: EdgeInsets.only(left: 20, right: 20, top: 10),
//                     child: Container(
//                       padding: EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 16),
//                       child: Text(
//                         'Keselarasan Horizontal merupakan tingkat kesesuaian hubungan antara bidang pekerjaan alumni dengan bidang ilmu/program studi yang bersangkutan. Grafik di bawah ini menampilkan jumlah keselarasan data alumni dari seluruh program studi pada Universitas Indonesia',
//                         textAlign: TextAlign.justify,
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.w500,
//                           fontSize: 14.sp,
//                         ),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }