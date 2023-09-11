import 'package:app/presentation/component/SkeletonLoading.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SkeletonCardProgramTerdaftar extends StatelessWidget {
  final Color? backgroundColor;
  const SkeletonCardProgramTerdaftar({Key? key, this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 358.w,
      padding: EdgeInsets.symmetric(vertical: 20.sp, horizontal: 20.w),
      decoration: BoxDecoration(
        color: backgroundColor ?? white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(151, 151, 151, 0.06),
              offset: Offset(0, 4),
              blurRadius: 15,
              spreadRadius: 10)
        ],
      ),
      child: _cardInfo(),
    );
  }

  Widget _cardInfo() {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SkeletonLoading(
          width: 280.w,
          height: 16.sp,
          cornerRadius: 5.r,
        ),
        SizedBox(height: 12.sp),
        SkeletonLoading(
          width: 80.w,
          height: 20.sp,
          cornerRadius: 5.r,
        ),
        SizedBox(height: 12.sp),
        SkeletonLoading(
          width: 140.w,
          height: 12.sp,
          cornerRadius: 5.r,
        ),
      ]),
    );
  }
}
