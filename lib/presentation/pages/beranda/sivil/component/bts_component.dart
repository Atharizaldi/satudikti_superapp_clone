import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextStyle btsSivilTextStyle = TextStyle(
    color: neutral30,
    fontWeight: FontWeight.w400,
    fontSize: 14.sp,
    letterSpacing: 0.5);

Widget btsNotFound(String text) {
  return Center(
      child: Column(
    children: [
      SizedBox(
        height: 50.h,
      ),
      Image.asset(
        'assets/data_not_found.png',
        width: 198.w,
      ),
      SizedBox(
        height: 20.h,
      ),
      Text(
        "Ups, " + text,
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
      ),
      SizedBox(
        height: 8.h,
      ),
      Text(
        "Silahkan cek kembali ejaan kata atau\ncoba kata kunci lain.",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
      )
    ],
  ));
}

Widget btsNoInternet() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/sivil/ilus_signal.png',
          width: 94.w,
          height: 94.w,
          color: neutral10,
        ),
        SizedBox(
          height: 20.h,
        ),
        Text(
          "Tidak ada Koneksi Internet",
          style: btsSivilTextStyle,
        ),
      ],
    ),
  );
}
