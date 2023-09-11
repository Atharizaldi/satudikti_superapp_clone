import 'package:app/presentation/component/SkeletonLoading.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget sintaLoading() {
  return Center(
      child: CircularProgressIndicator(
    color: blueLinear1,
  ));
}

Widget kunjungiWebsiteSkeleton() {
  return SkeletonLoading(
    width: double.infinity,
    height: 96.h,
    cornerRadius: 5.r,
  );
}

Widget scopusPublicationSkeleton() {
  return ListView.separated(
    padding: EdgeInsets.zero,
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: 10,
    itemBuilder: (BuildContext context, index) {
      return itemPublikasiScopusSkeleton();
    },
    separatorBuilder: (BuildContext context, int index) {
      return SizedBox(
        height: 20.h,
      );
    },
  );
}

Widget itemPublikasiScopusSkeleton() {
  return Container(
    decoration:
        BoxDecoration(color: white, borderRadius: BorderRadius.circular(10.r)),
    padding: EdgeInsets.all(20.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SkeletonLoading(width: double.infinity, height: 15.h),
        SizedBox(
          height: 10.h,
        ),
        Row(
          children: [
            SkeletonLoading(width: 80.w, height: 15.h),
            SizedBox(
              width: 12.w,
            ),
            SkeletonLoading(width: 50.w, height: 15.h),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        SkeletonLoading(width: double.infinity, height: 15.h),
        SizedBox(
          height: 10.h,
        ),
        SkeletonLoading(width: double.infinity, height: 15.h),
      ],
    ),
  );
}

Widget sintaSearchSkeleton() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.w),
    child: SingleChildScrollView(
      child: Column(
        children: [
          _authorsCardSkeleton(),
          SizedBox(
            height: 20.h,
          ),
          _authorsCardSkeleton(),
          SizedBox(
            height: 20.h,
          ),
          _affiliationsCardSkeleton(),
          SizedBox(
            height: 20.h,
          ),
          _affiliationsCardSkeleton(),
          SizedBox(
            height: 20.h,
          ),
          _journalsCardSkeleton(),
          SizedBox(
            height: 20.h,
          ),
          _journalsCardSkeleton()
        ],
      ),
    ),
  );
}

Widget _authorsCardSkeleton() {
  return Container(
    padding: EdgeInsets.all(20.w),
    decoration: BoxDecoration(
      color: white,
      borderRadius: BorderRadius.circular(10.r),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SkeletonLoading(width: double.infinity, height: 20.h),
        SizedBox(
          height: 12.h,
        ),
        SkeletonLoading(width: double.infinity, height: 15.h),
        SizedBox(
          height: 8.h,
        ),
        SkeletonLoading(width: double.infinity, height: 15.h),
      ],
    ),
  );
}

Widget _affiliationsCardSkeleton() {
  return Container(
    padding: EdgeInsets.all(20.w),
    decoration: BoxDecoration(
      color: white,
      borderRadius: BorderRadius.circular(10.r),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SkeletonLoading(
          width: 60.w,
          height: 60.w,
          cornerRadius: 10.r,
        ),
        SizedBox(
          width: 12.w,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkeletonLoading(width: double.infinity, height: 20.h),
              SizedBox(
                height: 12.h,
              ),
              SkeletonLoading(width: double.infinity, height: 15.h),
              SizedBox(
                height: 8.h,
              ),
              SkeletonLoading(width: double.infinity, height: 15.h),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _journalsCardSkeleton() {
  return Container(
    padding: EdgeInsets.all(20.w),
    decoration: BoxDecoration(
      color: white,
      borderRadius: BorderRadius.circular(10.r),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SkeletonLoading(width: double.infinity, height: 20.h),
        SizedBox(
          height: 12.h,
        ),
        SkeletonLoading(width: double.infinity, height: 15.h),
        SizedBox(
          height: 8.h,
        ),
        Row(
          children: [
            SkeletonLoading(width: 150.w, height: 15.h),
            SizedBox(
              width: 8.w,
            ),
            SkeletonLoading(width: 150.w, height: 15.h),
          ],
        ),
        SizedBox(
          height: 8.h,
        ),
        SkeletonLoading(width: double.infinity, height: 15.h),
      ],
    ),
  );
}
