import 'package:app/common/dateFormat.dart';
import 'package:app/presentation/component/SkeletonLoading.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/pages/beranda/ijazahln/component/reusableWidgets/rowResult.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/components/programTerdaftar/detailProgramTerdaftar/cardStatusTahapan.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/components/programTerdaftar/detailProgramTerdaftar/row_result_status.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/reusableWidgets/reusableWidgetsCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truncate/truncate.dart';

import '../../../../showWebsite.dart';

class DetailTawaranProgram extends StatefulWidget {
  final String program;
  final String skema;
  final String startDate;
  final String endDate;
  final String urlProgram;

  const DetailTawaranProgram({
    Key? key,
    required this.program,
    required this.skema,
    required this.startDate,
    required this.endDate,
    required this.urlProgram,
  }) : super(key: key);

  @override
  State<DetailTawaranProgram> createState() => _DetailTawaranProgramState();
}

class _DetailTawaranProgramState extends State<DetailTawaranProgram> {
  String removeHtmlTags(String htmlText) {
    RegExp htmlTags = RegExp(r'<[^>]*>');
    return htmlText.replaceAll(htmlTags, '');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteBgPage,
        appBar: CustomAppBar(title: "Program Dibuka"),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                SizedBox(
                  height: 32.h,
                ),
                detailCard(),
                SizedBox(
                      height: 30.h,
                    ),
                Row(
                  children: [
                    Image.asset('assets/icons/icon_warning.png'),
                    SizedBox(width: 14.25.w,),
                    Text('Pendaftaran akan diarahkan ke website',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                      color: blue2,
                    ),)
                  ],
                ),
                SizedBox(
                  height: 14.h,
                ),
                btnDownloadSeritifikat(widget.urlProgram),
                SizedBox(
                  height: 20.h,
                ),
                cardButuhInfoDetail(context),
                SizedBox(
                  height: 98.w,
                ),
              ],
            ),
          ),
        ));
  }

  Column skeletonStatusTahapan() {
    return Column(
      children: [
        SizedBox(
          height: 30.w,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r), color: white),
          padding: EdgeInsets.symmetric(horizontal: 26.5.w, vertical: 20.w),
          child: Row(
            children: [
              SkeletonLoading(
                width: 80.w,
                height: 16.sp,
                cornerRadius: 5.r,
              ),
              SizedBox(
                width: 65.w,
              ),
              SkeletonLoading(
                width: 100.w,
                height: 24.sp,
                cornerRadius: 5.r,
              ),
            ],
          ),
        ),
      ],
    );
  }

  /* you can use this btn if there's a change in this page but for now there's no need

   */
  Widget btnDownloadSeritifikat(String urlProgram) {
    return Material(
        color: blue4,
        borderRadius: BorderRadius.circular(5.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(5.r),
          onTap: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context) {
                  // REDIRECT  TO KOMDOS WEBSITE

                  return ShowWebsite(
                    title: "Kompetensi Dosen",
                    link: urlProgram,
                  );
                }));
          },
          child: Container(
            width: double.infinity,
            height: 48.h,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Text(
              "Daftar Sekarang",
              style: TextStyle(
                  color: white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600 ),
            ),
          ),
        ),
      );
  }

  Container detailCard() {
    return Container(
      decoration:
      BoxDecoration(borderRadius: BorderRadius.circular(10), color: white),
      padding: EdgeInsets.symmetric(horizontal: 27.w, vertical: 28.w),
      // margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.w),
      child: Column(
        children: [
          RowResult(
            keterangan: "Nama Program",
            widgetHasil: _tag(widget.program),
          ),
          SizedBox(
            height: 30.w,
          ),
          RowResult(
            keterangan: "Nama Skema",
            widgetHasil: SelectableText(
              removeHtmlTags(widget.skema),
              style: styleGraphSubHeader.copyWith(color: neutral80),
            ),
            // hasil: "Program Magang Dosen ke Perguruan Tinggi",
          ),
          SizedBox(
            height: 30.w,
          ),
          RowResult(
            keterangan: "Waktu Dibuka",
            widgetHasil: SelectableText(
                FormatDate.formatDateWithTime(widget.startDate).toString(),
                style: styleSubJudul2.copyWith(color: neutral60)),
          ),
          SizedBox(
            height: 30.w,
          ),
          RowResult(
            keterangan: "Waktu Ditutup",
            widgetHasil: SelectableText(
              FormatDate.formatDateWithTime(widget.endDate).toString(),
              style: styleSubJudul2.copyWith(color: neutral60),
            ),
          ),
          SizedBox(
            height: 30.w,
          ),
        ],
      ),
    );
  }

  // List<Widget> detailStatusWidgets({required Map<String, dynamic> status}) {
  //   List<Widget> widgets = [];

  //     status.forEach((keterangan, status) {
  //       widgets.add(detailCardStatus(status: status, keterangan: keterangan));
  //     });
  //   return widgets;
  // }

  Container detailCardStatus({required Map<String, dynamic> mapStatus}) {
    List<Widget> widgets = [];
    int cnt = 1;
    mapStatus.forEach((keterangan, status) {
      widgets.add(
        RowResultStatus(
          keterangan: keterangan,
          widgetHasil: CardStatusTahapan(status: status),
        ),
      );
      if (cnt < mapStatus.length) {
        widgets.add(SizedBox(
          height: 30.w,
        ));
      }
      cnt++;
    });

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r), color: white),
      padding: EdgeInsets.symmetric(horizontal: 26.5.w, vertical: 15.w),
      // margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...widgets,
        ],
      ),
    );
  }

  Widget _tag(String tag) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.sp),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          border: Border.all(color: green3)),
      child: SelectableText(
        truncate(tag, 60),
        enableInteractiveSelection: false,
        //maxLines: 1,
        style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w200,
            letterSpacing: 0.08.sp,
            color: green3),
      ),
    );
  }
}
