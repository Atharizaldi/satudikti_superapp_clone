import 'package:app/presentation/component/SkeletonLoading.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget authorsListLoadingWithTotal() {
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
          return authorsCardSkeleton();
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

Widget authorsCardSkeleton() {
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

Widget authorsProfileSkeleton() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      //photo
      Column(
        children: [
          SkeletonLoading(
            width: 64.w,
            height: 64.w,
            cornerRadius: 10.r,
          ),
          SizedBox(
            height: 12.h,
          ),
          SkeletonLoading(width: 15.w, height: 15.h),
        ],
      ),
      SizedBox(
        width: 20.w,
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SkeletonLoading(width: double.infinity, height: 15.h),
            SizedBox(
              height: 6.h,
            ),
            SkeletonLoading(width: double.infinity, height: 20.h),
            SizedBox(
              height: 6.h,
            ),
            SkeletonLoading(width: double.infinity, height: 15.h),
            SizedBox(
              height: 6.h,
            ),
            SkeletonLoading(width: double.infinity, height: 15.h),
          ],
        ),
      ),
    ],
  );
}

Widget authorsSummarySkeleton() {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          itemRankSkeleton("SINTA Score Overall"),
          SizedBox(
            width: 20.w,
          ),
          itemRankSkeleton("SINTA Score 3 Yr")
        ],
      ),
      SizedBox(
        height: 20.h,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          itemRankSkeleton("Affil Score"),
          SizedBox(
            width: 20.w,
          ),
          itemRankSkeleton("Affil Score 3Yr")
        ],
      ),
      SizedBox(
        height: 20.h,
      ),
      summaryTableSkeleton(),
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

Widget summaryTableSkeleton() {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
    decoration:
        BoxDecoration(color: white, borderRadius: BorderRadius.circular(10.r)),
    child: Column(
      children: [
        _itemTableTitle(),
        SizedBox(
          height: 10.h,
        ),
        _itemTable("Article"),
        SizedBox(
          height: 18.h,
        ),
        _itemTable("Citation"),
        SizedBox(
          height: 18.h,
        ),
        _itemTable("Cited Document"),
        SizedBox(
          height: 18.h,
        ),
        _itemTable("H-Index"),
        SizedBox(
          height: 18.h,
        ),
        _itemTable("I10-Index"),
        SizedBox(
          height: 18.h,
        ),
        _itemTable("G-Index"),
      ],
    ),
  );
}

Widget _itemTableTitle() {
  TextStyle _titleTextStyle = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
  );
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        width: 90.w,
        height: 15.h,
      ),
      Container(
        width: 53.w,
        height: 15.h,
        child: Center(
          child: Text(
            "Scopus",
            style: _titleTextStyle.copyWith(color: Color(0xffF79400)),
          ),
        ),
      ),
      Container(
        width: 53.w,
        height: 15.h,
        child: Center(
          child: Text(
            "GScholar",
            style: _titleTextStyle.copyWith(color: Color(0xff3FBE2B)),
          ),
        ),
      ),
      Container(
        width: 53.w,
        height: 15.h,
        child: Center(
          child: Text(
            "WOS",
            style: _titleTextStyle.copyWith(color: Color(0xff0E7AC5)),
          ),
        ),
      ),
    ],
  );
}

Widget _itemTable(String value1) {
  TextStyle _titleTextStyle = TextStyle(
    color: neutral70,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
  );
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        width: 90.w,
        height: 15.h,
        child: Text(
          value1,
          style: _titleTextStyle,
        ),
      ),
      SkeletonLoading(
        width: 53.w,
        height: 15.h,
      ),
      SkeletonLoading(
        width: 53.w,
        height: 15.h,
      ),
      SkeletonLoading(
        width: 53.w,
        height: 15.h,
      ),
    ],
  );
}
