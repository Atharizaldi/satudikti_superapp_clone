import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/component/server_problem.dart';
import 'package:app/presentation/pages/beranda/beasiswa/components/cardBeasiswa.dart';
import 'package:app/presentation/pages/beranda/ijazahln/component/reusableWidgets/rowResult.dart';
import 'package:app/presentation/pages/beranda/siaga/pengajuanUsulan/bloc/pengajuan_usulan_bloc.dart';
import 'package:app/presentation/pages/beranda/siaga/pengajuanUsulan/bloc/pengajuan_usulan_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeline_tile/timeline_tile.dart';

class StatusPengajuanUsulanPage extends StatefulWidget {
  final String kataKunci;

  const StatusPengajuanUsulanPage({
    Key? key,
    required this.kataKunci,
  }) : super(key: key);

  @override
  _StatusPengajuanUsulanPageState createState() =>
      _StatusPengajuanUsulanPageState();
}

class _StatusPengajuanUsulanPageState extends State<StatusPengajuanUsulanPage>
    with TickerProviderStateMixin {
  var listSiaga;
  late AnimationController _animationController;
  late Animation<double> _opacity;
  late Animation<double> _opacityDetail;
  late Animation<Offset> _positionedTidakDItemukan;
  late Animation<Offset> _positionedLogoTidakDItemukan;

  bool flag = false;
  bool flag2 = false;

  var listSivil;
  bool isSucceeded = false;
  bool isConnected = false;
  bool isloading = true;

  Logger logger = Logger();
  SharedPreferences? prefs;

  void setSharedPrefernces() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    setSharedPrefernces();

    setState(() {
      _animationController = AnimationController(
          vsync: this, duration: Duration(milliseconds: 20));
      _opacity = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
          parent: _animationController, curve: Interval(0, 0.3)));
      _opacityDetail = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
          parent: _animationController, curve: Interval(0.9, 1)));
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
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Status Pengajuan Usulan'),
      body: BlocConsumer<PengajuanUsulanBloc, PengajuanUsulanState>(
        listener: (context, state) {
          print("STATE pengajuan siaga $state");
          if (state is LoadedPengajuanUsulanState) {
            listSiaga = BlocProvider.of<PengajuanUsulanBloc>(context).listSiaga;
            prefs!.remove("StatusPU");
            prefs!.setStringList("StatusPU", [
              listSiaga.data.detailStatusPengajuan[0].namaPt,
              listSiaga.data.detailStatusPengajuan[0].namaPengajuan,
              listSiaga.data.detailStatusPengajuan[0].namaProdi,
              listSiaga.data.detailStatusPengajuan[0].ticket,
            ]);
          } else {
            print("ELSE pengajuan siaga listener");
          }
        },
        builder: (context, state) {
          print("STATE BUILDER : $state");
          if (state is InitPengajuanUsulanState) {
            return Center(child: CircularProgressIndicator(color: neutral100));
          } else if (state is NoInternetPengajuanUsulanState) {
            return NoInternet(onPressed: () {}, buttonHide: true);
          } else if (state is NotFoundPengajuanUsulanState) {
            return tidakDitemukan(context);
          } else if (state is LoadedPengajuanUsulanState) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30.h),
                    SelectableText(
                      'Detail Status Pengajuan',
                      style: TextStyle(
                        color: blue3,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 25.w, vertical: 30.h),
                      decoration: BoxDecoration(
                        boxShadow: shadow1,
                        borderRadius: BorderRadius.circular(10.r),
                        color: white,
                      ),
                      child: Column(
                        children: [
                          RowResult(
                            keterangan: "Nomor Registrasi",
                            hasil:
                                listSiaga.data.detailStatusPengajuan[0].ticket,
                          ),
                          SizedBox(height: 30.h),
                          RowResult(
                            keterangan: "Perguruan Tinggi",
                            hasil:
                                listSiaga.data.detailStatusPengajuan[0].namaPt,
                          ),
                          SizedBox(height: 30.h),
                          RowResult(
                            keterangan: "Program Studi",
                            hasil: listSiaga
                                .data.detailStatusPengajuan[0].namaProdi,
                          ),
                          SizedBox(height: 30.h),
                          RowResult(
                            keterangan: "Program",
                            hasil: listSiaga
                                .data.detailStatusPengajuan[0].namaProgram,
                          ),
                          SizedBox(height: 30.h),
                          RowResult(
                            keterangan: "Jenis Usul",
                            hasil: listSiaga
                                .data.detailStatusPengajuan[0].namaPengajuan,
                          ),
                          SizedBox(height: 30.h),
                          RowResult(
                            keterangan: "Status",
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              margin: EdgeInsets.only(top: 30.h),
                              height: 48.h,
                              width: 308.w,
                              decoration: BoxDecoration(
                                  color: green3,
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: Center(
                                child: SelectableText(
                                  listSiaga
                                      .data.progressPengajuanUsulan[0].judul,
                                  style: TextStyle(
                                      color: white,
                                      fontSize: 14.sp,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 48.h),
                    Text(
                      'Progress Pengajuan Usulan',
                      style: TextStyle(
                        color: blue3,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 19.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 20.h),
                      decoration: BoxDecoration(
                        color: white,
                        boxShadow: shadow1,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 30.h),
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                                  listSiaga.data.progressPengajuanUsulan.length,
                              itemBuilder: (context, index) {
                                var reverseIndex = listSiaga
                                        .data.progressPengajuanUsulan.length -
                                    index;

                                var idx = index;
                                var akhir = listSiaga
                                        .data.progressPengajuanUsulan.length -
                                    1;
                                return tlTile(
                                  listSiaga.data.progressPengajuanUsulan[index]
                                      .judul,
                                  listSiaga.data.progressPengajuanUsulan[index]
                                      .deskripsi,
                                  (index).toString(),
                                  listSiaga.data.progressPengajuanUsulan[index]
                                      .tipeTiket,
                                  listSiaga.data.progressPengajuanUsulan[index]
                                      .status,
                                  listSiaga
                                      .data.progressPengajuanUsulan[index].unit,
                                  listSiaga.data.progressPengajuanUsulan[index]
                                      .dateLog,
                                  reverseIndex ==
                                          listSiaga.data.progressPengajuanUsulan
                                              .length
                                      ? blueLinear1
                                      : abu2,
                                  reverseIndex ==
                                          listSiaga.data.progressPengajuanUsulan
                                              .length
                                      ? blueLinear1
                                      : abu2,
                                  index == akhir ? true : false,
                                  index == 0 ? true : false,
                                  reverseIndex,
                                );
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return ServerProblem(onPressed: () {}, buttonHide: true);
          }
        },
      ),
    );
  }

  GestureDetector tidakDitemukan(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          FadeTransition(
            opacity: _opacity,
            // color: Colors.amber,
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
                  padding: EdgeInsets.symmetric(horizontal: 39.w),
                  child: Column(
                    children: [
                      SizedBox(height: 18.h),
                      Text(
                        'Silahkan tuliskan data anda dengan benar pada halaman sebelumnya',
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 39.h + screenHeight(context) * (1 / 50),
                      ),
                    ],
                  )),
            ),
          ),
          SizedBox(
            height: 100.h,
          ),
        ],
      ),
    );
  }

  TimelineTile tlTile(String judul, deskripsi, step, tipeTiket, status, unit,
      dateLog, warnaIndikator, warnaGaris, bool akhir, bool awal, int index) {
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.3,
      startChild: Padding(
        padding: EdgeInsets.only(left: 4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              formatDate.formatDate(dateLog),
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'Jam ${dateLog.split(' ').last.split(':')[0]}.${dateLog.split(''
                  ' ').last.split(':')[1]}',
              style: TextStyle(
                fontSize: 9.sp,
                fontWeight: FontWeight.w400,
                color: neutral50,
              ),
            )
          ],
        ),
      ),
      endChild: Container(
        padding: EdgeInsets.only(left: 8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Text(
                judul,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: neutral80,
                ),
              ),
            ),
            SizedBox(height: 2.h),
            Row(children: [
              Text(
                'Oleh ',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: neutral50,
                ),
              ),
              Text(
                unit,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: neutral50,
                ),
              ),
            ]),
            SizedBox(height: 2.h),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                text: deskripsi,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: neutral50,
                ),
              ),
              TextSpan(text: " "),
              TextSpan(
                text: '${dateLog.split(' ').last.split(':')[0]}'
                    ':'
                    '${dateLog.split(' ').last.split(':')[1]}'
                    ':'
                    '${dateLog.split(' ').last.split(':')[2]}',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: neutral50,
                ),
              ),
            ])),
            SizedBox(height: 28.h)
          ],
        ),
      ),
      isLast: akhir,
      isFirst: awal,
      indicatorStyle: IndicatorStyle(
        indicator: Container(
          width: 32.w,
          height: 31.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: warnaIndikator,
          ),
          child: Text(
            index.toString(),
            style: TextStyle(fontSize: 16.sp, color: white),
          ),
        ),
        indicatorXY: 0,
        width: 32.w,
        height: 31.w,
      ),
      afterLineStyle: LineStyle(color: awal ? warnaGaris : abu2),
    );
  }
}
