import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/sister/pelajari_selengkapnya_sister.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget headerSister(BuildContext context) {
  return FlexibleSpaceBar(
    background: Container(
      decoration: BoxDecoration(gradient: berandaBgGradient),
      child: Stack(
        children: [
          Positioned(
            right: -8.w,
            bottom: 14.h,
            child: Opacity(
              opacity: 0.60,
              child: Image.asset(
                'assets/sister/sister_homepage_banner.png',
                width: 201.w,
                height: 191.h,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            left: 18.w,
            bottom: 30.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 50.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          ),
                    ),
                    Image.asset(
                      'assets/sister/icon_sister.png',
                      width: 43.w,
                      height: 46.h,
                      scale: 3.0,
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Text(
                  'Sistem Informasi \nSumber Daya Terintegrasi',
                  style: TextStyle(
                    color: white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 30.h),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return PelajariSelengkapnyaSisterPage();
                      },
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                          width: 189.w,
                          height: 40.h,
                          padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.r),
                              color: bgPelajariSelengkapnya
                          ),
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

                            ],)
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
