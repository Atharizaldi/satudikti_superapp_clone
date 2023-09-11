
import 'package:app/presentation/component/bannerSubJudul.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/ijazahln/component/reusableWidgets/informationCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

  Widget informasi(String text) {
    return InformationCard(
      text: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: text,
              style: TextStyle(
                color: neutralCaption,
                fontSize: 10.sp,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bannerSubJudulTracer(String textSubtitle) {
    return BannerSubJudul(
      subJudul: textSubtitle,
      warna: blue3,
      edgeInsets: EdgeInsets.zero,
    );
  }