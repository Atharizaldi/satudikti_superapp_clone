import 'package:app/presentation/component/SkeletonLoading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SkeletonLoadingHomeGmagz extends StatelessWidget {
  const SkeletonLoadingHomeGmagz({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SkeletonLoading(width: 150.w, height: 20.w),
                SkeletonLoading(width: 100.w, height: 20.w),
              ],
            ),
          ),
          SizedBox(
            height: 5.w,
          ),
          Row(
            children: [
              for (int i = 0; i < 2; i++)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: SkeletonLoading(width: 150.w, height: 200.w)),
                ),
            ],
          ),
          // Row(
          //   children: [
          //     for (int i = 0; i < 2; i++)
          //       Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: ClipRRect(
          //             borderRadius: BorderRadius.circular(8.r),
          //             child: SkeletonLoading(width: 150.w, height: 200.w)),
          //       ),
          //   ],
          // )
        ],
      ),
    );
  }
}
