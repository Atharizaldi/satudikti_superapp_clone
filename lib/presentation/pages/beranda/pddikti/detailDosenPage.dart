import 'package:app/data/source/remote/model/pddikti/dosen/getRiwayatMengajar.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/detail_pencarian/dosen/detail_pencarian_dosen_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/card/cardMahasiswaDosenRev.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/dosenPage/biodataDosen.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/dosenPage/riwayatMengajarDosen.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/dosenPage/riwayatPendidikanDosen.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/loadingPddikti/loading_detail_dosen_pddikti.dart';
import 'package:app/presentation/pages/beranda/pddikti/cubit/tab_bar/tab_bar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailDosenPage extends StatefulWidget {
  final String nama, nomorInduk, namaProdi, namaPT;
  final String? kodePD;
  final List<String> headersTitle = [
    "Biodata",
    "Riwayat Pendidikan",
    "Riwayat Mengajar",
  ];
  DetailDosenPage(
      {Key? key,
      required this.nama,
      required this.nomorInduk,
      this.kodePD,
      required this.namaProdi,
      required this.namaPT})
      : super(key: key);

  @override
  _DetailDosenPageState createState() => _DetailDosenPageState();
}

class _DetailDosenPageState extends State<DetailDosenPage>
    with SingleTickerProviderStateMixin {
  var detailDosen, riwayatPendidikanDosen;
  RiwayatMengajar? riwayatMengajarDosen;
  bool isLoading = true;
  bool isConnected = false;

  bool checkBiodata = true;
  bool checkRiwayatPendidikan = false;
  bool checkRiwayatMengajar = false;

  late TabController tabController;
  @override
  void initState() {
    tabController = new TabController(length: 3, vsync: this);
    tabController.addListener(() {
      print("tab ${tabController.index}");
      tabController.animateTo(tabController.index);
      if (tabController.index == 0) {
        setState(() {
          checkBiodata = true;
          checkRiwayatPendidikan = false;
          checkRiwayatMengajar = false;
        });
      } else if (tabController.index == 1) {
        setState(() {
          checkBiodata = false;
          checkRiwayatPendidikan = true;
          checkRiwayatMengajar = false;
        });
      } else {
        setState(() {
          checkBiodata = false;
          checkRiwayatPendidikan = false;
          checkRiwayatMengajar = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TabBarCubit(),
      child: BlocConsumer<DetailPencarianDosenBloc, DetailPencarianDosenState>(
        listener: (context, state) {
          print('STATE LISTENER: $state');

          if (state is LoadedDetailState) {
            final bloc = BlocProvider.of<DetailPencarianDosenBloc>(context);
            detailDosen = bloc.listDetailDosen!;
            riwayatPendidikanDosen = bloc.riwayatPendidikanDosen;
            riwayatMengajarDosen = bloc.riwayatMengajarDosen;
          } else {
            print("ELSE detail mahasiswa");
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: whiteBgPage,
            appBar: CustomAppBar(
              title: 'Dosen',
            ),
            body: (state is InitDetailDosenState)
                ? LoadingDetailDosenPDDikti()
                : (state is NoInternetState)
                    ? NoInternet(onPressed: () {}, buttonHide: true)
                    : ListView(
                        children: [
                          CardMahasiswaDosenRev(
                            nama: widget.nama,
                            namaPT: widget.namaPT,
                            namaProdi: widget.namaProdi,
                            nomorInduk: widget.nomorInduk,
                            keteranganNomor: "NIDN",
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
                                        fontSize:
                                            screenWidth(context) * (1 / 25)),
                                    unselectedLabelColor: neutralCaption,
                                    unselectedLabelStyle: TextStyle(
                                        fontWeight: FontWeight.w200,
                                        fontSize:
                                            screenWidth(context) * (1 / 25)),
                                    indicatorColor: Colors.transparent,
                                    indicatorWeight: 0.01,
                                    labelPadding:
                                        EdgeInsets.symmetric(horizontal: 4.w),
                                    tabs: [
                                      tabBarDosen(
                                          headers: widget.headersTitle[0],
                                          checkIndex: checkBiodata),
                                      tabBarDosen(
                                          headers: widget.headersTitle[1],
                                          checkIndex: checkRiwayatPendidikan),
                                      tabBarDosen(
                                          headers: widget.headersTitle[2],
                                          checkIndex: checkRiwayatMengajar),
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
                          // TabBarPDDikti(
                          //   tabController: tabController,
                          //   headersTitle: widget.headersTitle,
                          // ),
                          Container(
                            width: double.infinity,
                            height: screenHeight(context) * (1 / 2.1),
                            child: TabBarView(
                              controller: tabController,
                              children: [
                                TabBiodataDosen(
                                  detailDosen: detailDosen,
                                ),
                                TabPendidikanDosen(
                                  riwayatPendidikan: riwayatPendidikanDosen,
                                ),
                                TabMengajarDosen(
                                  riwayatMengajar: riwayatMengajarDosen,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
          );
        },
      ),
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
              color: checkIndex ? blue4 : abu6),
        ),
      ),
    );
  }
}
