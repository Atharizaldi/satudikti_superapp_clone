import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BannerSubJudul extends StatelessWidget {
  final String subJudul;
  final Color warna;
  final EdgeInsets edgeInsets;
  final dynamic fontWeight;
  const BannerSubJudul({
    Key? key,
    required this.subJudul,
    required this.warna,
    required this.edgeInsets,
    this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: edgeInsets,
      width: double.infinity,
      child: Text(
        this.subJudul,
        style: TextStyle(
          color: warna,
          fontSize: 20.sp,
          fontWeight: fontWeight ?? FontWeight.w600,
        ),
      ),
    );
  }
}
