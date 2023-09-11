import 'package:app/presentation/component/SkeletonLoading.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget kmListLoading() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SkeletonLoading(
            width: 240.w,
            height: 12.h,
            cornerRadius: 17.r,
          )),
      SizedBox(
        height: 20.h,
      ),
      Flexible(
        child: ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 10,
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 20.h,
            );
          },
          itemBuilder: (context, index) {
            return kmItemSkeleton();
          },
        ),
      ),
    ],
  );
}

Widget kmItemSkeleton() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.w),
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
    width: double.infinity,
    decoration: BoxDecoration(
        color: white,
        boxShadow: shadow1,
        borderRadius: BorderRadius.circular(8.r)),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SkeletonLoading(
          width: 64.w,
          height: 64.w,
          cornerRadius: 8.r,
        ),
        SizedBox(width: 20.w),
        Flexible(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkeletonLoading(width: double.infinity, height: 14.h, cornerRadius: 20.r,),
              SizedBox(height: 6.h,),
              SkeletonLoading(width: double.infinity, height: 14.h, cornerRadius: 20.r,),
              SizedBox(height: 20.h,),
              Row(
                children: [
                  Image.asset(
                    'assets/km/icons/calendar_icon.png',
                    width: 12.w,
                    height: 12.w,
                  ),
                  SizedBox(width: 8.w),
                  SkeletonLoading(
                    width: 146.w,
                    height: 10.5.h,
                    cornerRadius: 15.r,
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              SkeletonLoading(width: double.infinity, height: 10.5.h, cornerRadius: 15.r),
              SizedBox(height: 4.5.h,),
              SkeletonLoading(width: double.infinity, height: 10.5.h, cornerRadius: 15.r),
              SizedBox(height: 26.h),
              SkeletonLoading(
                width: 78.w,
                height: 10.5.h,
                cornerRadius: 15.r,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
