import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardScopus extends StatelessWidget {
  final String title, deskripsi, creator;
  final String quartiles;
  final int cited;
  const CardScopus({
    Key? key,
    required this.title,
    required this.deskripsi,
    required this.creator,
    required this.quartiles,
    required this.cited
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(151, 151, 151, 0.06),
              offset: Offset(0, 4),
              blurRadius: 15,
              spreadRadius: 10)
        ],
      ),
      child: _cardInfo(),
    );
  }

  Widget _cardInfo() {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: blue4, fontSize: 16.sp, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 12.sp),
        Row(
          children: [
            Image.asset(
              'assets/bima/icon_loop.png', 
              width: 20, 
              height: 20
            ),
            SizedBox(width: 2.sp),
            Text(
              '$quartiles Journal',
              style: textStyleSmallParagraph.copyWith(
                color: orange3,
                fontWeight: FontWeight.w500
              ),
            ),
            SizedBox(width: 10.w),
            Text(
              '$cited Cited',
              style: textStyleSmallParagraph.copyWith(
                color: blue4,
                fontWeight: FontWeight.w400
              ),
            )
          ],
        ),
        SizedBox(height: 12.sp),
        Text(
          deskripsi,
          style: TextStyle(
            color: neutral50, 
            fontSize: 12.sp, 
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.italic,
            height: 1.3.sp
          ),
        ),
        SizedBox(height: 12.sp),
        Text(
          'Creator : $creator',
          style: textStyleSmallParagraph.copyWith(
            color: neutral50, 
            fontStyle: FontStyle.italic
          ),
        ),
      ]),
    );
  }
}
