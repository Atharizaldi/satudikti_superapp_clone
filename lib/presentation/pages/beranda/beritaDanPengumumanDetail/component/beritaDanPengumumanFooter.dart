import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget beritaDanPengumumanFooter() {
  return GestureDetector(
    onTap: () {},
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color(0xff0C63A4),
          Color(0xff70BBF2),
        ],
      )),
      child: Container(
        // height: 82.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Diterbitkan Oleh:',
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
                color: white,
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Row(
              children: [
                Container(
                  height: 56.w,
                  width: 56.w,
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                      color: white, borderRadius: BorderRadius.circular(8)),
                  child: Image.asset(
                    'assets/silemkerma.png',
                  ),
                ),
                SizedBox(
                  width: 16.w,
                ),
                Container(
                  width: 239.w,
                  height: 56.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Humas Ditjen Diktiristek',
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            color: white),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Text(
                        'No. Telp : +62 812-1222-6126',
                        style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w400,
                            color: white),
                      ),
                      Text(
                        'Email        : sekretariat.dikti@kemdikbud.go.id',
                        style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w400,
                            color: white),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
