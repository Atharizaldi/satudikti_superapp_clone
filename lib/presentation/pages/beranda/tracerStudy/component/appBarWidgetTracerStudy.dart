import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../component/constant.dart';
import '../pelajariSelengkapnyaTracerStudyPage.dart';

Widget appBarWidgetTracerStudy(BuildContext context) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(gradient: sliverBgGradient),
    child: Stack(
      children: [
        Positioned(
          right: 0.w,
          bottom: -30.h,
          child: _bgImage(),
        ),
        Positioned(
          top: 120.h,
          left: 30.w,
          child: _headerContent(context),
        ),
      ],
    ),
  );
}

Widget _headerContent(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Image.asset(
        "assets/tracerStudy/logo_header.png",
        width: 163.w,
        height: 38.w,
      ),
      Container(
          margin: EdgeInsets.only(top: 12.h),
          width: 220.w,
          child: Text(
            "Platform Kuesioner untuk Alumni Perguruan Tinggi.",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
                color: Colors.white),
          )),
      Container(
        margin: EdgeInsets.only(top: 14.h),
        width: 220.w,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PelajariSelengkapnyaTracerStudyPage(),
                ));
          },
          child: Row(
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
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _bgImage() {
  return Opacity(
    opacity: 0.75,
    child: Image.asset(
      'assets/tracerStudy/vector_header.png',
      width: 196.w,
      height: 213.w,
    ),
  );
}
