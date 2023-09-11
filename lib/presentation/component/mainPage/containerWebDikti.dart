import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/showWebsite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget containerWebDikti(BuildContext context) {
  String urlWeb = 'https://dikti.kemdikbud.go.id';
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
    width: 357.w,
    height: 156.h,
    decoration: BoxDecoration(
      boxShadow: shadow1,
      borderRadius: BorderRadius.circular(10.r),
      color: white,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 64.w,
          height: 64.h,
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: Color(0xffF8F9FD),
          ),
          child: Image.asset(
            'assets/hubungiKami/ditjen_dikti.png',
          ),
        ),
        SizedBox(
          width: 12.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Direktorat Jenderal Pendidikan\nTinggi, Riset, dan Teknologi",
              style: TextStyle(
                  fontSize: 14.sp, fontWeight: FontWeight.w700, color: blue4),
            ),
            SizedBox(
              height: 6.h,
            ),
            Text(
              "Kementerian Pendidikan, Kebudayaan,\nRiset, dan Teknologi",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: teksAbuCerah4,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShowWebsite(
                      title: 'Website Dikti',
                      link: urlWeb,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      "Kunjungi Website",
                      style: TextStyle(
                        color: blue4,
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp,
                        fontFamily: "Plus Jakarta Sans",
                      ),
                    ),
                    SizedBox(width: 8.w),
                    ImageIcon(
                      AssetImage('assets/profil/navigator_next.png'),
                      size: 12,
                      color: blue4,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
