import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/newBannerSubJudul.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget noData(BuildContext context) {
  return Container(
    width: double.infinity,
    height: double.infinity,
    color: whiteBgPage,
    margin: EdgeInsets.symmetric(horizontal: 16.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.h),
        NewBannerSubJudul(
          subJudul: 'Pengumuman Terbaru',
          subJudul2: 'Temukan berbagai pengumuman Dikti terbaru',
          color: whiteBgPage,
        ),
        SizedBox(height: 68.h),
        Center(
          child: Image.asset(
            'assets/ilus_dataNotFound.png',
            width: 273.w,
            height: 216.w,
          ),
        ),
        Center(
          child: Column(
            children: [
              RichText(
                text: TextSpan(
                  text: '',
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Tidak ada pengumuman ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'Tidak ada pengumuman, silahkan lihat\npada kategori pengumuman lainnya',
                style: TextStyle(fontSize: 14.sp),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
