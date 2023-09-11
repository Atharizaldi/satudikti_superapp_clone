import 'package:app/data/source/remote/model/sivil/sivilList.dart';
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/pages/beranda/ijazahln/component/reusableWidgets/rowResult.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/detail_pencarian/mahasiswa/detail_pencarian_mahasiswa_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/detailMahasiswaPage.dart';
import 'package:app/presentation/pages/beranda/sivil/hasil_sivil/bloc/hasil_sivil_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HasilSivil extends StatefulWidget {
  final String? kodePT, kodeProdi, noIjazah;

  HasilSivil({
    Key? key,
    required this.kodePT,
    required this.kodeProdi,
    required this.noIjazah,
  }) : super(key: key);

  @override
  _HasilSivilState createState() => _HasilSivilState();
}

class _HasilSivilState extends State<HasilSivil> with TickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<double> _opacity;
  late Animation<double> _opacityDetail;
  late Animation<Offset> _positioned;
  late Animation<Offset> _positionedDetail;
  late Animation<Offset> _positionedTidakDItemukan;
  late Animation<Offset> _positionedLogoTidakDItemukan;

  bool flag = false;
  bool flag2 = false;

  Sivil? sivil;
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
    setSharedPrefernces();
    super.initState();

    // Future.delayed(Duration(seconds: 4), () {
    setState(() {
      _animationController = AnimationController(
          vsync: this, duration: Duration(milliseconds: 20));

      _opacity = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
          parent: _animationController, curve: Interval(0, 0.3)));
      _opacityDetail = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
          parent: _animationController, curve: Interval(0.9, 1)));
      _positioned = Tween<Offset>(begin: Offset(0, 1.5), end: Offset(0, 1 / 3))
          .animate(CurvedAnimation(
              parent: _animationController,
              curve: Interval(0.4, 1, curve: Curves.decelerate)));
      _positionedDetail =
          Tween<Offset>(begin: Offset(0, 0), end: Offset(0, -0.9)).animate(
              CurvedAnimation(
                  parent: _animationController,
                  curve: Interval(0.3, 1, curve: Curves.decelerate)));

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
      backgroundColor: whiteBgPage,
      appBar: CustomAppBar(title: 'Hasil verifikasi'),
      body: BlocConsumer<HasilSivilBloc, HasilSivilState>(
        listener: (context, state) {
          print("STATE hasil sivil $state");
          if (state is LoadedHasilSivilState) {
            sivil = BlocProvider.of<HasilSivilBloc>(context).sivil;
            prefs!.remove("Sivil");
            prefs!.setStringList("Sivil", [
              sivil!.data.mahasiswa[0].nama,
              sivil!.data.mahasiswa[0].terdaftar.namaProdi,
              sivil!.data.mahasiswa[0].terdaftar.noIjazah,
              sivil!.data.mahasiswa[0].terdaftar.kodePt,
              sivil!.data.mahasiswa[0].terdaftar.kodeProdi
            ]);
          }
        },
        builder: (context, state) {
          print("STATE BUILDER hasil sivil : $state");
          return (state is InitHasilSivilState)
              ? Center(
                  child: CircularProgressIndicator(
                    color: neutral100,
                  ),
                )
              : (state is NoInternetHasilSivilState)
                  ? NoInternet(onPressed: () {}, buttonHide: true)
                  : (state is NotFoundHasilSivilState)
                      ? tidakDitemukan(context)
                      : Container(
                          width: double.infinity,
                          child: ListView(
                            children: [
                              FadeTransition(
                                opacity: _opacity,
                                child: SlideTransition(
                                  position: _positioned,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 16.w, right: 16.w),
                                    child: CardBerhasilSivil(sivil: sivil),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 60.h,
                              ),
                              FadeTransition(
                                opacity: _opacityDetail,
                                child: detailCard(sivil),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 16.w, right: 21.w),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: white,
                                      elevation: 0,
                                      minimumSize: Size.fromHeight(48.h),
                                      side: BorderSide(color: blue4),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BlocProvider(
                                            create: (context) => di.locator<DetailPencarianMahasiswaBloc>()
                                              ..add(LoadDetailPencarianEvent(
                                                  nama: sivil?.data.mahasiswa[0]
                                                          .nama ??
                                                      "-",
                                                  nomorInduk: sivil
                                                          ?.data
                                                          .mahasiswa[0]
                                                          .terdaftar
                                                          .nim ??
                                                      "-",
                                                  kodePT: sivil
                                                          ?.data
                                                          .mahasiswa[0]
                                                          .terdaftar
                                                          .kodePt ??
                                                      "-",
                                                  kodePD: sivil
                                                          ?.data
                                                          .mahasiswa[0]
                                                          .terdaftar
                                                          .kodeProdi ??
                                                      "-",
                                                  namaPT: sivil?.data.mahasiswa[0].terdaftar.namaPt ?? "-",
                                                  namaProdi: sivil?.data.mahasiswa[0].terdaftar.namaProdi ?? "-",
                                                  fromElasticGeneral: false)),
                                            child: DetailMahasiswaPage(
                                                nama: sivil?.data.mahasiswa[0].nama ??
                                                    "-",
                                                nomorInduk: sivil
                                                        ?.data
                                                        .mahasiswa[0]
                                                        .terdaftar
                                                        .nim ??
                                                    "-",
                                                kodePT: sivil?.data.mahasiswa[0]
                                                        .terdaftar.kodePt ??
                                                    "-",
                                                kodePD: sivil?.data.mahasiswa[0]
                                                        .terdaftar.kodeProdi ??
                                                    "-",
                                                namaPT: sivil?.data.mahasiswa[0]
                                                        .terdaftar.namaPt ??
                                                    "-",
                                                namaProdi:
                                                    sivil?.data.mahasiswa[0].terdaftar.namaProdi ?? "-",
                                                fromElasticGeneral: false),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Lihat Data Pada PDDikti",
                                      style: TextStyle(
                                        color: blue4,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                              )
                            ],
                          ));
        },
      ),
    );
  }

  GestureDetector tidakDitemukan(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('pijit');
      },
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

  Column detailCard(Sivil? sivil) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: white),
          padding: EdgeInsets.only(top: 27.h, left: 27.w, bottom: 27.h),
          margin: EdgeInsets.symmetric(horizontal: 12.h),
          child: Column(
            children: [
              RowResult(
                  keterangan: "Nama",
                  hasil: sivil?.data.mahasiswa[0].nama ?? "-"),
              SizedBox(height: 16.sp),
              RowResult(
                  keterangan: "Nomor Mahasiswa",
                  hasil: sivil?.data.mahasiswa[0].terdaftar.nim ?? "-"),
              SizedBox(height: 16.sp),
              RowResult(
                  keterangan: "Perguruan Tinggi",
                  hasil: sivil?.data.mahasiswa[0].terdaftar.namaPt ?? "-"),
              SizedBox(height: 16.sp),
              RowResult(
                  keterangan: "Program Studi",
                  hasil: sivil?.data.mahasiswa[0].terdaftar.namaProdi ?? "-"),
              SizedBox(height: 16.sp),
              RowResult(
                  keterangan: "Jenjang Pendidikan",
                  hasil: sivil?.data.mahasiswa[0].terdaftar.jenjangDidik.nama ??
                      "-"),
              SizedBox(height: 16.sp),
              RowResult(
                  keterangan: "Nomor Ijazah",
                  hasil: sivil?.data.mahasiswa[0].terdaftar.noIjazah ?? "-"),
              SizedBox(height: 16.sp),
              RowResult(
                  keterangan: "Tanggal Lulus",
                  hasil: sivil?.data.mahasiswa[0].terdaftar.tglKeluar ?? "-"),
            ],
          ),
        ),
        SizedBox(height: 37.h),
      ],
    );
  }
}

class CardBerhasilSivil extends StatelessWidget {
  const CardBerhasilSivil({
    Key? key,
    required this.sivil,
  }) : super(key: key);

  final Sivil? sivil;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 358.w,
      height: 108.w,
      padding: EdgeInsets.all(20.w),
      decoration:
          BoxDecoration(color: green3, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_rounded,
            size: 34.w,
            color: white,
          ),
          SizedBox(
            width: 12.w,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectableText(
                "Data Ditemukan",
                style: TextStyle(
                    color: white, fontSize: 14.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8.w,
              ),
              SizedBox(
                width: 238.w,
                child: RichText(
                  maxLines: 2,
                  text: TextSpan(children: [
                    TextSpan(
                        text: "No. Ijazah ",
                        style: TextStyle(
                            color: Color(0xffE2FFCE), fontSize: 16.sp)),
                    TextSpan(
                        text: sivil?.data.mahasiswa[0].terdaftar.noIjazah,
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: white))
                  ]),
                ),
              )
            ],
          ),
          SizedBox(
            width: 12.w,
          ),
          // Icon(
          //   Icons.copy,
          //   size: 22.w,
          // ),
          IconButton(
            icon: Icon(
              Icons.copy,
              size: 22.w,
            ),
            constraints: BoxConstraints(),
            padding: EdgeInsets.zero,
            iconSize: 22.w,
            color: white,
            onPressed: () {
              Clipboard.setData(ClipboardData(
                text: sivil?.data.mahasiswa[0].terdaftar.noIjazah,
              ));
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Copied to Clipboard.")));
            },
          )
        ],
      ),
    );
  }
}
