import 'package:app/presentation/component/SkeletonLoading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SkeletonLoadingDetailMajalahGMagz extends StatelessWidget {
  const SkeletonLoadingDetailMajalahGMagz({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              SkeletonLoading(
                width: 168.w,
                height: 244.h,
                cornerRadius: 8.r,
              ),
              SizedBox(
                height: 16.h,
              ),
              SkeletonLoading(width: 150.w, height: 25.h),
              SizedBox(
                height: 16.h,
              ),
              SkeletonLoading(
                width: double.infinity,
                height: 52.h,
                cornerRadius: 12.r,
              ),
              SizedBox(
                height: 16.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SkeletonLoading(width: 57.w, height: 24.w),
                  SizedBox(
                    width: 20.h,
                  ),
                  SkeletonLoading(width: 57.w, height: 24.w),
                ],
              ),
              SizedBox(
                height: 16.h,
              ),
              SkeletonLoading(width: double.infinity, height: 200)
            ],
          ),
        ),
      ),
    );
  }
}
