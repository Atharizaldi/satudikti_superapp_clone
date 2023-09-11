import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/component/server_problem.dart';
import 'package:app/presentation/pages/showWebsite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget cardTag(String tag) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.sp),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        border: Border.all(color: green3)),
    child: Text(
      tag,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w200,
          letterSpacing: 0.08.sp,
          color: green3),
    ),
  );
}

Widget cardStatus(String tag, {Color color = green3}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.sp),
    decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(5.r), color: color),
    child: Text(
      tag,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w200,
          letterSpacing: 0.08.sp,
          color: white),
    ),
  );
}

Widget cardButuhInfoDetail(context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.33.sp),
    decoration: BoxDecoration(
      gradient: kompdosHubungiButtonGradient,
      borderRadius: BorderRadius.circular(10.r),
    ),
    child: GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ShowWebsite(
            title: 'Kompetensi Dosen',
            link: 'https://kompetensi-ditdaya.kemdikbud.go.id/web/periode',
          ),
        ),
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/sinta/ic_computer.png",
            width: 64.w,
            height: 64.w,
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Lihat informasi lebih detail',
                style: TextStyle(
                  color: white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 4.w,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Kunjungi website",
                    style: TextStyle(
                        color: white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.08.sp),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Icon(
                    Icons.navigate_next,
                    color: white,
                    size: 15,
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget noOpenedProgram() {
  return ListView(
    padding: EdgeInsets.zero,
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    children: [
      SizedBox(height: 33.sp),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 28.w),
        child: Column(
          children: [
            Image.asset(
              'assets/km/tutup.png',
              width: 190.w,
              height: 122.h,
            ),
            SizedBox(height: 32.sp),
            Text.rich(
              TextSpan(children: [
                TextSpan(
                  text: 'Belum ada ',
                  style: TextStyle(
                      color: neutral80,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: 'program Kompetensi Dosen Dibuka',
                  style: TextStyle(
                    color: neutral80,
                    fontSize: 10.sp,
                  ),
                ),
              ]),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
      SizedBox(
        height: 53.sp,
      ),
    ],
  );
}

Widget serverProblem() {
  return Container(
      padding: EdgeInsets.only(top: 43.sp, bottom: 51.sp),
      width: double.infinity,
      height: 350.w,
      child: ServerProblem(
        onPressed: () {},
        buttonHide: true,
        bgColor: whiteBgPage,
        physics: NeverScrollableScrollPhysics(),
      ));
}

Widget noInternetWithContainer() {
  return Container(
      padding: EdgeInsets.only(top: 43.sp, bottom: 51.sp),
      width: double.infinity,
      height: 350.w,
      child: NoInternet(
        onPressed: () {},
        buttonHide: true,
        bgColor: whiteBgPage,
        physics: NeverScrollableScrollPhysics(),
      ));
}
