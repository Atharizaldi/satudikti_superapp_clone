import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/detail_pencarian/prodi/detail_pencarian_prodi_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/card/cardProdiRev.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/loadingPddikti/loading_detail_prodi.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/prodiPage/detailProdi.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/prodiPage/dosenHomebasePage.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/prodiPage/profilProdi.dart';
import 'package:app/presentation/pages/beranda/pddikti/cubit/tab_bar/tab_bar_cubit.dart';
import 'package:app/presentation/pages/beranda/searchPage/component/searchNotFound.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailProdiPageReg extends StatefulWidget {
  final String idReg;
  final bool fromPT;
  final List<String> headersTitle = [
    "Profil",
    "Dosen Prodi",
    "Dosen Homebase",
    "Dosen Penghitung Rasio",
  ];

  DetailProdiPageReg({Key? key, required this.idReg, required this.fromPT})
      : super(key: key);

  @override
  _DetailProdiPageRegState createState() => _DetailProdiPageRegState();
}

class _DetailProdiPageRegState extends State<DetailProdiPageReg>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  ScrollController _scrollController1 = ScrollController();
  ScrollController _scrollController2 = ScrollController();
  ScrollController _scrollController3 = ScrollController();

  // ScrollController _scrollController4 = ScrollController();

  bool isLoading = true;
  bool isConnected = false;
  bool isFound = false;
  bool haveAkreditasi = false;
  bool haveRasio = false;

  String kodePT = "";
  String kodeProdi = "";

  bool profil = true;
  bool detailProd = false;
  bool dosenHomeBase = false;
  bool dosenPenghitungRasio = false;

  @override
  void initState() {
    tabController = new TabController(length: 4, vsync: this);
    tabController.addListener(() {
      tabController.animateTo(tabController.index);
      if (tabController.index == 0) {
        setState(() {
          profil = true;
          detailProd = false;
          dosenHomeBase = false;
          dosenPenghitungRasio = false;
        });
      } else if (tabController.index == 1) {
        setState(() {
          profil = false;
          detailProd = true;
          dosenHomeBase = false;
          dosenPenghitungRasio = false;
        });
      } else if (tabController.index == 2) {
        setState(() {
          profil = false;
          detailProd = false;
          dosenHomeBase = true;
          dosenPenghitungRasio = false;
        });
      } else {
        setState(() {
          profil = false;
          detailProd = false;
          dosenHomeBase = false;
          dosenPenghitungRasio = true;
        });
      }
    });
    super.initState();
  }

  var listProdi;
  var listDosen;
  var listRasio;
  var listAkreditasi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBgPage,
      appBar: CustomAppBar(title: 'Program Studi'),
      body: BlocProvider(
        create: (context) => TabBarCubit(),
        child:
            BlocConsumer<DetailPencarianProdiBloc, DetailPencarianProdiState>(
          listener: (context, state) {
            print("State prodi reg detail: $state");
            if (state is LoadedDetailProdiState) {
              final bloc = BlocProvider.of<DetailPencarianProdiBloc>(context);
              listProdi = bloc.listProdi!;
              listAkreditasi = bloc.listAkreditasi!;
              listDosen = bloc.listDosen!;
              listRasio = bloc.listRasio!;

              haveAkreditasi = bloc.haveAkreditasi;
              haveRasio = bloc.haveRasio;
            } else {
              print("ELSE listener prodi reg detail");
            }
          },
          builder: (context, state) {
            return (state is InitDetailProdiState)
                ? LoadingDetailProdiPDDikti()
                : (state is NoInternetProdiState)
                    ? NoInternet(onPressed: () {}, buttonHide: true)
                    : (state is NotFoundProdiState)
                        // ? noDataProdi()
                        ? searchNotFound('Program Studi')
                        : ListView(
                            children: [
                              CardProdiRev(
                                kodePD: kodeProdi,
                                namaPD: listProdi.data.prodi[0].nama,
                                status: listProdi.data.prodi[0].status,
                                namaPT: listProdi.data.prodi[0].pt.nama,
                                akreditasi: haveAkreditasi
                                    ? listAkreditasi.data.akreditasi[0].nilai
                                    : '',
                                jenjangDidik:
                                    listProdi.data.prodi[0].jenjangDidik,
                              ),
                              Container(
                                // height: 55.h,
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                decoration: BoxDecoration(color: whiteBgPage),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        int indexAfter =
                                            BlocProvider.of<TabBarCubit>(
                                                    context)
                                                .moveLeftTab();
                                        tabController.animateTo(indexAfter);
                                      },
                                      child: Image.asset(
                                        "assets/icons/tabbar/arrow_left.png",
                                        width: 6.w,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12.w,
                                    ),
                                    Flexible(
                                      child: TabBar(
                                        onTap: (index) {
                                          print("indexx ");
                                          BlocProvider.of<TabBarCubit>(context)
                                              .changeTabIndex(index);
                                        },
                                        controller: tabController,
                                        isScrollable: true,
                                        labelColor: blue3,
                                        labelStyle: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: screenWidth(context) *
                                                (1 / 25)),
                                        unselectedLabelColor: neutralCaption,
                                        unselectedLabelStyle: TextStyle(
                                            fontWeight: FontWeight.w200,
                                            fontSize: screenWidth(context) *
                                                (1 / 25)),
                                        indicatorColor: Colors.transparent,
                                        indicatorWeight: 0.01,
                                        labelPadding: EdgeInsets.symmetric(
                                            horizontal: 4.w),
                                        tabs: [
                                          tabBarDosen(
                                              headers: widget.headersTitle[0],
                                              checkIndex: profil),
                                          tabBarDosen(
                                              headers: widget.headersTitle[1],
                                              checkIndex: detailProd),
                                          tabBarDosen(
                                              headers: widget.headersTitle[2],
                                              checkIndex: dosenHomeBase),
                                          tabBarDosen(
                                              headers: widget.headersTitle[3],
                                              checkIndex: dosenPenghitungRasio),
                                          // Text('Biodata'),
                                          // Text('Riwayat Pendidikan'),
                                          // Text('Riwayat Mengajar'),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12.w,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        int indexAfter =
                                            BlocProvider.of<TabBarCubit>(
                                                    context)
                                                .moveRightTab(
                                                    widget.headersTitle.length);
                                        tabController.animateTo(indexAfter);
                                      },
                                      child: Image.asset(
                                        "assets/icons/tabbar/arrow_right.png",
                                        width: 6.w,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: screenHeight(context) * (1 / 2.16),
                                decoration: BoxDecoration(color: whiteBgPage),
                                child: TabBarView(
                                  controller: tabController,
                                  children: [
                                    ListView(
                                      controller: _scrollController1,
                                      children: [
                                        TabProfilProdi(
                                          sk: listProdi
                                              .data.prodi[0].skSelenggara,
                                          tglBerdiri: listProdi
                                              .data.prodi[0].tglBerdiri,
                                          tglSk: listProdi
                                              .data.prodi[0].tglSkSelenggara,
                                          jalan: listProdi.data.prodi[0].jalan,
                                          email: listProdi.data.prodi[0].email,
                                          faks:
                                              listProdi.data.prodi[0].faksimile,
                                          telepon:
                                              listProdi.data.prodi[0].telepon,
                                          website:
                                              listProdi.data.prodi[0].website,
                                          getRasioMhsDosen:
                                              haveRasio ? listRasio : '',
                                        ),
                                        SizedBox(
                                          height:
                                              screenHeight(context) * (1 / 100),
                                        )
                                      ],
                                    ),
                                    ListView(
                                      padding: EdgeInsets.zero,
                                      controller: _scrollController2,
                                      children: [
                                        TabDetailProdi(
                                          deksripsi:
                                              listProdi.data.prodi[0].deskripsi,
                                          visi: listProdi.data.prodi[0].visi,
                                          misi: listProdi.data.prodi[0].misi,
                                          kompetensi: listProdi
                                              .data.prodi[0].kompetensi,
                                        ),
                                      ],
                                    ),
                                    ListView(
                                      controller: _scrollController3,
                                      children: [
                                        TabDosenHomebase(
                                          getListDosenProdi: listDosen,
                                        ),
                                      ],
                                    ),
                                    _dataTidakDitemukan(),
                                  ],
                                ),
                              ),
                            ],
                          );
          },
        ),
      ),
    );
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

  Container tabBarDosen({required String headers, required bool checkIndex}) {
    return Container(
      height: 36.h,
      decoration: BoxDecoration(
          color: checkIndex ? Color.fromRGBO(36, 141, 218, 0.1) : whiteBgPage,
          borderRadius: BorderRadius.circular(5.r)),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 8.w,
          vertical: 0.h,
        ),
        alignment: Alignment.centerLeft,
        child: Text(
          headers.toString(),
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            color: checkIndex ? blue4 : abu6,
          ),
        ),
      ),
    );
  }
}
