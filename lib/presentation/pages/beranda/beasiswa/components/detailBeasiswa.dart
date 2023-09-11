import 'package:app/common/baseUrl.dart';
import 'package:app/common/launchUrl.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/inkEffect.dart';
import 'package:app/presentation/pages/beranda/beasiswa/components/cardBeasiswa.dart';
import 'package:app/presentation/pages/beranda/beasiswa/components/detailDaftarUnduhanBeasiswa.dart';
import 'package:app/presentation/pages/showWebsite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailBeasiswa extends StatelessWidget {
  final String namaBeasiswa;
  final String namaInstansi;
  final String startDate, endDate;
  final String persyaratan, deskripsi, url;
  final List<String> listTagName;
  final bool isOpen;
  final String urlLampiran;
  final TextStyle styleParagraph = textStyleParagraph.copyWith(
    fontSize: 14.sp,
    color: neutral80,
  );
  bool daftar;
  bool closed;

  DetailBeasiswa(
      {Key? key,
      required this.namaBeasiswa,
      required this.namaInstansi,
      required this.startDate,
      required this.endDate,
      required this.listTagName,
      required this.persyaratan,
      required this.deskripsi,
      required this.url,
      required this.isOpen,
      required this.urlLampiran,
      required this.daftar,
      required this.closed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(urlLampiran);
    return Scaffold(
      appBar: CustomAppBar(title: "Beasiswa"),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(16, 27, 16, 24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(5.r),
                      boxShadow: [
                        BoxShadow(
                          color: shadow,
                          spreadRadius: 0,
                          blurRadius: 40,
                          offset: Offset(0, 16), // changes position of shadow
                        ),
                      ]),
                  width: 358.w,
                  padding: EdgeInsets.only(
                      top: 20.h, bottom: 16.h, left: 16.w, right: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                              Expanded(
                              child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                                child: Wrap(
                                    spacing: 6.w,
                                    runSpacing: 4.h,
                                    children: this
                                        .listTagName
                                        .map((e) => _tag(e))
                                        .toList(),
                                  ),
                              ),
                              ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.w, vertical: 4.h),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: greenBackground,
                                    ),
                                    child: Text(
                                      "Dalam Negeri",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: -0.02.sp,
                                        color: green3,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 10.h),
                              Text(namaInstansi == "" ? " - " : namaInstansi,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
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
                                    color: blue2,
                                    fontSize: 26.sp,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.01.sp),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
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
                                      color: closed ? red2 : neutral60,
                                    ),
                                    SizedBox(width: 10.w),
                                    daftar
                                        ? Flexible(
                                            child: RichText(
                                                text: TextSpan(children: [
                                            TextSpan(
                                                text: "Pendaftaran dibuka ",
                                                style: TextStyle(
                                                    color: neutral50,
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w400,
                                                    letterSpacing: -0.02.sp)),
                                            TextSpan(
                                                text:
                                                    "${formatDate.formatDate(this.startDate)} - ${formatDate.formatDate(this.endDate)}",
                                                style: TextStyle(
                                                    color: neutral50,
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: -0.02.sp))
                                          ])))
                                        : Flexible(
                                            child: RichText(
                                                text: TextSpan(children: [
                                            TextSpan(
                                                text: closed
                                                    ? "Beasiswa "
                                                    : "Akan dibuka ",
                                                style: TextStyle(
                                                    color: closed
                                                        ? red2
                                                        : neutral50,
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w400,
                                                    letterSpacing: -0.02.sp)),
                                            TextSpan(
                                                text: closed
                                                    ? "sudah ditutup"
                                                    : "${(DateTime.now().difference(DateTime.parse(startDate))).inDays.abs() + 1} Hari lagi",
                                                style: TextStyle(
                                                    color: closed
                                                        ? red2
                                                        : neutral50,
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
                              InkEffect(
                                boxDecoration: BoxDecoration(
                                  // border: Border.all(color: red),
                                  color: urlLampiran.isEmpty
                                      ? unselectedTextColor
                                      : blue4,
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                onTap: () {
                                  if (urlLampiran.isNotEmpty) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailDaftarUnduhanBeasiswa(
                                          id: "01",
                                          name: namaBeasiswa,
                                          url:
                                              "$urlSementaraBeasiswa/$urlLampiran",
                                        ),
                                      ),
                                    );
                                    // showDialog(
                                    //     context: context,
                                    //     builder: (BuildContext context) {
                                    //       return AlertDialog(
                                    //           insetPadding: EdgeInsets.zero,
                                    //           shape: RoundedRectangleBorder(
                                    //               borderRadius:
                                    //                   BorderRadius.all(
                                    //                       Radius.circular(
                                    //                           10.r))),
                                    //           content: Column(
                                    //             mainAxisSize: MainAxisSize.min,
                                    //             children: [
                                    //               Row(
                                    //                 children: [
                                    //                   Icon(
                                    //                     Icons.error,
                                    //                     color: red,
                                    //                   ),
                                    //                   SizedBox(
                                    //                     width: 5.0.w,
                                    //                   ),
                                    //                   Text(
                                    //                     "Lampiran tidak tersedia",
                                    //                     style: TextStyle(
                                    //                         color: neutral90,
                                    //                         fontSize: 18.sp,
                                    //                         fontWeight:
                                    //                             FontWeight
                                    //                                 .w600),
                                    //                     textAlign:
                                    //                         TextAlign.center,
                                    //                   ),
                                    //                   SizedBox(
                                    //                     width: 5.0.w,
                                    //                   ),
                                    //                 ],
                                    //               ),
                                    //             ],
                                    //           ));
                                    //     }

                                    //     );
                                  }
                                },
                                child: Container(
                                  width: 358.w,
                                  height: 44.h,
                                  child: Center(
                                    child: Text(
                                      "Lihat Lampiran Beasiswa",
                                      style: TextStyle(
                                        color: white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ]),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 27.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Text(
                    "Tentang Beasiswa",
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: blue2),
                  ),
                ),
                _keterangan(),
                SizedBox(
                  height: 18.h,
                ),
                _persyaratan(),
                SizedBox(
                  height: 10.h,
                ),
                daftar
                    ? SizedBox(
                        height: 0.h,
                      )
                    : _cardButuhInfoDetail(context)
              ],
            ),
          ),
        ],
      )),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: white, boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            blurRadius: 25,
            spreadRadius: 0,
            offset: Offset(0, 6),
          )
        ]),
        child: Container(
          height: 100.h,
          padding:
              EdgeInsets.only(top: 16.h, bottom: 36.h, left: 16.w, right: 16.w),
          child: InkEffect(
            boxDecoration: BoxDecoration(
              // border: Border.all(color: red),
              color: isOpen ? blue4 : unselectedTextColor,
              borderRadius: BorderRadius.circular(5.r),
            ),
            onTap: () {
              if (isOpen) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShowWebsite(
                      title: namaBeasiswa,
                      link: url,
                    ),
                  ),
                );
              }
            },
            child: Container(
              width: 358.w,
              height: 48.h,
              child: Center(
                child: Text(
                  "Daftar Sekarang",
                  style: TextStyle(
                    color: white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
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
          fontSize: 14.sp,
          fontWeight: FontWeight.w200,
          letterSpacing: -0.02.sp,
          color: blue4,
        ),
      ),
    );
  }

  Widget _keterangan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 9.w, right: 9.w),
          child: Html(
            data: deskripsi,
            onLinkTap: (url, _, __, ___) {
              return launchURL(url!);
            },
            style: {
              "p": Style(
                letterSpacing: 0.5,
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                color: neutral80,
                fontWeight: FontWeight.w400,
              ),
            },
          ),
        ),
      ],
    );
  }

  Widget _persyaratan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Text(
            "Persyaratan",
            style: TextStyle(
                fontSize: 16.sp, fontWeight: FontWeight.w600, color: blue2),
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 9.w, right: 9.w),
          child: Html(
            data: persyaratan,
            onLinkTap: (url, _, __, ___) {
              return launchURL(url!);
            },
            style: {
              "p": Style(
                letterSpacing: 0.5,
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                color: neutral80,
                fontWeight: FontWeight.w400,
              ),
            },
          ),
        ),
      ],
    );
  }

  Widget _cardButuhInfoDetail(BuildContext context) {
    return InkEffect(
      boxDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: appBarGradient,
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ShowWebsite(
            title: 'Beasiswa',
            link: 'https://beasiswa.kemdikbud.go.id/',
          ),
        ),
      ),
      child: Container(
        height: 96.sp,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 17.0, left: 20, bottom: 14),
              child: Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                    color: Color(0xff248DDA),
                    image: DecorationImage(
                        image: AssetImage(
                            "assets/kedaireka/icon_banner_info_kedaireka.png")),
                    borderRadius: BorderRadius.circular(5.r)),
              ),
            ),
            SizedBox(
              width: 16.sp,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 20.0,
                ),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Butuh Informasi lebih detail? ",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            color: white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Kunjungi website > ",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            color: green,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget htmlContent(String content) {
    return Html(
      data: content,
      onLinkTap: (url, _, __, ___) {
        return launchURL(url!);
      },
      style: {
        "p": Style(
          color: neutral80,
          fontWeight: FontWeight.w400,
        ),
      },
    );
  }
}
