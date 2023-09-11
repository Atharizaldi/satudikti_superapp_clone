import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyDataPage extends StatelessWidget {
  final Color? bgColor;
  final ScrollPhysics? physics;
  const EmptyDataPage({
    Key? key,
    this.bgColor,
    this.physics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: SingleChildScrollView(
          physics: physics ?? ClampingScrollPhysics(),
          child: Column(
            children: [
              Image.asset(
                'assets/sister/data_not_found.png',
                width: 235.w,
                height: 170.w,
              ),
              SizedBox(height: 20.h),
              Text(
                'Ups',
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              SizedBox(height: 8.h),
              Text(
                'Tidak ada data yang ditemukan',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: neutral80,
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
