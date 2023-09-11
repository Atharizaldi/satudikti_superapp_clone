import 'package:app/presentation/component/SkeletonLoading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SkeletonLoadingSISTER extends StatelessWidget {
  const SkeletonLoadingSISTER({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25.w),
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
          Center(
              child: SkeletonLoading(
            width: double.infinity,
            height: 500,
            cornerRadius: 8.r,
          ))
        ],
      ),
    );
  }
}
