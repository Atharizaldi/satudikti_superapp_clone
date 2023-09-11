import 'package:app/presentation/pages/beranda/kampusMerdeka/component/card_CKM_Loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../component/SkeletonLoading.dart';

class SkeletonLoadingTabBarCKM extends StatelessWidget {
  const SkeletonLoadingTabBarCKM({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 25.h, left: 16.w, right: 16.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SkeletonLoading(
                width: 100.w,
                height: 30.w,
                cornerRadius: 8.r,
              ),
              SizedBox(
                width: 15.w,
              ),
              SkeletonLoading(
                width: 80.w,
                height: 30.w,
                cornerRadius: 8.r,
              ),
              SizedBox(
                width: 15.w,
              ),
              SkeletonLoading(
                width: 90.w,
                height: 30.w,
                cornerRadius: 8.r,
              )
            ],
          ),
          SizedBox(
            height: 25.w,
          ),
          ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return SkeletonLoadingCKM();
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 12.h,
                );
              },
              itemCount: 2)
        ],
      ),
    );
  }
}
