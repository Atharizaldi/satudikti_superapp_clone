import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/sivil/pelajariSelengkapnyaSivil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget appBarWidgetSivil(BuildContext context) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(gradient: sliverBgGradient),
    child: Stack(
      children: [
        Positioned(
          right: 0,
          bottom: -7.w,
          child: _bgImage(),
        ),
        Positioned(
          bottom: 95.w,
          left: 30.w,
          child: _headerContent(context),
        ),
        Positioned(
          bottom: 42.w,
          left: 30.w,
          child: pelajariSelengkapnyaButton(context),
        ),
      ],
    ),
  );
}

Container pelajariSelengkapnyaButton(BuildContext context) {
  return Container(
    width: 220.w,
    child: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PelajariSelengkapnyaSivilPage(),
          ),
        );
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
  );
}

Widget _headerContent(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 81.w,
        height: 29.w,
        alignment: Alignment.centerLeft,
        child: Image.asset("assets/sivil/ic_sivil_header.png"),
      ),
      Container(
        margin: EdgeInsets.only(top: 14.w),
        width: 220.w,
        child: Text(
          "Cek dan verifikasi ijazah dengan \naman melalui SIVIL",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
            color: Colors.white,
            letterSpacing: 0.5,
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
      'assets/sivil/ilus_sivil.png',
      width: 219.w,
      height: 157.w,
    ),
  );
}
