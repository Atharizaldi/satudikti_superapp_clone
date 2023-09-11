import 'package:app/presentation/component/SkeletonLoading.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SkeletorLoaderLogin extends StatelessWidget {
  const SkeletorLoaderLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.w),
      padding: EdgeInsets.symmetric(horizontal: 30.sp, vertical: 20.w),
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(151, 151, 151, 0.06),
                offset: Offset(0, 4),
                blurRadius: 15,
                spreadRadius: 10),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkeletonLoading(
            width: 64.sp,
            height: 64.sp,
            cornerRadius: 10.r,
          ),
          SizedBox(
            width: 20.sp,
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonLoading(
                  width: 280.sp,
                  height: 14,
                  cornerRadius: 5.r,
                ),
                SizedBox(
                  height: 6.sp,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
