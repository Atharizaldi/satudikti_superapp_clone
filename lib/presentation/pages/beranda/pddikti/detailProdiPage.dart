import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/detail_pencarian/prodi/detail_pencarian_prodi_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/card/cardProdiRev.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/loadingPddikti/loading_detail_program_studi_pddikti.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/prodiPage/detailProdi.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/prodiPage/dosenHomebasePage.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/prodiPage/dosenRasioPage.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/prodiPage/profilProdi.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/reusableWidgets/detailCardSection.dart';
import 'package:app/presentation/pages/beranda/pddikti/cubit/tab_bar/tab_bar_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailProdiPage extends StatefulWidget {
  final String kodePT, kodeProdi;
  final bool fromPT;
  final List<String> headersTitle = [
    "Profil",
    "Dosen Prodi",
    "Dosen Homebase",
    "Dosen Penghitung Rasio",
  ];
  DetailProdiPage(
      {Key? key,
      required this.kodePT,
      required this.kodeProdi,
      required this.fromPT})
      : super(key: key);

  @override
  _DetailProdiPageState createState() => _DetailProdiPageState();
}

class _DetailProdiPageState extends State<DetailProdiPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  bool isLoading = true;
  bool isConnected = false;
  bool haveAkreditasi = false;
  bool haveRasio = false;

  bool detailTabIsNull = false;

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
    return BlocProvider(
      create: (context) => TabBarCubit(),
      child: Scaffold(
        appBar: CustomAppBar(title: 'Program Studi'),
        body: BlocConsumer<DetailPencarianProdiBloc, DetailPencarianProdiState>(
          listener: (context, state) {
            print("IF listener prodi detail w/ state: $state");
            if (state is LoadedDetailProdiState) {
              final bloc = BlocProvider.of<DetailPencarianProdiBloc>(context);
              listProdi = bloc.listProdi!;
              listAkreditasi = bloc.listAkreditasi!;
              listDosen = bloc.listDosen!;
              listRasio = bloc.listRasio!;

              detailTabIsNull = bloc.detailTabIsNull;

              haveAkreditasi = bloc.haveAkreditasi;
              haveRasio = bloc.haveRasio;
            } else {
              print("ELSE listener prodi detail");
            }
          },
          builder: (context, state) {
            if (state is InitDetailProdiState) {
              return LoadingDetailProgramStudiPDDikti();
            } else if (state is LoadedDetailProdiState) {
              return ListView(
                children: [
                  DetailCardSection(
                    height: 340.h,
                    card: CardProdiRev(
                      kodePD: widget.kodeProdi,
                      namaPD: listProdi.data.prodi.nama,
                      status: listProdi.data.prodi.status,
                      namaPT: listProdi.data.prodi.pt.nama,
                      akreditasi: haveAkreditasi
                          ? listAkreditasi.data.akreditasi[0].nilai
                          : '',
                      jenjangDidik: listProdi.data.prodi.jenjangDidik,
                    ),
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
                                BlocProvider.of<TabBarCubit>(context)
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
                                fontSize: screenWidth(context) * (1 / 25)),
                            unselectedLabelColor: neutralCaption,
                            unselectedLabelStyle: TextStyle(
                                fontWeight: FontWeight.w200,
                                fontSize: screenWidth(context) * (1 / 25)),
                            indicatorColor: Colors.transparent,
                            indicatorWeight: 0.01,
                            labelPadding: EdgeInsets.symmetric(horizontal: 4.w),
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
                                BlocProvider.of<TabBarCubit>(context)
                                    .moveRightTab(widget.headersTitle.length);
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
                          children: [
                            TabProfilProdi(
                              sk: listProdi.data.prodi.skSelenggara,
                              tglBerdiri: listProdi.data.prodi.tglBerdiri,
                              tglSk: listProdi.data.prodi.tglSkSelenggara,
                              jalan: listProdi.data.prodi.jalan,
                              email: listProdi.data.prodi.email,
                              faks: listProdi.data.prodi.faksimile,
                              telepon: listProdi.data.prodi.telepon,
                              website: listProdi.data.prodi.website,
                              getRasioMhsDosen: haveRasio ? listRasio : '',
                            ),
                            SizedBox(
                              height: screenHeight(context) * (1 / 100),
                            )
                          ],
                        ),
                        detailTabIsNull
                            ? _dataTidakDitemukan()
                            : ListView(
                                children: [
                                  TabDetailProdi(
                                    deksripsi: listProdi.data.prodi.deskripsi,
                                    visi: listProdi.data.prodi.visi,
                                    misi: listProdi.data.prodi.misi,
                                    kompetensi: listProdi.data.prodi.kompetensi,
                                  ),
                                ],
                              ),
                        ListView(
                          children: [
                            TabDosenHomebase(
                              getListDosenProdi: listDosen,
                            ),
                          ],
                        ),
                        ListView(
                          children: [
                            TabDosenRasioPage(
                              getRasioMhsDosen: listRasio,
                            ),
                          ],
                        ),
                        // _dataTidakDitemukan()
                        // Text("DATA ${listRasio.data.rasio[0].tahun}")
                      ],
                    ),
                  ),
                ],
              );
            } else if (state is NoInternetProdiState) {
              return NoInternet(onPressed: () {}, buttonHide: true);
            } else {
              return SizedBox();
            }
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
