import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../component/reusableWidgets/rowResult.dart';

class HasilVerifikasi extends StatefulWidget {
  final bool verifikasiBerhasil;
  final dynamic listVerif;

  HasilVerifikasi({Key? key, required this.verifikasiBerhasil, this.listVerif})
      : super(key: key);

  @override
  _HasilVerifikasiState createState() => _HasilVerifikasiState();
}

class _HasilVerifikasiState extends State<HasilVerifikasi>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<double> _opacity;
  // late Animation<double> _opacityCheck;
  late Animation<double> _opacityDetail;
  late Animation<Offset> _positioned;
  late Animation<Offset> _positionedDetail;
  late Animation<Offset> _positionedTidakDItemukan;
  late Animation<Offset> _positionedLogoTidakDItemukan;

  bool flag = false;
  bool flag2 = false;

  static Future<SharedPreferences> getPrefs() async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    return await _prefs;
  }

  void setRecendtData() async {
    SharedPreferences prefs = await getPrefs();
    prefs.remove("hasilVerifikasi");
    prefs.setStringList("hasilVerifikasi", [
      widget.listVerif.data.statusSk.namaPengusul,
      widget.listVerif.data.statusSk.namaGelar,
      widget.listVerif.data.statusSk.noSk,
    ]);
  }

  @override
  void initState() {
    super.initState();
    setRecendtData();

    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    _opacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _animationController, curve: Interval(0, 0.3)));
    _opacityDetail = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _animationController, curve: Interval(0.9, 1)));
    _positioned = Tween<Offset>(begin: Offset(0, 1.5), end: Offset(0, 1 / 3))
        .animate(CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.4, 1, curve: Curves.decelerate)));
    _positionedDetail = Tween<Offset>(begin: Offset(0, 0), end: Offset(0, -0.9))
        .animate(CurvedAnimation(
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
      appBar: CustomAppBar(
        title: 'Verifikasi SK Penyetaraan',
        textStyle: TextStyle(
            fontSize: 16,
            color: white,
            fontWeight: FontWeight.w600,
            letterSpacing: 1),
      ),
      body: Container(
        width: double.infinity,
        child: widget.verifikasiBerhasil == true
            ? Column(
                children: [
                  _dataDitemukanAnimationCard(),
                  SizedBox(
                    height: 60.h,
                  ),
                  FadeTransition(
                    opacity: _opacityDetail,
                    child: detailCard(),
                  )
                ],
              )
            : tidakDitemukan(context, () {
                Navigator.pop(context);
              }),
      ),
    );
  }

  FadeTransition _dataDitemukanAnimationCard() {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(
        position: _positioned,
        child: Container(
          width: 358.w,
          height: 108.w,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
              color: green3, borderRadius: BorderRadius.circular(10)),
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
                        color: white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold),
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
                            text: "Nomor SK ",
                            style: TextStyle(
                                color: Color(0xffE2FFCE), fontSize: 16.sp)),
                        TextSpan(
                            text: widget.listVerif.data.statusSk.noSk,
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
                  Clipboard.setData(
                      ClipboardData(text: widget.listVerif.data.statusSk.noSk));
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Copied to Clipboard.")));
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Column tidakDitemukan(BuildContext context, VoidCallback pijit) {
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
            Navigator.pop(context);
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

  Container detailCard() {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), color: white),
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 30.w),
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.w),
      child: Column(
        children: [
          RowResult(
            keterangan: "Nama",
            hasil: widget.listVerif.data.statusSk.namaPengusul,
          ),
          SizedBox(
            height: 30.w,
          ),
          RowResult(
            keterangan: "Perguruan Tinggi",
            hasil: widget.listVerif.data.statusSk.namaPt,
          ),
          SizedBox(
            height: 30.w,
          ),
          RowResult(
            keterangan: "Program Studi",
            hasil: widget.listVerif.data.statusSk.namaProdi,
          ),
          SizedBox(
            height: 30.w,
          ),
          RowResult(
            keterangan: "Gelar",
            hasil: widget.listVerif.data.statusSk.namaGelar,
          ),
          SizedBox(
            height: 30.w,
          ),
          RowResult(
            keterangan: "Hasil Kesetaraan",
            hasil: widget.listVerif.data.statusSk.hasilKesetaraan,
          ),
        ],
      ),
    );
  }
}
