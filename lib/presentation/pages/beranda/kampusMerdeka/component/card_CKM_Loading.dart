import 'package:app/presentation/component/SkeletonLoading.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeleton_text/skeleton_text.dart';

class SkeletonLoadingCKM extends StatelessWidget {
  const SkeletonLoadingCKM({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        children: [
          SkeletonAnimation(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r)),
              shimmerColor: Colors.grey,
              shimmerDuration: 1500,
              curve: Curves.linear,
              child: Container(
                width: double.infinity,
                height: 140.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r)),
                  color: Colors.grey[300],
                ),
              ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: SkeletonLoading(
                    width: 200,
                    height: 25.h,
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/km/icons/icon_author.png',
                      height: 24.h,
                      width: 24.w,
                    ),
                    SizedBox(width: 4.w),
                    SkeletonLoading(
                      width: 200,
                      height: 25.h,
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ImageIcon(
                      AssetImage('assets/km/icons/calendar_icon.png'),
                      size: 16.sp,
                      color: neutral60,
                    ),
                    SizedBox(
                      width: 6.w,
                    ),
                    SkeletonLoading(
                      width: 100,
                      height: 25.h,
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    ImageIcon(
                      AssetImage('assets/km/icons/icon_like.png'),
                      size: 12.sp,
                      color: neutral60,
                    ),
                    SizedBox(
                      width: 6.w,
                    ),
                    SkeletonLoading(
                      width: 25.w,
                      height: 25.h,
                    ),
                    SizedBox(
                      width: 18.w,
                    ),
                    ImageIcon(
                      AssetImage('assets/km/icons/icon_comment.png'),
                      size: 16.sp,
                      color: neutral60,
                    ),
                    SizedBox(
                      width: 6.w,
                    ),
                    SkeletonLoading(
                      width: 25.w,
                      height: 25.h,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
