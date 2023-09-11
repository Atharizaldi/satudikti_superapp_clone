import 'package:app/presentation/component/SkeletonLoading.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/components/mainPageKD/skeleton_main_program_terdaftar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SkeletonLoadingKD extends StatelessWidget {
  const SkeletonLoadingKD({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(top: 20.sp),
      // padding: EdgeInsets.symmetric(horizontal: 30.sp, vertical: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20.w),
            color: white,
            padding: EdgeInsets.symmetric(horizontal: 30.sp, vertical: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonLoading(
                  width: 64.sp,
                  height: 64.sp,
                  cornerRadius: 10.r,
                ),
                SizedBox(
                  width: 20.sp,
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SkeletonLoading(
                        width: 280.sp,
                        height: 14,
                        cornerRadius: 5.r,
                      ),
                      SizedBox(
                        height: 6.sp,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 28.sp,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Program Terdaftar",
                style: textStyleParagraph.copyWith(
                    color: blue3, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.sp,
              ),
              SkeletonMainProgramTerdaftar(),
            ],
          )
        ],
      ),
    );
  }
}
