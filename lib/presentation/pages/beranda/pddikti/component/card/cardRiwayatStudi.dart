import 'package:app/common/semesterParser.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardRiwayatStudi extends StatelessWidget {
  final String namaMK, kodeMK, smt, namaPT, sks;
  const CardRiwayatStudi(
      {Key? key,
      required this.namaMK,
      required this.kodeMK,
      required this.smt,
      required this.namaPT,
      required this.sks})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            this.namaMK,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14.sp,
              color: neutral80,
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            this.namaPT,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: neutral40,
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            switchSemester(this.smt),
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14.sp,
              color: neutral40,
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            'Kode Mata Kuliah: ${this.kodeMK}',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: neutral30,
              fontSize: 12.sp,
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: green3),
                  borderRadius: BorderRadius.circular(5.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 4.w),
                child: Center(
                  child: Text(
                    this.sks + ' SKS',
                    style: TextStyle(
                      color: green3,
                      fontWeight: FontWeight.w400,
                      fontSize: 10.sp,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
