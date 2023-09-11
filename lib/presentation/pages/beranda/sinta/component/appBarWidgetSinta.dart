import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/sinta/pelajariSelengkapnyaSintaPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget appBarWidgetSinta(BuildContext context) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(gradient: sliverBgGradient),
    child: Stack(
      children: [
        Positioned(
          top: 120.h,
          left: 30.w,
          child: _headerContent(context),
        ),
        Positioned(
          right: 7.w,
          bottom: -30.h,
          child: _bgImage(),
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
        "assets/sinta/logo.png",
        width: 67.w,
        height: 32.w,
      ),
      Container(
          margin: EdgeInsets.only(top: 12.h),
          width: 220.w,
          child: Text(
            "SINTA memberikan akses mudah, cepat, dan komprehensif untuk mengukur jurnal di Indonesia.",
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
                  builder: (context) => PelajariSelengkapnyaSintaPage(),
                ));
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
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
        ),
      ),
    ],
  );
}

Widget _bgImage() {
  return Opacity(
    opacity: 0.75,
    child: Image.asset(
      'assets/sinta/vector_header.png',
      width: 196.w,
      height: 213.w,
    ),
  );
}
