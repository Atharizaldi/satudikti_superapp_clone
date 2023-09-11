import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabDetailProdi extends StatelessWidget {
  final String deksripsi, visi, misi, kompetensi;
  const TabDetailProdi(
      {Key? key,
      required this.deksripsi,
      required this.visi,
      required this.misi,
      required this.kompetensi})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: whiteBgPage,
        child: (deksripsi != "" && visi != "" && misi != "" && kompetensi != "")
            ? Column(
                children: [
                  bigCard(context, 'Deskripsi', this.deksripsi),
                  SizedBox(
                    height: 20.h,
                  ),
                  bigCard(context, 'Visi', this.visi),
                  SizedBox(
                    height: 20.h,
                  ),
                  bigCard(context, 'Misi', this.misi),
                  SizedBox(
                    height: 20.h,
                  ),
                  bigCard(context, 'Kompetensi', this.kompetensi)
                ],
              )
            : _dataTidakDitemukan());
  }

  Container bigCard(BuildContext context, String judul, String isi) {
    if (isi == '') {
      return Container();
    } else {
      return Container(
        width: screenWidth(context) * (0.9),
        padding: EdgeInsets.symmetric(horizontal: 21.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: abu5,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              // height: screenHeight(context) * (1 / 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  judul,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: blue4,
                      fontSize: 14.sp),
                ),
              ),
            ),
            Container(
                width: double.infinity,
                child: Html(
                  data: isi,
                  style: {
                    "body": Style(
                        fontSize: FontSize(12.sp),
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.8.sp,
                        color: Color(0xff9B9B9B),
                        lineHeight: LineHeight.number(1.285),
                        fontFamily: "Jakarta Sans"),
                  },
                ))
          ],
        ),
      );
    }
  }

  Column _dataTidakDitemukan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30.w,
        ),
        Center(
          child: Image.asset(
            'assets/km/tutup.png',
            width: 190.w,
            height: 122.w,
          ),
        ),
        SizedBox(
          height: 30.w,
        ),
        Center(
          child: Text(
            "Data yang ditampilkan tidak ditemukan",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w400, fontSize: 10.sp, color: neutral50),
          ),
        ),
        SizedBox(
          height: 20.w,
        ),
      ],
    );
  }
}
