import 'dart:io' show Platform;

import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customSliverBar.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/component/server_problem.dart';
import 'package:app/presentation/pages/beranda/kampusMerdeka/bloc/kampus_merdeka/kampusmerdeka_bloc.dart';
import 'package:app/presentation/pages/beranda/kampusMerdeka/component/km_loading.dart';
import 'package:app/presentation/pages/beranda/kampusMerdeka/component/no_program_km.dart';
import 'package:app/presentation/pages/beranda/kampusMerdeka/component/program_amount.dart';
import 'package:app/presentation/pages/beranda/kampusMerdeka/component/program_widget.dart';
import 'package:app/presentation/pages/beranda/kampusMerdeka/header_km.dart';
import 'package:app/presentation/pages/beranda/kampusMerdeka/statistik_page.dart';
import 'package:app/presentation/pages/faq/bloc/faq_module/faqmodule_bloc.dart';
import 'package:app/presentation/pages/faq/faq_page_per_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'bloc/cerita_kampus_merdeka/cerita_kampus_merdeka_bloc.dart';
import 'cerita_kampus_merdeka.dart';
import 'component/sub_tittle_lainnya_ckm.dart';
import 'detail_cerita_ckm/daftar_cerita.dart';

class KampusMerdekaPage extends StatefulWidget {
  const KampusMerdekaPage({Key? key}) : super(key: key);

  @override
  _KampusMerdekaPageState createState() => _KampusMerdekaPageState();
}

class _KampusMerdekaPageState extends State<KampusMerdekaPage>
    with SingleTickerProviderStateMixin {
  bool isInFirstIndex = true;

  int statistikPT = 1441;
  int statistikDosen = 8004;
  int statistikMahasiswa = 61592;

  static List<Tab> _tabKM = <Tab>[
    Tab(
      child: Container(
        width: 358.w,
        height: 58.sp,
        alignment: Alignment.center,
        child: Text(
          'Sedang dibuka',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
    Tab(
      child: Container(
        width: 358.w,
        height: 58.sp,
        alignment: Alignment.center,
        child: Text(
          'Akan dibuka',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _tabKM.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: sliverBgGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: RefreshIndicator(
          onRefresh: () async {
            BlocProvider.of<KampusmerdekaBloc>(context)..add(GetKMListEvent());
            BlocProvider.of<CeritaKampusMerdekaBloc>(context)
              ..add(GetCeritaKMPopularEvent());
          },
          child: CustomSliverBar(
            expandedHeight: (Platform.isAndroid) ? 260.w : 240.w,
            appBarTitle: 'Kampus Merdeka',
            header: FlexibleSpaceBar(
              background: headerKM(context),
            ),
            child: BlocConsumer<KampusmerdekaBloc, KampusmerdekaState>(
              listener: (context, state) {
                if (state is KampusmerdekaNoInternetState) {
                  ScaffoldMessenger.of(context).showSnackBar(noInternet);
                }
              },
              builder: (context, state) {
                return Container(
                  padding: EdgeInsets.only(bottom: 4.h),
                  color: whiteBgPage,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      SizedBox(height: 20.h),
                      _tabBar(),
                      Container(
                        height: _heightTab(state),
                        child: TabBarView(
                          physics: NeverScrollableScrollPhysics(),
                          controller: _tabController,
                          children: [
                            _sedangDibuka(state),
                            _akanDibuka(state),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: SubTittleCKM(
                          subJudul: 'Cerita Kampus Merdeka',
                          function: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                    create: (context) => di
                                        .locator<CeritaKampusMerdekaBloc>()
                                      ..add(GetCeritaKMRecentlyEvent())
                                      ..add(GetCeritaKMMSIBEvent())
                                      ..add(
                                          GetCeritaKMPertukaranMahasiswaEvent())
                                      ..add(GetCeritaKMKampusMengajarEvent())
                                      ..add(GetCeritaKMIISMAEvent())
                                      ..add(GetCeritaKMWirausahaEvent())
                                      ..add(GetCeritaKMPraktisiMengajarEvent())
                                      ..add(
                                          GetCeritaKMFestivalKampusMerdekaEvent()),
                                    child: DaftarCeritaPage()),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      BlocProvider(
                        create: (context) =>
                            di.locator<CeritaKampusMerdekaBloc>()
                              ..add(GetCeritaKMPopularEvent()),
                        child: CeritaKampusMerdekaSection(),
                      ),
                      _statistika(),
                      _bannerFAQ(context),
                      SizedBox(
                        height: 20.h,
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _bannerFAQ(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return BlocProvider(
                create: (context) => di.locator<FaqmoduleBloc>()
                  ..add(FetchfaqModuleEvent('mbkm')),
                child: FAQModul(),
              );
            },
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15.w, horizontal: 15.h),
        width: 358.w,
        child: Card(
          color: blueLinear1,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/faq/faq_icon.png'),
                  ),
                ),
                SizedBox(width: 20.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Butuh Informasi lainnya?",
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.006.sp,
                          color: white),
                    ),
                    SizedBox(
                      height: 10.w,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Lihat FAQ",
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.006.sp,
                              color: white),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Icon(
                          Icons.navigate_next,
                          color: white,
                          size: 16,
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

  Widget _tabBar() {
    return DefaultTabController(
      length: _tabKM.length,
      initialIndex: 0,
      child: Column(
        children: [
          Container(
            width: 358.w,
            height: 58.sp,
            padding: EdgeInsets.symmetric(
              horizontal: 4.w,
              vertical: 4.w,
            ),
            decoration: BoxDecoration(
              color: neutral10,
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: TabBar(
              controller: _tabController,
              unselectedLabelColor: neutral40,
              indicator: BoxDecoration(
                color: blue4,
                borderRadius: BorderRadius.circular(4.r),
              ),
              tabs: _tabKM,
            ),
          ),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }

  Widget _sedangDibuka(KampusmerdekaState state) {
    if (state is KampusmerdekaLoadingState) {
      return kmListLoading();
    } else if (state is KampusmerdekaLoadedState) {
      if (state.running.isEmpty) {
        return noProgramKm(true);
      }
      return Column(
        children: [
          programAmount(state.running.length.toString(), true),
          SizedBox(height: 20.h),
          ProgramWidget(listProgram: state.running),
        ],
      );
    } else if (state is KampusmerdekaNoInternetState) {
      return NoInternet(
        bgColor: whiteBgPage,
        onPressed: () {},
        buttonHide: true,
      );
    } else {
      return ServerProblem(
        bgColor: whiteBgPage,
        onPressed: () {},
        buttonHide: true,
      );
    }
  }

  Widget _akanDibuka(KampusmerdekaState state) {
    if (state is KampusmerdekaLoadingState) {
      return kmListLoading();
    } else if (state is KampusmerdekaLoadedState) {
      if (state.willBeRunning.isEmpty) {
        return noProgramKm(false);
      }
      return Column(
        children: [
          programAmount(state.willBeRunning.length.toString(), false),
          SizedBox(height: 20.h),
          ProgramWidget(listProgram: state.willBeRunning),
        ],
      );
    } else if (state is KampusmerdekaNoInternetState) {
      return NoInternet(
        bgColor: whiteBgPage,
        onPressed: () {},
        buttonHide: true,
      );
    } else {
      return ServerProblem(
        bgColor: whiteBgPage,
        onPressed: () {},
        buttonHide: true,
      );
    }
  }

  double _heightTab(KampusmerdekaState state) {
    if (state is KampusmerdekaLoadedState) {
      _tabController.addListener(() {
        if (_tabController.index == 0 || _tabController.index == 1) {
          setState(() {
            isInFirstIndex = !isInFirstIndex;
          });
        }
      });
      if (isInFirstIndex) {
        if (state.running.isEmpty) {
          return 360.h;
        }
        return state.running.length * 220.h;
      } else {
        if (state.willBeRunning.isEmpty) {
          return 360.h;
        }
        return state.willBeRunning.length * 180.h;
      }
    } else {
      return 600.h;
    }
  }

  Widget _statistika() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Text(
              "Data Statistik Kampus Merdeka",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: blue3,
              ),
            )),
        GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StatistikPage(data: 'mahasiswa')));
            },
            child: Container(
              width: double.infinity,
              height: 137.w,
              color: Color(0xffC7E7FF),
              child: Stack(
                children: [
                  Positioned(
                    top: 12.h,
                    bottom: 12.56.h,
                    left: 16.w,
                    child: Image.asset(
                      "assets/pddikti/homepage/ilustrasi_mahasiswa.png",
                      width: 124.w,
                      height: 121.w,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 267.w,
                    top: 42.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          statistikMahasiswa.toString() == ""
                              ? "-"
                              : NumberFormat.currency(
                                      locale: 'id', decimalDigits: 0, name: '')
                                  .format(statistikMahasiswa.toInt()),
                          style: TextStyle(
                              color: Color(0xff118EEA),
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Text(
                          "Mahasiswa",
                          style: TextStyle(
                              color: neutral60,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
        SizedBox(
          height: 8.h,
        ),
        GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StatistikPage(data: 'dosen')));
            },
            child: Container(
              width: double.infinity,
              height: 137.w,
              color: Color(0xffDCFFC7),
              child: Stack(
                children: [
                  Positioned(
                    top: 12.h,
                    bottom: 12.h,
                    right: 16.w,
                    child: Image.asset(
                      "assets/pddikti/homepage/ilustrasi_dosen.png",
                      width: 164.w,
                      height: 120.w,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 32.w,
                    top: 42.5.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          statistikDosen.toString() == ""
                              ? "-"
                              : NumberFormat.currency(
                                      locale: 'id', decimalDigits: 0, name: '')
                                  .format(statistikDosen.toInt()),
                          style: TextStyle(
                              color: Color(0xff11EA21), fontSize: 24.sp),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Text(
                          "Dosen",
                          style: TextStyle(
                              color: neutral60,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
        SizedBox(
          height: 8.h,
        ),
        GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StatistikPage(data: 'pt')));
            },
            child: Container(
              width: double.infinity,
              height: 137.w,
              color: Color(0xffFFD6CF),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 12.h,
                    top: 12.h,
                    left: 16.w,
                    child: Image.asset(
                      "assets/pddikti/homepage/ilustrasi_pt.png",
                      width: 171.w,
                      height: 116.w,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 32.w,
                    top: 40.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          statistikPT.toString() == ""
                              ? "-"
                              : NumberFormat.currency(
                                      locale: 'id', decimalDigits: 0, name: '')
                                  .format(statistikPT.toInt()),
                          style: TextStyle(
                              color: Color(0xffF66951), fontSize: 24.sp),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Text(
                          "Perguruan Tinggi",
                          style: TextStyle(
                              color: neutral60,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
