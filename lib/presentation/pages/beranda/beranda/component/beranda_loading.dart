import 'package:app/presentation/component/SkeletonLoading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget modulLoading() {
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 4,
      mainAxisSpacing: 20,
      childAspectRatio: 0.8,
    ),
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    padding: EdgeInsets.symmetric(
      horizontal: 36.w,
      vertical: 8.w,
    ),
    itemCount: 8,
    itemBuilder: (context, index) {
      return itemModulSkeleton();
    },
  );
}

Widget itemModulSkeleton() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SkeletonLoading(width: 40.w, height: 20.h),
      SizedBox(height: 22.h),
      SkeletonLoading(
        width: 60.w,
        height: 10.h,
        cornerRadius: 15.r,
      ),
      SizedBox(height: 7.h),
      SkeletonLoading(width: 60.w, height: 10.h, cornerRadius: 15.r),
    ],
  );
}

Widget pengumumanLoading() {
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 20.w,
      mainAxisSpacing: 20.w,
      childAspectRatio: 0.881,
    ),
    padding: EdgeInsets.symmetric(horizontal: 16.w),
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemCount: 4,
    itemBuilder: (context, index) {
      return itemPengumumanSkeleton();
    },
  );
}

Widget itemPengumumanSkeleton() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SkeletonLoading(width: 168.w, height: 107.h),
      SizedBox(height: 12.h),
      SkeletonLoading(
        width: 168.w,
        height: 12.h,
        cornerRadius: (17.5).r,
      ),
      SizedBox(height: 5.h),
      SkeletonLoading(
        width: 168.w,
        height: 12.h,
        cornerRadius: (17.5).r,
      ),
      SizedBox(height: 14.h),
      SkeletonLoading(
        width: 168.w,
        height: (8.75).h,
        cornerRadius: (17.5).r,
      ),
      SizedBox(height: (3.75).h),
      SkeletonLoading(
        width: 168.w,
        height: (8.75).h,
        cornerRadius: (17.5).r,
      ),
    ],
  );
}

Widget beritaLoading() {
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 20.w,
      mainAxisSpacing: 20.w,
    ),
    padding: EdgeInsets.symmetric(horizontal: 16.w),
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemCount: 4,
    itemBuilder: (context, index) {
      return itemBeritaSkeleton();
    },
  );
}

Widget itemBeritaSkeleton() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SkeletonLoading(width: 168.w, height: 107.h),
      SizedBox(height: 12.h),
      SkeletonLoading(
        width: 168.w,
        height: 12.h,
        cornerRadius: (17.5).r,
      ),
      SizedBox(height: 5.h),
      SkeletonLoading(
        width: 168.w,
        height: 12.h,
        cornerRadius: (17.5).r,
      ),
      SizedBox(height: 10.h),
      SkeletonLoading(
        width: 77.w,
        height: (8.75).h,
        cornerRadius: (17.5).r,
      ),
    ],
  );
}