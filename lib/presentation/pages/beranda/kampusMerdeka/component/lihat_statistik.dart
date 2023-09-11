import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/kampusMerdeka/statistik_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget lihatStatistik(BuildContext context) {
  return Container(
    width: double.infinity,
    height: 96.w,
    margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
    decoration: BoxDecoration(
      gradient: berandaHubungiButtonGradient,
      borderRadius: BorderRadius.circular(4.r),
    ),
    child: GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => StatistikPage(data: "",)));
      },
      child: Row(
        children: [
          Image.asset(
            'assets/km/icons/statistik_icon.png',
            height: 64.w,
            width: 64.w,
          ),
          SizedBox(width: 20.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Lihat mengenai statistik Kampus \nMerdeka',
                style: TextStyle(
                  color: white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  height: 1.5.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
