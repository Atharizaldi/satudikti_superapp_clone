import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class RatingReviewGMagz extends StatelessWidget {
  final double nilaiRating;

  final int nilaiReview;
  final int nilaiDownload;
  final int nilaiBaca;
  const RatingReviewGMagz({
    Key? key,
    required this.nilaiRating,
    required this.nilaiReview,
    required this.nilaiDownload,
    required this.nilaiBaca,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var _nilaiRating = NumberFormat.compact().format(nilaiRating);
    var _nilaiReview = NumberFormat.compact().format(nilaiReview);
    var _nilaiDownload = NumberFormat.compact().format(nilaiDownload);
    var _nilaiBaca = NumberFormat.compact().format(nilaiBaca);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      width: double.infinity,
      height: 52.w,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color(0x1A5C5E61),
          spreadRadius: -4,
          blurRadius: 16,
          offset: Offset(0, 12), // changes position of shadow
        ),
      ], color: Colors.white, borderRadius: BorderRadius.circular(12.r)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.star_rate_rounded,
                size: 20,
                color: Color.fromRGBO(243, 215, 95, 1),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    nilaiRating.toString(),
                    style: TextStyle(
                        color: Color.fromRGBO(38, 38, 38, 1),
                        fontSize: 16.sp,
                        fontFamily: "Plus Jakarta Sans",
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    " penilaian",
                    style: TextStyle(
                        color: Color.fromRGBO(130, 130, 130, 1),
                        fontSize: 14.sp,
                        fontFamily: "Plus Jakarta Sans",
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ],
          ),
          Container(
            width: 1,
            height: 30,
            color: Color.fromRGBO(217, 217, 217, 1),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _nilaiBaca.toString(),
                style: TextStyle(
                    color: Color.fromRGBO(38, 38, 38, 1),
                    fontSize: 16.sp,
                    fontFamily: "Plus Jakarta Sans",
                    fontWeight: FontWeight.w700),
              ),
              Text(
                " pembaca",
                style: TextStyle(
                    color: Color.fromRGBO(130, 130, 130, 1),
                    fontSize: 14.sp,
                    fontFamily: "Plus Jakarta Sans",
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Container(
            width: 1,
            height: 30,
            color: Color.fromRGBO(217, 217, 217, 1),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _nilaiDownload.toString(),
                style: TextStyle(
                    color: Color.fromRGBO(38, 38, 38, 1),
                    fontSize: 16.sp,
                    fontFamily: "Plus Jakarta Sans",
                    fontWeight: FontWeight.w700),
              ),
              Text(
                " download",
                style: TextStyle(
                    color: Color.fromRGBO(130, 130, 130, 1),
                    fontSize: 14.sp,
                    fontFamily: "Plus Jakarta Sans",
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Container(
            width: 1,
            height: 30,
            color: Color.fromRGBO(217, 217, 217, 1),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _nilaiReview.toString(),
                style: TextStyle(
                    color: Color.fromRGBO(38, 38, 38, 1),
                    fontSize: 16.sp,
                    fontFamily: "Plus Jakarta Sans",
                    fontWeight: FontWeight.w700),
              ),
              Text(
                " review",
                style: TextStyle(
                    color: Color.fromRGBO(130, 130, 130, 1),
                    fontSize: 14.sp,
                    fontFamily: "Plus Jakarta Sans",
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
