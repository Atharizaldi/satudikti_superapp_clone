import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/showWebsite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget carouselSlideFirst(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowWebsite(
              link: 'http://satudikti.id/',
            ),
          ));
    },
    child: Container(
      height: 185.h,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: berandaCarouselGradient,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 28.w,
            top: 30.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/logo_satudikti_carousel.png',
                  alignment: Alignment.centerLeft,
                  height: 13.h,
                  width: 56.w,
                ),
                SizedBox(height: 14.h),
                Text(
                  'Satu platform terintegrasi \nuntuk mendukung \nberbagai layanan di dikti',
                  style: TextStyle(
                    color: white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 16.h),
                Container(
                    width: 154.w,
                    height: 28.h,
                    padding:
                        EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.r),
                        color: bgPelajariSelengkapnya),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Learn More",
                          style: stylePelajariSelengkapnya.copyWith(
                              fontSize: 12.sp),
                          textAlign: TextAlign.center,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 12.h,
                        )
                      ],
                    )),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Opacity(
              opacity: 0.75,
              child: Image.asset(
                'assets/slider_beranda_vector1.png',
                height: 130.h,
                width: 147.w,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
