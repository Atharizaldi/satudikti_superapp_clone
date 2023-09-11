import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/bannerSubJudul.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customSliverBar.dart';
import 'package:app/presentation/pages/beranda/ijazahln/component/reusableWidgets/informationCard.dart';
import 'package:app/presentation/pages/beranda/sivil/bloc/sivil_bloc.dart';
import 'package:app/presentation/pages/beranda/sivil/component/appBarWidgetSivil.dart';
import 'package:app/presentation/pages/beranda/sivil/component/text_field_sivil.dart';
import 'package:app/presentation/pages/beranda/sivil/hasil_sivil/bloc/hasil_sivil_bloc.dart';
import 'package:app/presentation/pages/beranda/sivil/hasil_sivil/hasilSivil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SivilMainPage extends StatefulWidget {
  const SivilMainPage({Key? key}) : super(key: key);

  @override
  _SivilMainPageState createState() => _SivilMainPageState();
}


class _SivilMainPageState extends State<SivilMainPage> {
  late SivilBloc _sivilBloc;
  List<String> recentDocument = [];
  TextEditingController ptTextController = TextEditingController();
  TextEditingController prodiTextController = TextEditingController();
  TextEditingController noIjazahTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getRecentDocument();
  }

  static Future<SharedPreferences> getPrefs() async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    return await _prefs;
  }

  void getRecentDocument() async {
    SharedPreferences prefs = await getPrefs();
    setState(() {
      if(prefs.getStringList("Sivil")!.isNotEmpty){
        recentDocument = [
          prefs.getStringList("Sivil")![0],
          prefs.getStringList("Sivil")![1],
          prefs.getStringList("Sivil")![2],
          prefs.getStringList("Sivil")![3],
          prefs.getStringList("Sivil")![4]
        ];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _sivilBloc = BlocProvider.of<SivilBloc>(context);
    return Container(
      decoration: BoxDecoration(gradient: sliverBgGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomSliverBar(
          expandedHeight: 260.w,
          appBarTitle: "SIVIL",
          header: FlexibleSpaceBar(
            background: appBarWidgetSivil(context),
          ),
          child: Container(
            color: whiteBgPage,
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 30.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _informasi(),
                recentDocument.isNotEmpty
                ? Column(
                    children:[
                      SizedBox(
                        height: 30.h,
                      ),
                      _bannerSubJudul("Recent Document"),
                      SizedBox(
                        height: 30.h,
                      ),
                      _bannerRecentDocument(),
                      SizedBox(
                        height: 30.h,
                      ),
                    ]   
                  )
                : SizedBox(
                    height: 30.h,
                  ),

                _bannerSubJudul('Verifikasi Ijazah Anda'),
                SizedBox(
                  height: 20.h,
                ),
                _textField(),
                SizedBox(
                  height: 30.h,
                ),
                _buttonCari(),
                SizedBox(
                  height: 30.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _informasi() {
    return InformationCard(
      text: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text:
                  "Pendataan PDDikti secara resmi dilakukan mulai pada tahun 2002/2003. Pastikan penggunaan huruf kapital sudah sesuai. Jika tidak terdaftar, silakan hubungi Perguruan Tinggi yang menerbitkan ijazah. ",
              style: TextStyle(
                color: neutralCaption,
                fontSize: 10.sp,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bannerSubJudul(String textSubtitle) {
    return BannerSubJudul(
      subJudul: textSubtitle,
      warna: blue3,
      edgeInsets: EdgeInsets.zero,
    );
  }

  Widget _bannerRecentDocument(){
    return GestureDetector(
      onTap: (){
        _onClickHasilSivil(
          recentDocument[3].toString(), 
          recentDocument[4].toString(), 
          recentDocument[2].toString()
          );
      },
      child: Container(
      width: 358.w,
      height: 115.sp,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: white,
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              recentDocument[0],
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.006.sp,
                color: Colors.black
              ),
            ),
            SizedBox(
              height: 8.w,
            ),
            Text(
              recentDocument[1],
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.006.sp,
                color: Colors.black
              ),
            ),
            SizedBox(
              height: 8.w,
            ),
            Text(
              recentDocument[2],
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.006.sp,
                color: Colors.black
              ),
            ),
          ],
        ),
      )
    );
  }

  Widget _textField() {
    return Column(
      children: [
        _typeFormPerguruanTinggi(),
        SizedBox(
          height: 20.h,
        ),
        _typeFormProdi(),
        SizedBox(
          height: 20.h,
        ),
        _typeFormNoIjazah(),
      ],
    );
  }

  Widget _typeFormPerguruanTinggi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Image.asset(
                  'assets/sivil/icon_perguruantinggi.png',
                  width: 21.w,
                  height: 19.w,
                ),
              ),
              WidgetSpan(
                child: SizedBox(
                  width: 8.w,
                ),
              ),
              TextSpan(
                text: 'Perguruan Tinggi',
                style: TextStyle(
                    color: blue4,
                    fontSize: 12.sp,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w400),
              ),
              TextSpan(
                text: '*',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 12.sp,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 6.h,
        ),
        textFieldPT(context, ptTextController),
      ],
    );
  }

  Widget _typeFormProdi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Image.asset(
                  'assets/sivil/icon_programstudi.png',
                  width: 18.w,
                  height: 18.w,
                ),
              ),
              WidgetSpan(
                child: SizedBox(
                  width: 8.w,
                ),
              ),
              TextSpan(
                text: 'Program Studi',
                style: TextStyle(
                    color: blue4,
                    fontSize: 12.sp,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w400),
              ),
              TextSpan(
                text: '*',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 12.sp,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 6.h,
        ),
        textFieldProdi(context, prodiTextController),
      ],
    );
  }

  Widget _typeFormNoIjazah() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Image.asset(
                  'assets/sivil/icon_noijazah.png',
                  width: 16.w,
                  height: 16.w,
                ),
              ),
              WidgetSpan(
                child: SizedBox(
                  width: 8.w,
                ),
              ),
              TextSpan(
                text: 'Nomor Ijazah',
                style: TextStyle(
                    color: blue4,
                    fontSize: 12.sp,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w400),
              ),
              TextSpan(
                text: '*',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 12.sp,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 6.h,
        ),
        textFieldNoIjazah(context, noIjazahTextController),
        SizedBox(height: 8.h,),
        Text(
          "Pastikan penulisan huruf kapital sudah sesuai SK",
          style: TextStyle(
            color: orange2,
            fontSize: 12.sp
          ),
        )
      ],
    );
  }

  Widget _buttonCari() {
    return BlocBuilder<SivilBloc, SivilState>(
      builder: (context, state) {
        if (state is SivilInitialState) {
          String kodePt = state.pt?.kode ?? '';
          String kodeProdi = state.prodi?.kode ?? '';
          String noIjazah = state.noIjazah ?? '';
          bool isTextFilled = allFieldFilled(kodePt, kodeProdi, noIjazah);
          return Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                if (isTextFilled) {
                  _onClickHasilSivil(kodePt, kodeProdi, noIjazah);
                  FocusManager.instance.primaryFocus?.unfocus();
                } else {
                  SnackBar isiPt = SnackBar(
                    content: Text(
                      'Harap isi semua kolom terlebih dahulu',
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(isiPt);
                }
              },
              child: Container(
                height: 50.h,
                width: 358.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: biruMuda2,
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: Text(
                  'Cari',
                  style: TextStyle(
                    color: white,
                    fontSize: 14.sp,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  void _onClickHasilSivil(String kodePt, String kodeProdi, String noIjazah) {
    ptTextController.clear();
    prodiTextController.clear();
    noIjazahTextController.clear();
    _sivilBloc..add(ClearEvent());
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => di.locator<HasilSivilBloc>()
            ..add(LoadHasilSivilEvent(
              kodeProdi: kodeProdi,
              kodePT: kodePt,
              noIjazah: noIjazah,
            )),
          child: HasilSivil(
            kodeProdi: kodeProdi,
            kodePT: kodePt,
            noIjazah: noIjazah,
          ),
        ),
      ),
    );
  }

  bool allFieldFilled(String? kodePt, String? kodeProdi, String? noIjazah) {
    bool ptAvailable = kodePt != null && kodePt != "";
    bool prodiAvailable = kodeProdi != null && kodeProdi != "";
    bool noIjazahAvailable = noIjazah != null && noIjazah != "";
    if (ptAvailable && prodiAvailable && noIjazahAvailable) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    ptTextController.dispose();
    prodiTextController.dispose();
    noIjazahTextController.dispose();
    super.dispose();
  }
}
