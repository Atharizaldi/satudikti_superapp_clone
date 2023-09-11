//Card untuk hasil filter di Diklat

import 'package:app/common/dateFormat.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardDiklat extends StatelessWidget {
  final String nama;
  final String jenis, date, penyelenggara;

  const CardDiklat({
    Key? key,
    required this.nama,
    required this.jenis,
    required this.date,
    required this.penyelenggara,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.sp,
      margin: EdgeInsets.fromLTRB(16, 20, 16, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: white,
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(151, 151, 151, 0.06),
              offset: Offset(0, 4),
              blurRadius: 15,
              spreadRadius: 10)
        ],
      ),
      child: _detailCard(),
    );
  }

  Widget _detailCard() {
    return Flexible(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nama,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.4.sp,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 5.h),
            Text(
              jenis,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: neutral70,
                letterSpacing: -0.5.sp,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 5.h),
            Row(
              children: [
                Text(
                  penyelenggara,
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: neutral40),
                  textAlign: TextAlign.justify,
                ),
                Text(','),
                SizedBox(width: 1.w),
                Text(
                  '${FormatDate.formatDateStatic(this.date)}',
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: neutral40),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ],
        ),
      ),
    );

    // return Container(
    //   child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    //     SelectableText(
    //       truncate(nama, 80),
    //       enableInteractiveSelection: false,
    //       //maxLines: 4,
    //       //overflow: TextOverflow.ellipsis,
    //       style: TextStyle(
    //           color: blue4, fontSize: 16.sp, fontWeight: FontWeight.bold),
    //     ),
    //     SizedBox(height: 16.5.sp),
    //     Row(
    //       children: [
    //         Flexible(
    //             child: SelectableText(
    //           '${FormatDate.formatDateStatic(this.date)}',
    //           style: TextStyle(
    //             color: neutral80,
    //             fontSize: 10.5.sp,
    //             fontWeight: FontWeight.w700,
    //           ),
    //         ))
    //       ],
    //     ),
    //   ]),
    // );
  }
}
