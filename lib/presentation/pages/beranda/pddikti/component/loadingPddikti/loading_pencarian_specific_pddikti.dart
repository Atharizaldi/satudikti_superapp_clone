import 'package:app/presentation/component/SkeletonLoading.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingPencarianSpecifikPDDikti extends StatelessWidget {
  const LoadingPencarianSpecifikPDDikti({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(top: 30.h, left: 16.w, right: 16.w),
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 15.h,
        );
      },
      // padding: EdgeInsets.zero,
      itemCount: 4,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
          decoration: BoxDecoration(
              color: white, borderRadius: BorderRadius.circular(10.r)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [keteranganRiwayat()],
          ),
        );
      },
    );
  }

  Widget statusRiwayat() {
    return SkeletonLoading(
      width: 88.w,
      height: 25.h,
      cornerRadius: 10.r,
    );
  }

  Column keteranganRiwayat() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SkeletonLoading(
          width: 180.w,
          height: 11.w,
          cornerRadius: 10.r,
        ),
        SizedBox(height: 14.h),
        SkeletonLoading(
          width: 130.w,
          height: 11.w,
          cornerRadius: 10.r,
        ),
        SizedBox(height: 14.h),
        SkeletonLoading(
          width: 115.w,
          height: 11.w,
          cornerRadius: 10.r,
        ),
        SizedBox(height: 14.h),
        Row(
          children: [
            SkeletonLoading(
              width: 100.w,
              height: 11.w,
              cornerRadius: 10.r,
            ),
          ],
        ),
      ],
    );
  }
}
