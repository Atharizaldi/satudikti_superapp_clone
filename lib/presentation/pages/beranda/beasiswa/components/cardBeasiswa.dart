import 'package:app/common/dateFormat.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/inkEffect.dart';
import 'package:app/presentation/pages/beranda/beasiswa/components/detailBeasiswa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final FormatDate formatDate = FormatDate();

class CardBeasiswa extends StatelessWidget {
  final String namaBeasiswa;
  final String namaInstansi;
  final String startDate, endDate, deskripsi, persyaratan, url;
  final List<String> listTagName;
  final bool isOpen;
  final String urlLampiran;
  final bool daftar;
  final bool closed;

  const CardBeasiswa(
      {Key? key,
      required this.namaBeasiswa,
      required this.namaInstansi,
      required this.startDate,
      required this.endDate,
      required this.listTagName,
      required this.deskripsi,
      required this.persyaratan,
      required this.url,
      required this.isOpen,
      required this.urlLampiran,
      required this.daftar,
      required this.closed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkEffect(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (builder) => DetailBeasiswa(
                  deskripsi: deskripsi,
                  persyaratan: persyaratan,
                  url: url,
                  namaBeasiswa: namaBeasiswa,
                  namaInstansi: namaInstansi,
                  startDate: startDate,
                  endDate: endDate,
                  listTagName: listTagName,
                  isOpen: isOpen,
                  urlLampiran: urlLampiran,
                  daftar: daftar,
                  closed: closed))),
      child: Container(
        width: 358.w,
        padding:
            EdgeInsets.only(top: 20.h, bottom: 20.h, left: 16.w, right: 16.w),
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: shadow,
                spreadRadius: 0,
                blurRadius: 40,
                offset: Offset(0, 16), // changes position of shadow
              ),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              "assets/beasiswa/beasiswa_default_card.png",
              width: 70.sp,
              height: 70.sp,
            ),
            SizedBox(
              width: 20.w,
            ),
            _cardInfo()
          ],
        ),
      ),
    );
  }

  Widget _cardInfo() {
    return Flexible(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
          Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
                spacing: 6.w,
                runSpacing: 4.h,
                children: this.listTagName.map((e) => _tag(e)).toList(),
              ),
          ),
      ),
            SizedBox(
              width: 8.w,
            ),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(10.r),
            //     color: greenBackground,
            //   ),
            //   child: Text(
            //     "Dalam Negeri",
            //     style: TextStyle(
            //       fontSize: 12.sp,
            //       fontWeight: FontWeight.w200,
            //       letterSpacing: -0.02.sp,
            //       color: green3,
            //     ),
            //   ),
            // )
          ],
        ),
        SizedBox(height: 10.h),
        Text(namaInstansi == "" ? " - " : namaInstansi,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w200,
                color: neutral40,
                letterSpacing: -0.02.sp)),
        SizedBox(
          height: 4.h,
        ),
        Text(
          namaBeasiswa == "" ? " - " : namaBeasiswa,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: blue4,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.01.sp),
        ),
        SizedBox(
          height: 10.h,
        ),
        closed
            ? Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0.r),
                  color: neutralBackground,
                ),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/icons/calendar.png",
                      width: 12.w,
                      height: 13.33.w,
                      color: red2,
                    ),
                    SizedBox(width: 10.w),
                    Flexible(
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: "Beasiswa ",
                            style: TextStyle(
                                color: red2,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.02.sp)),
                        TextSpan(
                            text: "sudah ditutup",
                            style: TextStyle(
                                color: red2,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.02.sp))
                      ])),
                      //     child: Text(
                      //   'tutup',
                      //   style: TextStyle(
                      //       color: red2,
                      //       fontSize: 12.sp,
                      //       fontWeight: FontWeight.w500,
                      //       letterSpacing: -0.02.sp),
                      // )
                    )
                  ],
                ))
            : Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0.r),
                  color: neutralBackground,
                ),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/icons/calendar.png",
                      width: 12.w,
                      height: 13.33.w,
                      color: neutral60,
                    ),
                    SizedBox(width: 10.w),
                    daftar
                        ? Flexible(
                            child: Text(
                            '${formatDate.formatDate(this.startDate)} - ${formatDate.formatDate(this.endDate)}',
                            style: TextStyle(
                                color: neutral50,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.02.sp),
                          ))
                        : Flexible(
                            child: RichText(
                                text: TextSpan(children: [
                            TextSpan(
                                text: "Akan dibuka ",
                                style: TextStyle(
                                    color: neutral50,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: -0.02.sp)),
                            TextSpan(
                                text:
                                    "${(DateTime.now().difference(DateTime.parse(startDate))).inDays.abs() + 1} Hari lagi",
                                style: TextStyle(
                                    color: neutral50,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: -0.02.sp))
                          ])))
                  ],
                ),
              ),
        SizedBox(
          height: 10.h,
        ),
        daftar
            ? Text(
                "Lihat & Daftar  >",
                style: TextStyle(
                    fontSize: 12.sp, fontWeight: FontWeight.w700, color: blue4),
              )
            : Text(
                "Lihat  >",
                style: TextStyle(
                    fontSize: 12.sp, fontWeight: FontWeight.w700, color: blue4),
              )
      ]),
    );
  }

  Widget _tag(String penerimaName) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: blueBackground,
      ),
      child: Text(
        penerimaName,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w200,
          letterSpacing: -0.02.sp,
          color: blue4,
        ),
      ),
    );
  }
}
