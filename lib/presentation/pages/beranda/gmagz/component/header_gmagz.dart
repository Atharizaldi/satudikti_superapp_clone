import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/gmagz/pelajari_selengkapnya_gmagz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget headerGmagz(BuildContext context) {
  return Container(
    decoration: BoxDecoration(gradient: berandaBgGradient),
    child: Stack(
      children: [
        Positioned(
          // top: 15,
          right: 3.w,
          bottom: 14.h,
          child: Opacity(
            opacity: 0.60,
            child: Image.asset(
              'assets/gmagz/gmagz_homepage_banner.png',
              width: 240.w,
              height: 170.h,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Positioned(
          // top: 150,
          left: 18.w,
          bottom: 30.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/gmagz/icon_gmagz.png',
                width: 48.w,
                height: 48.h,
              ),
              SizedBox(height: 9.h),
              Container(
                width: 179.w,
                child: Text(
                  'Majalah Elektronik Sumber Sarana Informasi Terbaru dan Terakurat',
                  style: TextStyle(
                      color: white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      // letterSpacing: 0.6.sp,
                      height: 1.5.h),
                ),
              ),
              SizedBox(height: 16.h),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return PelajariSelengkapnyaGmagzPage();
                    },
                  ),
                ),
                child: Row(
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
              )
            ],
          ),
        ),
      ],
    ),
  );
}
