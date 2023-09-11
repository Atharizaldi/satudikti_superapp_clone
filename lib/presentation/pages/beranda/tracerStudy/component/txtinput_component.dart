
import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

InputDecoration inputDecorationTextInput(
      {required String hintText, Widget? suffixIcon, required Color color}) {
    return InputDecoration(
      hintText: hintText,
      contentPadding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 16.sp),
      hintStyle: TextStyle(
        color: abu,
        // fontSize: screenArea(context) * (0.00005),
      ),
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.r),
        borderSide:
            BorderSide(color: color, style: BorderStyle.solid, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.r),
        borderSide:
            BorderSide(color: color, style: BorderStyle.solid, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.r),
        borderSide:
            BorderSide(color: color, style: BorderStyle.solid, width: 1.2),
      ),
      isDense: true,
    );
  }