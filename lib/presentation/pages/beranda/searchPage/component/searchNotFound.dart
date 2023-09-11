import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Container searchNotFound(String text) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 50.h),
    child: Center(
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
          "Ups, " + text + " Tidak Ditemukan",
          textAlign: TextAlign.center,
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
    )),
  );
}
