import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: non_constant_identifier_names
YYDialog YYDialogModuleNotReady(
  BuildContext context,
  String title,
  String contentText,
) {
  return YYDialog().build(context)
    ..width = 360.w
    ..height = 320.h
    ..backgroundColor = whiteBgPage
    ..borderRadius = 10.0
    ..showCallBack = () {
      print("showCallBack invoke");
    }
    ..barrierDismissible = false
    ..widget(Padding(
      padding: EdgeInsets.only(top: 32.h),
      child: Image.asset(
        'assets/icons/ic_warning.png',
        width: 80.w,
        height: 80.h,
      ),
    ))
    ..widget(Padding(
      padding: EdgeInsets.only(top: 16.h, right: 20.w, left: 20.w),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 20.sp, color: neutral90, fontWeight: FontWeight.w700),
      ),
    ))
    ..widget(Padding(
      padding: EdgeInsets.only(top: 24.h, right: 32.w, left: 32.w),
      child: Text(
        contentText,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 12.sp, color: neutral50, fontWeight: FontWeight.w500),
      ),
    ))
    ..widget(Padding(
      padding: EdgeInsets.only(top: 36.h),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          width: 311.w,
          height: 48.h,
          margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
          decoration: BoxDecoration(
              color: blue4, borderRadius: BorderRadius.circular(8.r)),
          child: Center(
            child: Text(
              "Kembali",
              style: TextStyle(
                  fontSize: 16.sp, color: white, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    ))
    ..animatedFunc = (child, animation) {
      return ScaleTransition(
        child: child,
        scale: Tween(begin: 0.0, end: 1.0).animate(animation),
      );
    }
    ..show();
}
