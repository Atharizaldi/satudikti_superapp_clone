import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/kampusMerdeka/pelajari_selengkapnya_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget headerKM(BuildContext context) {
  return Container(
    decoration: BoxDecoration(gradient: berandaBgGradient),
    child: Stack(
      children: [
        Positioned(
          right: -17.w,
          bottom: -91.w,
          child: Opacity(
            opacity: 0.75,
            child: Image.asset(
              'assets/km/ilus_km.png',
              width: 306.w,
              height: 306.w,
            ),
          ),
        ),
        Positioned(
          left: 28.w,
          bottom: 40.w,
          child: GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return PelajariSelengkapnyaPage();
                },
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/kmwhite.png',
                  width: 56.w,
                  height: 28.w,
                ),
                SizedBox(height: 12.h),
                Text(
                  'Kemerdekaan untuk membentuk \nmasa depan sesuai dengan \naspirasi kariermu',
                  style: TextStyle(
                    color: white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    height: 1.5.sp,
                    letterSpacing: 0.05.sp,
                  ),
                ),
                SizedBox(height: 14.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        width: 189.w,
                        height: 40.h,
                        padding: EdgeInsets.symmetric(
                            vertical: 6.h, horizontal: 12.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.r),
                            color: bgPelajariSelengkapnya),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Pelajari Selengkapnya",
                              style: stylePelajariSelengkapnya,
                              textAlign: TextAlign.center,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 14.h,
                            )
                          ],
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
