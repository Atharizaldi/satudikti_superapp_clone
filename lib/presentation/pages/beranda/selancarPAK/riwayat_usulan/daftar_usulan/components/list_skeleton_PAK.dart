import 'package:app/presentation/component/SkeletonLoading.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SkeletonLoadingUsulanListPAK extends StatelessWidget {
  const SkeletonLoadingUsulanListPAK({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 20.h),
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 20.h,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              boxShadow: shadow1,
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonLoading(
                      width: 151.w,
                      height: 18.h,
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
                  width: 75.r,
                  height: 75.r,
                  shape: BoxShape.circle,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
