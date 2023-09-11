import 'package:app/presentation/component/SkeletonLoading.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget journalsListLoadingWithTotal() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SkeletonLoading(width: 220.w, height: 17.h),
      SizedBox(
        height: 30.h,
      ),
      ListView.separated(
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (BuildContext context, index) {
          return journalsCardSkeleton();
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 20.h,
          );
        },
      ),
    ],
  );
}

Widget journalsCardSkeleton() {
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

Widget headerJournalsSkeleton() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: Image.asset(
          "assets/sinta/journal.png",
          width: 120.w,
          height: 155.h,
        ),
      ),
      SizedBox(
        height: 20.h,
      ),
      SkeletonLoading(width: double.infinity, height: 30.h),
      SizedBox(
        height: 20.h,
      ),
      SkeletonLoading(width: double.infinity, height: 18.h),
      SizedBox(
        height: 20.h,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SkeletonLoading(width: double.infinity, height: 15.h),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: SkeletonLoading(width: double.infinity, height: 15.h),
          ),
        ],
      ),
      SizedBox(
        height: 20.h,
      ),
      SkeletonLoading(width: 150.w, height: 15.h),
      SizedBox(
        height: 20.h,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          itemRankSkeleton("Impact Factor"),
          SizedBox(
            width: 20.w,
          ),
          itemRankSkeleton("Accreditation")
        ],
      ),
    ],
  );
}

Widget itemRankSkeleton(String title) {
  TextStyle _itemTextStyle =
      TextStyle(color: neutral30, fontSize: 10.sp, fontWeight: FontWeight.w500);
  return Expanded(
    child: Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
          color: white, borderRadius: BorderRadius.circular(10.r)),
      child: Column(
        children: [
          Text(
            title,
            style: _itemTextStyle,
          ),
          SizedBox(
            height: 8.h,
          ),
          SkeletonLoading(width: 50.w, height: 15.h),
        ],
      ),
    ),
  );
}

Widget journalsPublicationSkeleton() {
  return ListView.separated(
    padding: EdgeInsets.zero,
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: 10,
    itemBuilder: (BuildContext context, index) {
      return itemPublikasiSkeleton();
    },
    separatorBuilder: (BuildContext context, int index) {
      return SizedBox(
        height: 20.h,
      );
    },
  );
}

Widget itemPublikasiSkeleton() {
  return Container(
    decoration: BoxDecoration(
        color: white, borderRadius: BorderRadius.circular(10.r)),
    padding: EdgeInsets.all(20.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SkeletonLoading(width: double.infinity, height: 20.h),
        SizedBox(
          height: 15.h,
        ),
        SkeletonLoading(width: double.infinity, height: 15.h),
        SizedBox(
          height: 15.h,
        ),
        SkeletonLoading(width: double.infinity, height: 15.h),
        SizedBox(
          height: 15.h,
        ),
        Row(
          children: [
            SkeletonLoading(width: 70.w, height: 15.h),
            SizedBox(
              width: 30.w,
            ),
            SkeletonLoading(width: 70.w, height: 15.h),
            SizedBox(
              width: 30.w,
            ),
            SkeletonLoading(width: 70.w, height: 15.h),
          ],
        ),
      ],
    ),
  );
}