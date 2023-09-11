import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/selancarPAK/pelajari_selengkapnya_PAK_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget headerPAK(BuildContext context) {
  return FlexibleSpaceBar(
    background: Container(
      decoration: BoxDecoration(gradient: berandaBgGradient),
      child: Stack(
        children: [
          Positioned(
            right: -15.w,
            bottom: -0.h,
            child: Opacity(
              opacity: 0.75,
              child: Image.asset(
                'assets/selancar/icons/PAK_appbar.png',
                width: 267.w,
                height: 267.h,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            left: 28.w,
            bottom: 30.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/selancar/icons/selancar.png',
                  width: 43.w,
                  height: 46.w,
                ),
                SizedBox(height: 12.h),
                Text(
                  'Pantau, kelola, dan dapatkan \ninformasi pelacakan angka \nkredit lebih mudah dengan \nSelancar PAK.',
                  style: TextStyle(
                    color: white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 14.h),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return PelajariSelengkapnyaPAKPage();
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
