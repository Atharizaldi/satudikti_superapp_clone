import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewBannerSubJudul extends StatelessWidget {
  final String subJudul;
  final String subJudul2;
  final Color color;
  const NewBannerSubJudul({
    Key? key,
    required this.subJudul,
    required this.subJudul2,
    this.color = whiteBgPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            this.subJudul,
            style: TextStyle(
              color: blue3,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            this.subJudul2,
            style: TextStyle(
              fontSize: 14.sp,
              color: neutral50,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}
