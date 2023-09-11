import 'package:app/presentation/component/SkeletonLoading.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SkeletonLoadingPAK extends StatelessWidget {
  const SkeletonLoadingPAK({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SkeletonLoading(
                height: 64.w,
                width: 64.w,
                cornerRadius: 4.r,
              ),
              SizedBox(width: 20.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonLoading(
                    width: 150.h,
                    height: 25.w,
                    cornerRadius: 4.r,
                  ),
                  SizedBox(height: 10.h),
                  SkeletonLoading(
                    width: 50.h,
                    height: 15.w,
                    cornerRadius: 4.r,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 48.h),
          SkeletonLoading(
            height: 20.h,
            width: 120.w,
            cornerRadius: 4.r,
          ),
          SizedBox(height: 20.h),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 20.h,
            ),
            decoration: BoxDecoration(
              color: whiteBgPage,
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonLoading(
                      height: 18.h,
                      width: 151.w,
                      cornerRadius: 4.r,
                    ),
                    SizedBox(height: 8.h),
                    SkeletonLoading(
                      width: 56.w,
                      height: 21.h,
                      cornerRadius: 4.r,
                    ),
                    SizedBox(height: 16.h),
                    SkeletonLoading(
                      width: 102.w,
                      height: 15.h,
                      cornerRadius: 4.r,
                    ),
                    SizedBox(height: 4.h),
                    SkeletonLoading(
                      width: 135.w,
                      height: 15.h,
                      cornerRadius: 4.r,
                    ),
                  ],
                ),
                Spacer(),
                SkeletonLoading(
                  width: 50.r,
                  height: 50.r,
                  shape: BoxShape.circle,
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          SkeletonLoading(
            width: double.infinity,
            height: 48.sp,
            cornerRadius: 4.r,
          ),
        ],
      ),
    );
  }
}
