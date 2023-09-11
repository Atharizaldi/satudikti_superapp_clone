import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardSummaryAuthor extends StatelessWidget {
  final int sintaScore, sintaThreeYear, affilScore, affilThreeYear;
  const CardSummaryAuthor({
    Key? key,
    required this.sintaScore,
    required this.sintaThreeYear,
    required this.affilScore,
    required this.affilThreeYear
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              _cardStatistic("SINTA Score Overall", sintaScore),
              SizedBox(width: 16.w),
              _cardStatistic("SINTA Score 3 Yr", sintaThreeYear),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              _cardStatistic("Affil Score", affilScore),
              SizedBox(width: 16.w),
              _cardStatistic("Affil Score 3 Yr", affilThreeYear),
            ],
          ),
        ],
      ),
    );
  }

  Widget _cardStatistic(String title, int jumlah) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: white, 
          borderRadius: BorderRadius.circular(10.r)
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12.sp,
                color: neutral60,
                fontWeight: FontWeight.w500
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              jumlah.toString(),
              style: TextStyle(
                fontSize: 12.sp,
                color: Color(0xFF62CCB3),
                fontWeight: FontWeight.w700
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
