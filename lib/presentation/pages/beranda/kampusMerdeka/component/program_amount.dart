import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget programAmount(String amount, bool isRunning) {
  return Padding(
    padding: EdgeInsets.only(left: 18.w),
    child: Row(
      children: [
        Text(
          'Ada',
          style: TextStyle(fontSize: 14.sp),
        ),
        SizedBox(width: 2),
        Text(
          amount,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
        ),
        SizedBox(width: 2),
        isRunning
            ? Text(
                'program yang sedang dibuka',
                style: TextStyle(fontSize: 14.sp),
              )
            : Text(
                'program yang akan dibuka',
                style: TextStyle(fontSize: 14.sp),
              ),
      ],
    ),
  );
}
