import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/kampusMerdeka/component/program_amount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget noProgramKm(bool isRunning) {
  return ListView(
    padding: EdgeInsets.zero,
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    children: [
      programAmount('0', isRunning),
      SizedBox(height: 60.h),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 28.w),
        child: Column(
          children: [
            Image.asset(
              'assets/km/tutup.png',
              width: 190.w,
              height: 122.h,
            ),
            SizedBox(height: 32.w),
            Text(
              'Belum ada program dibuka, silahkan lihat program yang\nakan dibuka untuk melihat daftar program MBKM',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: neutral40,
                fontSize: 10.sp,
              ),
            )
          ],
        ),
      ),
    ],
  );
}
