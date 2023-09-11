import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/pages/beranda/ijazahln/bloc/ijazahln/ijazahbyno/ijazahbyno_bloc.dart';
import 'package:app/presentation/pages/beranda/ijazahln/component/reusableWidgets/customCircularProgress.dart';
import 'package:app/presentation/pages/beranda/ijazahln/component/reusableWidgets/rowResult.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeline_tile/timeline_tile.dart';

class DetailHasilStatusPage extends StatefulWidget {
  final String noRegis;

  const DetailHasilStatusPage({Key? key, required this.noRegis})
      : super(key: key);

  @override
  _DetailHasilStatusPageState createState() => _DetailHasilStatusPageState();
}

class _DetailHasilStatusPageState extends State<DetailHasilStatusPage>
    with TickerProviderStateMixin {
  var listByReg;
  bool isLoading = true;
  bool nomorValid = false;
  late AnimationController _animationController;
  late Animation<double> _opacity;
  late Animation<Offset> _positionedLogoTidakDItemukan;
  late Animation<double> _opacityDetail;
  late Animation<Offset> _positionedTidakDItemukan;

  SharedPreferences? prefs;

  void setSharedPrefernces() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    setSharedPrefernces();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _opacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _animationController, curve: Interval(0, 0.3)));
    _opacityDetail = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _animationController, curve: Interval(0.9, 1)));
    _positionedLogoTidakDItemukan =
        Tween<Offset>(begin: Offset(0, 1.5), end: Offset(0, 0.8)).animate(
            CurvedAnimation(
                parent: _animationController,
                curve: Interval(0.3, 1, curve: Curves.decelerate)));
    _positionedTidakDItemukan =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(0, 1.6)).animate(
            CurvedAnimation(
                parent: _animationController,
                curve: Interval(0.3, 1, curve: Curves.decelerate)));
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          di.locator<IjazahbynoBloc>()..add(FetchIjazahByNo(widget.noRegis)),
      child: Scaffold(
          appBar: CustomAppBar(
            title: 'Status Pengajuan Penyetaraan',
            textStyle: TextStyle(
                fontSize: 16,
                color: white,
                fontWeight: FontWeight.w600,
                letterSpacing: 1),
          ),
          body: BlocBuilder<IjazahbynoBloc, IjazahbynoState>(
            builder: (context, state) {
              print(state);
              if (state is IjazahbynoLoading) {
                return Center(child: CustomCircularProgress());
              }
              if (state is IjazahbynoLoaded) {
                return detailHasil(state.listByReg);
              }
              if (state is IjazahbynoFailed) {
                return tidakDitemukan(context);
              }
              return Text("DATA");
            },
          )),
    );
  }

  Column tidakDitemukan(BuildContext context) {
    return Column(
      children: [
        FadeTransition(
          opacity: _opacity,
          child: SlideTransition(
            position: _positionedLogoTidakDItemukan,
            child: Container(
              width: 224.w,
              child: Image.asset(
                'assets/ijazahln/not_success.png',
                // scale: 2,
              ),
            ),
          ),
        ),
        FadeTransition(
          opacity: _opacityDetail,
          child: SlideTransition(
            position: _positionedTidakDItemukan,
            child: Container(
                child: Column(
              children: [
                Text(
                  'Silahkan tuliskan data anda dengan benar pada halaman sebelumnya',
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 60.w,
                ),
              ],
            )),
          ),
        ),
        SizedBox(
          height: 100.w,
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            margin: EdgeInsets.only(top: 16.88.w),
            height: 39.w,
            width: 117.w,
            decoration: BoxDecoration(
                color: blueLinear1, borderRadius: BorderRadius.circular(15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Kembali',
                  style: TextStyle(
                      color: white,
                      fontSize: 12.sp,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget detailHasil(res) {
    var textStyleKeterangan =
        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: blue4);
    // var textStyleIsian = textStyleKeterangan.copyWith(color: neutral60);
    prefs!.remove("statusSK");
    prefs!.setStringList("statusSK", [
      res.data.progress.nama,
      res.data.progress.programStudi,
      res.data.progress.noRegistrasi,
    ]);
    return Container(
      color: whiteBgPage,
      child: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(
            height: 26.w,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.5.w),
            child: SelectableText(
              'Detail Status Pengajuan',
              style: TextStyle(
                  fontSize: 20.w, fontWeight: FontWeight.w700, color: blue3),
            ),
          ),
          SizedBox(
            height: 17.w,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 30.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: white,
            ),
            child: Column(
              children: [
                RowResult(
                  keterangan: "Nama",
                  hasil: res.data.progress.nama,
                ),
                SizedBox(height: 30.h),
                RowResult(
                  keterangan: "Nomor registrasi",
                  hasil: res.data.progress.noRegistrasi,
                ),
                SizedBox(height: 30.h),
                RowResult(
                  keterangan: "Perguruan tinggi",
                  hasil: res.data.progress.perguruanTinggi,
                ),
                SizedBox(height: 30.h),
                RowResult(
                  keterangan: "Program studi",
                  hasil: res.data.progress.programStudi,
                ),
                SizedBox(height: 30.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 130.w,
                    child: SelectableText(
                      'Status pengajuan',
                      style: textStyleKeterangan,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.w,
                ),
                Container(
                  // alignment: Alignment.centerLeft,
                  // constraints: BoxConstraints(maxWidth: 200.w),
                  width: 308.w,
                  height: 48.h,
                  padding:
                      EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.5.h),
                  decoration: BoxDecoration(
                      color: statusColor(res),
                      borderRadius: BorderRadius.circular(10.r)),
                  alignment: Alignment.center,
                  child: Text(
                    res.data.progress.statusSaatIni,
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: white),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 42.h),

          // timeline
          Padding(
            padding: EdgeInsets.only(left: 14.w),
            child: Text(
              'Progress Penyetaraan',
              style: TextStyle(
                  fontSize: 20.w, fontWeight: FontWeight.w700, color: blue3),
            ),
          ),
          SizedBox(height: 17.h),
          Container(
            // width: double.infinity,
            color: white,
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: res.data.progress.progresPenyetaraan.length,
                itemBuilder: (context, index) {
                  var idx = res.data.progress.progresPenyetaraan.length - index;
                  var awal = res.data.progress.progresPenyetaraan.length - 1;
                  return
                      // buildTimeline();
                      tlTile(
                          res.data.progress.progresPenyetaraan[idx - 1].tanggal,
                          (idx).toString(),
                          res.data.progress.progresPenyetaraan[idx - 1].status,
                          res.data.progress.progresPenyetaraan[idx - 1]
                              .aktifitas,
                          idx == res.data.progress.progresPenyetaraan.length
                              ? blueLinear1
                              : abu2,
                          idx == res.data.progress.progresPenyetaraan.length
                              ? blueLinear1
                              : abu2,
                          idx == 1 ? true : false,
                          idx - 1 == awal ? true : false,
                          idx);
                }),
          ),
          SizedBox(
            height: 96.w,
          ),
        ],
      ),
    );
  }

  TimelineTile tlTile(String tanggal, step, namaProgres, detailProgres,
      warnaIndikator, warnaGaris, bool akhir, bool awal, int index) {
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.3,
      startChild: Column(
        children: [
          SizedBox(height: 10.h),
          Text(
            convertDate(tanggal),
            textAlign: TextAlign.end,
            style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 20.h)
        ],
      ),
      endChild: Container(
        width: 210.w + 90.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 160.w,
                  padding: EdgeInsets.only(left: 8.w),
                  child: Text(
                    namaProgres,
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: awal ? warnaIndikator : neutralCaption),
                  ),
                ),
                // tanggal
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Html(
              data: detailProgres,
              style: {
                "body": Style(
                    fontSize: FontSize(12.sp),
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.start,
                    color: awal ? neutral70 : unselectedTextColor,
                    lineHeight: LineHeight.em(1)),
              },
            ),
            SizedBox(
              height: 16.h,
            ),
          ],
        ),
      ),
      isLast: akhir,
      isFirst: awal,
      indicatorStyle: IndicatorStyle(
        indicator: Container(
          width: 32.r,
          height: 32.r,
          alignment: Alignment.center,
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: warnaIndikator),
          child: Text(
            index.toString(),
            style: TextStyle(fontSize: 16.sp, color: white),
          ),
        ),
        indicatorXY: 0,
        width: 32.r,
        height: 32.r,
        // color: warnaIndikator
      ),
      afterLineStyle: LineStyle(color: awal ? warnaGaris : abu2),
    );
  }

  Color statusColor(res) {
    if (res.data.progress.statusSaatIni == 'Ditolak') {
      return Colors.red;
    } else if (res.data.progress.statusSaatIni ==
            'Ditanda tangani dan siap diambil' ||
        res.data.progress.statusSaatIni == 'Ditandatangani (e-sign)') {
      return green3;
    } else {
      return Color(0xffFBD106);
    }
  }

  String convertDate(String date) {
    var inputFormat = DateFormat('yyyy-MM-dd');
    var inputDate = inputFormat.parse(date);

    var outputFormat = DateFormat("d MMMM yyyy", "id_ID");
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }
}
