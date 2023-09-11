import 'package:app/presentation/component/SkeletonLoading.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget programBeasiswaLoading() {
  return Container(
    margin: EdgeInsets.all(16),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SkeletonLoading(
          width: 240.w,
          height: 17.h,
          cornerRadius: 15.r,
        ),
        SizedBox(
          height: 20.w,
        ),
        Flexible(
          child: ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (BuildContext context, index) {
              return itemBeasiswaSkeleton();
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 20.h);
            },
          ),
        ),
      ],
    ),
  );
}

Widget itemBeasiswaSkeleton() {
  return Container(
    width: 358.w,
    padding: EdgeInsets.all(20.w),
    decoration:
        BoxDecoration(color: white, borderRadius: BorderRadius.circular(10.r)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SkeletonLoading(
          width: 70.w,
          height: 70.w,
        ),
        SizedBox(
          width: 20.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SkeletonLoading(
              width: 152.w,
              height: 14.h,
              cornerRadius: 20.r,
            ),
            SizedBox(height: 14.5.h),
            Row(
              children: [
                Image.asset(
                  "assets/icons/calendar.png",
                  width: 12.w,
                  height: 13.33.w,
                ),
                SizedBox(width: 10.w),
                SkeletonLoading(
                  width: 146.w,
                  height: 10.5.h,
                  cornerRadius: 15.r,
                ),
              ],
            ),
            SizedBox(height: 9.h),
            SkeletonLoading(
              width: 51.w,
              height: 10.5.h,
              cornerRadius: 15.r,
            ),
            SizedBox(height: 20.h),
            Container(
              width: 160.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SkeletonLoading(
                    width: 32.w,
                    height: 8.75.h,
                    cornerRadius: 12.5.r,
                  ),
                  SkeletonLoading(
                    width: 52.w,
                    height: 8.75.h,
                    cornerRadius: 12.5.r,
                  ),
                  SkeletonLoading(
                    width: 32.w,
                    height: 8.75.h,
                    cornerRadius: 12.5.r,
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            SkeletonLoading(
              width: 78.w,
              height: 10.5.h,
              cornerRadius: 15.r,
            ),
          ],
        ),
      ],
    ),
  );
}
