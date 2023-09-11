import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget usulanIsEmpty() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        'assets/km/tutup.png',
        height: 122.h,
        width: 190.w,
      ),
      SizedBox(height: 20.h),
      Text(
        'Tidak ada Pengajuan Baru',
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
      ),
      SizedBox(height: 8.h),
      Text(
        'Anda belum mengajukan jabatan atau \npangkat',
        textAlign: TextAlign.center,
      ),
    ],
  );
}
