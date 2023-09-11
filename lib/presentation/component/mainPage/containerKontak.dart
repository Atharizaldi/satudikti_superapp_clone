import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget containerKontak(
    {required String icon,
    required String judul,
    required String deskripsi,
    EdgeInsets? margin,
    VoidCallback? function}) {
  return GestureDetector(
    onTap: function,
    child: Container(
      margin: margin ?? EdgeInsets.only(top: 20.h, left: 24.w, right: 24.w),
      width: 357.w,
      height: 104.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              width: 64.w,
              height: 64.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: Color(0xffF8F9FD),
              ),
              child: Image.asset(icon),
            ),
            SizedBox(
              width: 12.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  judul,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: blue4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 6.h),
                Container(
                  width: 220.w,
                  child: Text(
                    deskripsi,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: teksAbuCerah4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
