import 'package:app/presentation/component/SkeletonLoading.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SkeletonCardKD extends StatelessWidget {
  const SkeletonCardKD({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 358.w,
      padding: EdgeInsets.symmetric(vertical: 20.sp, horizontal: 20.w),
      decoration: BoxDecoration(
        color: white,
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
          height: 12.sp,
          cornerRadius: 5.r,
        ),
        SizedBox(height: 12.sp),
        SkeletonLoading(
          width: 100.w,
          height: 14.sp,
          cornerRadius: 5.r,
        ),
        SizedBox(height: 16.5.sp),
        Row(
          children: [
            Image.asset(
              "assets/icons/calendar.png",
              width: 12.sp,
              height: 13.33.sp,
            ),
            SizedBox(width: 10.sp),
            Flexible(
              child: SkeletonLoading(
                width: 70.w,
                height: 10.sp,
                cornerRadius: 5.r,
              ),
            )
          ],
        ),
      ]),
    );
  }
}
