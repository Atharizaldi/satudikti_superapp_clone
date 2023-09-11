import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/detail_pencarian/mahasiswa/detail_pencarian_mahasiswa_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/card/cardMahasiswaDosenRev.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/loadingPddikti/loading_detail_mahasiswa_pddikti.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/mahasiswaPage/biodataMahasiswa.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/mahasiswaPage/statusKuliahMahasiswa.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/mahasiswaPage/studiMahasiswa.dart';
import 'package:app/presentation/pages/beranda/pddikti/cubit/tab_bar/tab_bar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailMahasiswaPage extends StatefulWidget {
  final String nama, nomorInduk, kodePT, kodePD, namaProdi, namaPT;
  final bool fromElasticGeneral;
  final List<String> headersTitle = [
    "Biodata",
    "Riwayat Status Kuliah",
    "Riwayat Studi",
  ];
  DetailMahasiswaPage(
      {Key? key,
      required this.nama,
      required this.nomorInduk,
      required this.kodePT,
      required this.kodePD,
      required this.namaPT,
      required this.namaProdi,
      required this.fromElasticGeneral})
      : super(key: key);

  @override
  _DetailMahasiswaPageState createState() => _DetailMahasiswaPageState();
}

class _DetailMahasiswaPageState extends State<DetailMahasiswaPage>
    with SingleTickerProviderStateMixin {
  var detailMahasiswa, riwayatKuliahMahasiswa, riwayatStudiMahasiswa;

  late TabController tabController;

  bool checkBiodata = true;
  bool checkRiwayatStatusKuliah = false;
  bool checkRiwayatStudi = false;
  @override
  void initState() {
    tabController = new TabController(length: 3, vsync: this);
    tabController.addListener(() {
      print("tab ${tabController.index}");
      tabController.animateTo(tabController.index);
      if (tabController.index == 0) {
        setState(() {
          checkBiodata = true;
          checkRiwayatStatusKuliah = false;
          checkRiwayatStudi = false;
        });
      } else if (tabController.index == 1) {
        setState(() {
          checkBiodata = false;
          checkRiwayatStatusKuliah = true;
          checkRiwayatStudi = false;
        });
      } else {
        setState(() {
          checkBiodata = false;
          checkRiwayatStatusKuliah = false;
          checkRiwayatStudi = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TabBarCubit(),
      child: BlocConsumer<DetailPencarianMahasiswaBloc,
          DetailPencarianMahasiswaState>(
        listener: (context, state) {
          print('STATE LISTENER: $state');

          if (state is LoadedDetailState) {
            final bloc = BlocProvider.of<DetailPencarianMahasiswaBloc>(context);
            detailMahasiswa = bloc.listDetailMahasiswa!;
            riwayatKuliahMahasiswa = bloc.riwayatKuliahMahasiswa;
            riwayatStudiMahasiswa = bloc.riwayatStudiMahasiswa;
          } else {
            print("ELSE detail mahasiswa");
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: whiteBgPage,
            appBar: CustomAppBar(title: 'Mahasiswa'),
            body: (state is InitDetailState)
                ? LoadingDetailMahasiswaPDDikti()
                : (state is NoInternetState)
                    ? NoInternet(onPressed: () {}, buttonHide: true)
                    : ListView(
                        children: [
                          CardMahasiswaDosenRev(
                            nama: widget.nama,
                            namaPT: widget.fromElasticGeneral
                                ? detailMahasiswa
                                    .data.mahasiswa[0].terdaftar.namaPt
                                : widget.namaPT,
                            namaProdi: widget.fromElasticGeneral
                                ? detailMahasiswa
                                    .data.mahasiswa[0].terdaftar.namaProdi
                                : widget.namaProdi,
                            nomorInduk: widget.fromElasticGeneral
                                ? detailMahasiswa
                                    .data.mahasiswa[0].terdaftar.nim
                                : widget.nomorInduk,
                            keteranganNomor: "NIM",
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
                                          checkIndex: checkRiwayatStatusKuliah),
                                      tabBarDosen(
                                          headers: widget.headersTitle[2],
                                          checkIndex: checkRiwayatStudi),
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
                            height: screenHeight(context) * (1 / 2.1),
                            child: TabBarView(
                              controller: tabController,
                              children: [
                                widget.fromElasticGeneral
                                    ? TabBiodataMahasiswa(
                                        jKelamin: detailMahasiswa
                                            .data.mahasiswa[0].jenisKelamin,
                                        jenjang: detailMahasiswa
                                            .data
                                            .mahasiswa[0]
                                            .terdaftar
                                            .jenjangDidik
                                            .nama,
                                        smtAwal: detailMahasiswa.data
                                            .mahasiswa[0].terdaftar.smtMulai,
                                        statusAwal: detailMahasiswa
                                            .data
                                            .mahasiswa[0]
                                            .terdaftar
                                            .jenisDaftar
                                            .nama,
                                        statusSaatIni: detailMahasiswa
                                                    .data
                                                    .mahasiswa[0]
                                                    .terdaftar
                                                    .jenisKeluar
                                                    .ket ==
                                                ''
                                            ? 'Belum Lulus'
                                            : detailMahasiswa.data.mahasiswa[0]
                                                .terdaftar.jenisKeluar.ket,
                                      )
                                    : TabBiodataMahasiswa(
                                        jKelamin: detailMahasiswa
                                            .data.mahasiswa.jenisKelamin,
                                        jenjang: detailMahasiswa.data.mahasiswa
                                            .terdaftar.jenjangDidik.nama,
                                        smtAwal: detailMahasiswa
                                            .data.mahasiswa.terdaftar.smtMulai,
                                        statusAwal: detailMahasiswa
                                            .data
                                            .mahasiswa
                                            .terdaftar
                                            .jenisDaftar
                                            .nama,
                                        statusSaatIni: detailMahasiswa
                                                    .data
                                                    .mahasiswa
                                                    .terdaftar
                                                    .jenisKeluar
                                                    .ket ==
                                                ''
                                            ? 'Belum Lulus'
                                            : detailMahasiswa.data.mahasiswa
                                                .terdaftar.jenisKeluar.ket,
                                      ),
                                (riwayatKuliahMahasiswa != null)
                                    ? TabStatusKuliahMahasiswa(
                                        riwayatStatusKuliah:
                                            riwayatKuliahMahasiswa,
                                      )
                                    : _dataTidakDitemukan(),
                                (riwayatStudiMahasiswa != null)
                                    ? TabStudiMahasiswa(
                                        riwayatStudiMahasiswa:
                                            riwayatStudiMahasiswa,
                                      )
                                    : _dataTidakDitemukan(),
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
            color: checkIndex ? blue4 : abu6,
          ),
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
}
