import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/bima/pelajari_selengkapnya_bima.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget headerBima(BuildContext context) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(gradient: sliverBgGradient),
    child: Stack(
      children: [
        Positioned(
          right: -4.w,
          bottom: 20.h,
          child: Opacity(
            opacity: 0.30,
            child: Image.asset(
              'assets/bima/bima_banner.png',
              width: 231.w,
              height: 203.h,
            ),
          ),
        ),
        Positioned(
          left: 28.w,
          bottom: 40.h,
          child: GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return PelajariSelengkapnyaBimaPage();
                },
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Positioned(
                  left: 16.w,
                  top: 5.h,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/bima/layanan_bima.png',
                        width: 100.w,
                        height: 34.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  'Basis Informasi Penelitian'
                  '\ndan Pengabdian kepada \nMasyarakat',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    height: 1.5.sp,
                    letterSpacing: 0.05.sp,
                  ),
                ),
                SizedBox(
                  height: 14.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 189.w,
                      height: 40.h,
                      padding:
                          EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
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
                          ),
                        ],
                      ),
                    ),
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
