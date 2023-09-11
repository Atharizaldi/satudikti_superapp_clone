import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/detail_pencarian/pt/detail_pencarian_pt_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/card/cardPerguruanTinggiRev.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/loadingPddikti/loading_detail_perguruan_tinggi_pddikti.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/perguruanTinggi/daftarJabataFungsional.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/perguruanTinggi/daftarNomorRegistrasi.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/perguruanTinggi/daftarProdi.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/perguruanTinggi/profilPT.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/reusableWidgets/detailCardSection.dart';
import 'package:app/presentation/pages/beranda/pddikti/cubit/tab_bar/tab_bar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailPerguruanTinggiPage extends StatefulWidget {
  final String kodePT;
  final bool fromSpecific;
  final List<String> headersTitle = [
    "Profil",
    "Daftar Program Studi",
    "Daftar Nomor Registrasi",
    "Daftar Jabatan Fungsional",
  ];
  DetailPerguruanTinggiPage(
      {Key? key, required this.kodePT, required this.fromSpecific})
      : super(key: key);

  @override
  _DetailPerguruanTinggiPageState createState() =>
      _DetailPerguruanTinggiPageState();
}

class _DetailPerguruanTinggiPageState extends State<DetailPerguruanTinggiPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  bool isLoading = true;
  bool isConnected = false;

  var detailPT;
  var akreditasiPT;
  var agregatPT;
  var pelaporanPT;

  var imagePT;

  bool haveAkreditasi = false;
  bool haveAgregat = false;
  bool havePelaporan = false;
  bool profil = true;
  bool daftarProgStud = false;
  bool daftarNoReg = false;
  bool daftarJabatanFungsional = false;

  @override
  void initState() {
    tabController = new TabController(length: 4, vsync: this);
    tabController.addListener(() {
      tabController.animateTo(tabController.index);
      if (tabController.index == 0) {
        setState(() {
          profil = true;
          daftarProgStud = false;
          daftarNoReg = false;
          daftarJabatanFungsional = false;
        });
      } else if (tabController.index == 1) {
        setState(() {
          profil = false;
          daftarProgStud = true;
          daftarNoReg = false;
          daftarJabatanFungsional = false;
        });
      } else if (tabController.index == 2) {
        setState(() {
          profil = false;
          daftarProgStud = false;
          daftarNoReg = true;
          daftarJabatanFungsional = false;
        });
      } else {
        setState(() {
          profil = false;
          daftarProgStud = false;
          daftarNoReg = false;
          daftarJabatanFungsional = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Perguruan Tinggi'),
      body: BlocProvider(
        create: (context) => TabBarCubit(),
        child: BlocConsumer<DetailPencarianPtBloc, DetailPencarianPtState>(
          listener: (context, state) {
            if (state is LoadedDetailPTState) {
              final bloc = BlocProvider.of<DetailPencarianPtBloc>(context);
              detailPT = bloc.listDetailPT!;
              agregatPT = bloc.listAgregatPT!;
              akreditasiPT = bloc.listAkreditasiPT!;
              pelaporanPT = bloc.listPelaporanPT!;

              haveAgregat = bloc.hasAgregat;
              haveAkreditasi = bloc.hasAkreditasi;
              havePelaporan = bloc.hasPelaporan;
              imagePT = bloc.imagePT!;
            } else {
              print("ELSE listener pt detail");
            }
          },
          builder: (context, state) {
            return (state is InitDetailPTState)
                ? LoadingDetailPerguruanTinggiPDDikti()
                : (state is NoInternetPTState)
                    ? NoInternet(onPressed: () {}, buttonHide: true)
                    : ListView(
                        children: [
                          DetailCardSection(
                            height: 340.h,
                            card: CardPerguruanTinggiRev(
                              logo: detailPT.data.perguruanTinggi.urlLogo == ''
                                  ? Image.asset(
                                      'assets/silemkerma.png',
                                      height: 47.h,
                                    )
                                  : imagePT,
                              namaPT: detailPT.data.perguruanTinggi.nama,
                              kodePT: detailPT.data.perguruanTinggi.kode,
                              namaRektor:
                                  detailPT.data.perguruanTinggi.pimpinan.nama,
                              status: detailPT.data.perguruanTinggi.status,
                              akreditasi: haveAkreditasi
                                  ? akreditasiPT.data.akreditasi[0].nilai
                                  : '',
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
                                          checkIndex: profil),
                                      tabBarDosen(
                                          headers: widget.headersTitle[1],
                                          checkIndex: daftarProgStud),
                                      tabBarDosen(
                                          headers: widget.headersTitle[2],
                                          checkIndex: daftarNoReg),
                                      tabBarDosen(
                                          headers: widget.headersTitle[3],
                                          checkIndex: daftarJabatanFungsional),
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
                          Container(
                            width: double.infinity,
                            height: screenHeight(context) * (1 / 2.15),
                            child: TabBarView(
                              controller: tabController,
                              children: [
                                TabProfilPT(
                                  getDetailPT: detailPT,
                                  getPelaporanPT: pelaporanPT,
                                  havePelaporan: havePelaporan,
                                ),
                                TabDaftarProdi(
                                  getDetailPT: detailPT,
                                ),
                                TabDaftarNomorRegistrasi(
                                  getAgregatPT: agregatPT,
                                  haveAgregat: haveAgregat,
                                ),
                                TabDaftarJabatanFungsional(
                                  getAgregatPT: agregatPT,
                                  haveAgregat: haveAgregat,
                                ),
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

  GestureDetector card(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 175.h,
        width: 330.w,
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14),
        decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: Color(0xff7090b0).withOpacity(0.05),
                  offset: Offset.zero,
                  blurRadius: 20,
                  spreadRadius: 3)
            ]),
        child: Column(
          children: [
            Container(
              height: 95.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  detailPT.data.perguruanTinggi.urlLogo == ''
                      ? Container(
                          height: 76.h,
                          width: 76.h,
                          child: Image.asset(
                            'assets/silemkerma.png',
                            scale: 1.5,
                          ))
                      : Container(
                          height: 76.h,
                          width: 76.h,
                          child: imagePT,
                        ),
                  Container(
                    margin: EdgeInsets.only(left: 10.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 200.w,
                              height: screenHeight(context) * (1 / 15),
                              child: Text(
                                detailPT.data.perguruanTinggi.nama,
                                maxLines: 2,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Kode PT: ${detailPT.data.perguruanTinggi.kode}',
                          style:
                              TextStyle(color: neutralCaption, fontSize: 12.sp),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: green3,
                                  borderRadius: BorderRadius.circular(8)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth(context) * (1 / 60),
                                  vertical: screenHeight(context) * (1 / 200)),
                              child: Center(
                                child: Text(
                                  haveAkreditasi
                                      ? 'Akreditasi ${akreditasiPT.data.akreditasi[0].nilai}'
                                      : 'Akreditasi -',
                                  style: TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 13.w,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: green3,
                                  borderRadius: BorderRadius.circular(8)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth(context) * (1 / 60),
                                  vertical: screenHeight(context) * (1 / 200)),
                              child: Center(
                                child: Text(
                                  detailPT.data.perguruanTinggi.status,
                                  style: TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 13.h,
            ),
            Container(
              width: screenWidth(context) * (1 / 1.2),
              height: screenHeight(context) * 0.05,
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth(context) * (1 / 90)),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: neutralCaption.withOpacity(0.3))),
              child: Center(
                child: Text(
                    detailPT.data.perguruanTinggi.pimpinan.nama == ''
                        ? 'Rektor   :  -'
                        : 'Rektor   :  ${detailPT.data.perguruanTinggi.pimpinan.nama}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1),
              ),
            )
          ],
        ),
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
            color: checkIndex ? blue4 : abu6,
          ),
        ),
      ),
    );
  }
}
