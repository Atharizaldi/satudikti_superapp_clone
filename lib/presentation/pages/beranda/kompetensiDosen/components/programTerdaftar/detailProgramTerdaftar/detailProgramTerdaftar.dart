import 'package:app/common/dateFormat.dart';
import 'package:app/common/utils.dart';
import 'package:app/presentation/component/SkeletonLoading.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/pages/beranda/ijazahln/component/reusableWidgets/rowResult.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/bloc/penilaian_dosen/penilaian_dosen_bloc.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/components/programTerdaftar/detailProgramTerdaftar/cardStatusTahapan.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/components/programTerdaftar/detailProgramTerdaftar/row_result_status.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/reusableWidgets/reusableWidgetsCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truncate/truncate.dart';

class DetailProgramTerdaftar extends StatefulWidget {
  final String namaPeriode;
  final String program;
  final String skema;
  final String startDate;
  final String endDate;
  final String registeredDate;
  final String urlRiwayatPenilaian;
  final String urlSertifikat;

  const DetailProgramTerdaftar({
    Key? key,
    required this.namaPeriode,
    required this.program,
    required this.skema,
    required this.startDate,
    required this.endDate,
    required this.registeredDate,
    required this.urlRiwayatPenilaian,
    required this.urlSertifikat,
  }) : super(key: key);

  @override
  State<DetailProgramTerdaftar> createState() => _DetailProgramTerdaftarState();
}

class _DetailProgramTerdaftarState extends State<DetailProgramTerdaftar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteBgPage,
        appBar: CustomAppBar(title: "Detail Program Terdaftar"),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                SizedBox(
                  height: 30.w,
                ),
                detailCard(),
                BlocBuilder<PenilaianDosenBloc, PenilaianDosenState>(
                  builder: (context, state) {
                    if (state is PenilaianDosenLoaded) {
                      Map<String, dynamic> mapStatus =
                          state.penilaianDosen.data as Map<String, dynamic>;
                      return Column(
                        children: [
                          SizedBox(
                            height: 30.w,
                          ),
                          detailCardStatus(mapStatus: mapStatus),
                        ],
                      );
                    } else if (state is PenilaianDosenError) {
                      return SizedBox();
                    } else {
                      return skeletonStatusTahapan();
                    }
                  },
                ),
                SizedBox(
                  height: 30.w,
                ),
                ...btnDownloadSeritifikat(widget.urlSertifikat),
                SizedBox(
                  height: 30.w,
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

  List<Widget> btnDownloadSeritifikat(String urlSertifikat) {
    return [
      Material(
        color: (urlSertifikat != "") ? blue4 : neutral30,
        borderRadius: BorderRadius.circular(10.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(10.r),
          onTap: (urlSertifikat != "")
              ? () {
                  print("WIDGET urlsertif ${widget.urlSertifikat}");
                  var idSertifikat = matchAfterLastSlash
                      .firstMatch(widget.urlSertifikat)
                      ?.group(0);
                  idSertifikat =
                      idSertifikat?.substring(1, idSertifikat.length);
                  context.read<PenilaianDosenBloc>()
                    ..add(GetSertifikatEvent(id: idSertifikat ?? ""));
                  // launchURL(
                  //     "https://kompetensi.sumberdaya.kemdikbud.go.id/web/downloadfile/34");
                }
              : null,
          child: Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 15.sp),
            child: Text(
              "Download Sertifikat",
              style: styleGraphSubHeader.copyWith(color: white),
            ),
          ),
        ),
      ),
    ];
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
              widget.skema,
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
          RowResult(
            keterangan: "Waktu Terdaftar",
            widgetHasil: SelectableText(
                FormatDate.formatDateStatic(widget.registeredDate),
                style: styleSubJudul2.copyWith(color: neutral60)),
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
