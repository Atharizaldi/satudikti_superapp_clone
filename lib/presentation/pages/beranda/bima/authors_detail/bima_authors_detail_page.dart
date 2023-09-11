import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/sub_title_with_arrow_lainnya.dart';
import 'package:app/presentation/pages/beranda/bima/authors_detail/publikasi_scopus.dart';
import 'package:app/presentation/pages/beranda/bima/component/card_profile.dart';
import 'package:app/presentation/pages/beranda/bima/component/card_scopus.dart';
import 'package:app/presentation/pages/beranda/bima/component/card_summary_author.dart';
import 'package:app/presentation/pages/beranda/bima/component/table_data_bima.dart';
import 'package:app/presentation/pages/showWebsite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BimaAuthorsDetailPage extends StatefulWidget {
  const BimaAuthorsDetailPage({Key? key}) : super(key: key);

  @override
  State<BimaAuthorsDetailPage> createState() => _BimaAuthorsDetailPageState();
}

class _BimaAuthorsDetailPageState extends State<BimaAuthorsDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "Profil Sinta",
        ),
        backgroundColor: whiteBgPage,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 16.w),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CardProfileBIMA(
                sintaID: '6714669',
                namaUser: 'Prof. Susi Sanusi, M.Pd., Ph.D',
                namaKampus:
                    'Institut Keuangan-Perbankan dan Informatika Asia Perbanas',
                nidn: 1122077201,
                imageURL:
                    'https://i.pinimg.com/280x280_RS/e4/de/1f/e4de1f7d3225ae69e9e8d7134e0df2a0.jpg',
              ),
              SizedBox(height: 20.h),
              Text(
                'Statistik Summary Author',
                style: styleSubJudul,
              ),
              SizedBox(height: 16.h),
              CardSummaryAuthor(
                sintaScore: 4746,
                sintaThreeYear: 1,
                affilScore: 4756,
                affilThreeYear: 1,
              ),
              SizedBox(height: 20.h),
              TableDataBima(),
              SizedBox(height: 20.h),
              SubTitleWithArrowLainnya(
                  subJudul: "Publikasi Scopus",
                  function: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => PublikasiScopus()));
                  }),
              // BlocBuilder<ListTawaranProgramBloc, ListTawaranProgramState>(
              //   builder: (context, state) {
              //     return RichText(
              //         text: TextSpan(children: [
              //       TextSpan(text: "Terdapat ", style: styleSubJudul.copyWith(fontSize: 14.sp)),
              //       TextSpan(
              //           text: (state is ListTawaranProgramLoaded)
              //               ? "${state.list.length}"
              //               : "0",
              //           style: styleSubJudul.copyWith(fontWeight: FontWeight.bold)),
              //       TextSpan(text: " Program yang sedang dibuka", style: styleSubJudul.copyWith(fontSize: 14.sp))
              //     ]));
              //   },
              // ),
              SizedBox(height: 16.h),
              CardScopus(
                  title:
                      'The role of pentoxifylline in preventing contrast-induced nephropathy in coronary angiography/intervention - systematic review, meta-analysis, and meta-regression of randomized controlled trials',
                  deskripsi:
                      'European Review for Medical and Pharmacological Sciences',
                  creator: 'Rahmadi A.R.',
                  quartiles: 'Q2',
                  cited: 0),
              SizedBox(height: 20.h),
              _infoAuthorWebsite(context)
            ]),
          ),
        ));
  }

  Widget _infoAuthorWebsite(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowWebsite(
              title: 'Authors',
              link:
                  'https://bima.kemdikbud.go.id', //arahin ke web apinya author
            ),
          ),
        );
      },
      child: Container(
        child: Card(
          color: blueLinear1,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
            child: Row(
              children: [
                Image.asset(
                  'assets/bima/icon_info_author.png',
                  height: 52.h,
                  width: 52.w,
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Lihat informasi Authors lebih detail",
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: white),
                    ),
                    SizedBox(height: 8.w),
                    Row(
                      children: [
                        Text(
                          "Kunjungi Website",
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.006.sp,
                              color: white),
                        ),
                        SizedBox(width: 4.w),
                        Icon(
                          Icons.navigate_next,
                          color: white,
                          size: 16.sp,
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
