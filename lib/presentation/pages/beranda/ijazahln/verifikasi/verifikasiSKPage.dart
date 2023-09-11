import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/customSliverBar.dart';
import 'package:app/presentation/pages/beranda/ijazahln/bloc/ijazahln/verifikasisk/negarapt/negara_bloc.dart';
import 'package:app/presentation/pages/beranda/ijazahln/bloc/ijazahln/verifikasisk/verifikasisk_bloc.dart';
import 'package:app/presentation/pages/beranda/ijazahln/component/bottom_sheet_noSK.dart';
import 'package:app/presentation/pages/beranda/ijazahln/component/reusableWidgets/customCircularProgress.dart';
import 'package:app/presentation/pages/beranda/ijazahln/component/reusableWidgets/informationCard.dart';
import 'package:app/presentation/pages/beranda/ijazahln/component/type_field_pt.dart';
import 'package:app/presentation/pages/beranda/ijazahln/verifikasi/hasilVerifikasiPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../component/bannerSubJudul.dart';

class VerifikasiSKPage extends StatefulWidget {
  const VerifikasiSKPage({Key? key}) : super(key: key);

  @override
  _VerifikasiSKPageState createState() => _VerifikasiSKPageState();
}

class _VerifikasiSKPageState extends State<VerifikasiSKPage>
    with SingleTickerProviderStateMixin {
  TextEditingController nomorSKController = new TextEditingController();
  TextEditingController negaraController = new TextEditingController();
  TextEditingController ptController = new TextEditingController();
  var listVerif;
  List<String> recentDocument = [];

  static Future<SharedPreferences> getPrefs() async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    return await _prefs;
  }

  void getRecentDocument() async {
    SharedPreferences prefs = await getPrefs();
    setState(() {
      if((prefs.getStringList("hasilVerifikasi")!.isNotEmpty) && prefs.getStringList("kodeNegara_PT")!.isNotEmpty){
        recentDocument = [
          prefs.getStringList("hasilVerifikasi")![0],
          prefs.getStringList("hasilVerifikasi")![1],
          prefs.getStringList("hasilVerifikasi")![2],
          prefs.getStringList("kodeNegara_PT")![0],
          prefs.getStringList("kodeNegara_PT")![1]
        ];
      }
    });
  }

  @override
  void initState() {
    getRecentDocument();
    nomorSKController.clear();
    negaraController.clear();
    ptController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var textStyleLabelForm =
        TextStyle(color: blue4, fontSize: 12.sp, letterSpacing: 0.08.sp);
    return Container(
      color: blueLinear2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomSliverBar(
          expandedHeight: 260.w,
          header: FlexibleSpaceBar(background: _header()),
          appBarTitle: "Ijazah LN",
          child: Container(
            color: whiteBgPage,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 30.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // information
                  InformationCard(
                    text: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text:
                              "SK yang dapat dilacak pada halaman ini merupakan data yang tercatat dari bulan Oktober 2020. Jika data tidak ditemukan, silakan hubungi ",
                          style: TextStyle(
                            color: neutralCaption,
                            fontSize: 10.sp,
                            height: 1.5,
                            letterSpacing: 0.08.sp,
                          )),
                      TextSpan(
                          text: "Tim Penyetaraan Ijazah LN.",
                          style: TextStyle(
                            color: blue4,
                            fontSize: 10.sp,
                            height: 1.5,
                            letterSpacing: 0.08.sp,
                          ))
                    ])),
                  ),

                  recentDocument.isNotEmpty
                  ? Column(
                      children:[
                        SizedBox(
                          height: 30.h,
                        ),
                        bannerSubJudul("Recent Document"),
                        SizedBox(
                          height: 10.h,
                        ),
                        _bannerRecentDocument(),
                        SizedBox(
                          height: 30.h,
                        ),
                      ]   
                    )
                  : SizedBox(
                      height: 18.h,
                    ),

                  // negara pt
                  RichText(
                    text: TextSpan(children: [
                      WidgetSpan(
                          child: Image.asset(
                        'assets/icons/ijazahln/icon_location.png',
                        width: 16.sp,
                        height: 16.sp,
                      )),
                      WidgetSpan(
                          child: SizedBox(
                        width: 8.w,
                      )),
                      TextSpan(
                        text: 'Asal Negara Perguruan Tinggi ',
                        style: textStyleLabelForm,
                      ),
                      TextSpan(
                          text: '*',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold)),
                    ]),
                  ),
                  SizedBox(
                    height: screenHeight(context) * (1 / 60),
                  ),
                  textFieldNegaraIjazah(context, negaraController),
                  SizedBox(
                    height: screenHeight(context) * (1 / 60),
                  ),

                  // negara pt
                  RichText(
                    text: TextSpan(children: [
                      WidgetSpan(
                          child: Image.asset(
                        'assets/icons/ijazahln/icon_pt.png',
                        width: 16.sp,
                        height: 16.sp,
                      )),
                      WidgetSpan(
                          child: SizedBox(
                        width: 8.w,
                      )),
                      TextSpan(
                        text: 'Perguruan Tinggi ',
                        style: textStyleLabelForm,
                      ),
                      TextSpan(
                          text: '*',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold)),
                    ]),
                  ),
                  SizedBox(
                    height: screenHeight(context) * (1 / 60),
                  ),
                  textFieldPTIjazah(context, ptController),
                  SizedBox(
                    height: screenHeight(context) * (1 / 60),
                  ),
                  RichText(
                    text: TextSpan(children: [
                      WidgetSpan(
                          child: Image.asset(
                        'assets/icons/ijazahln/icon_identitas.png',
                        width: 16.sp,
                        height: 16.sp,
                      )),
                      WidgetSpan(
                          child: SizedBox(
                        width: 8.w,
                      )),
                      TextSpan(
                        text: 'Nomor SK ',
                        style: textStyleLabelForm,
                      ),
                      TextSpan(
                          text: '*',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold)),
                    ]),
                  ),
                  SizedBox(
                    height: screenHeight(context) * (1 / 90),
                  ),
                  GestureDetector(
                    onTap: () {
                      nomorSKController.clear();
                      showModalBottomSheet(
                        isScrollControlled: true,
                        isDismissible: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) {
                          return BottomSheetNomorSK(
                            siagaPageContext: context, 
                            textEditingController: nomorSKController
                          );
                        },
                      );
                    },
                    child: Container(
                        color: white,
                        child: TextFormField(
                          enabled: false,
                          style: hintTextStyle.copyWith(color: neutral80),
                          controller: nomorSKController,
                          decoration: InputDecoration(
                            hintText: '5449/Belmawa/Kep/IJLN/2016',
                            hintStyle: hintTextStyle,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12.sp, vertical: 16.sp),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            isDense: true,
                          ),
                        ),
                      ),
                  ),
                  SizedBox(height: 8.h),

                  Text(
                    'Pastikan penulisan huruf kapital sudah sesuai SK',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFF0AD4E),
                    ),
                  ),

                  SizedBox(
                    height: screenHeight(context) * (1 / 60),
                  ),

                  _buttonCari(context),

                  SizedBox(
                    height: 18.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buttonCari(BuildContext context) {
    return BlocBuilder<NegaraBloc, NegaraState>(
      builder: (context, state) {
        if (state is NegaraInitialState) {
          return Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () async{
                if (negaraController.text.isNotEmpty &&
                    ptController.text.isNotEmpty &&
                    nomorSKController.text.isNotEmpty) {
                  String kodeNegara = state.kodeNegara ?? '';
                  String tokenPT = state.pt?.ptId ?? '';
                  String nomorSKIjazah = nomorSKController.text;
                  SharedPreferences prefs =  await getPrefs();
                  prefs.remove("kodeNegara_PT");
                  prefs.setStringList("kodeNegara_PT", [
                    kodeNegara,
                    tokenPT
                  ]);
                  _onClickHasilIjazah(kodeNegara, tokenPT, nomorSKIjazah);
                } else if (negaraController.text.isNotEmpty &&
                    ptController.text.isNotEmpty &&
                    nomorSKController.text.isEmpty) {
                  SnackBar isiPesan = SnackBar(
                    content: Text(
                      'Harap isi Nomor SK terlebih dahulu',
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(isiPesan);
                } else {
                  SnackBar isiPesan = SnackBar(
                    content: Text(
                      'Harap isi Field terlebih dahulu',
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(isiPesan);
                  return;
                }
              },
              child: Container(
                  height: 50.h,
                  width: 358.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: biruMuda2,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Text(
                      'Cari',
                      style: TextStyle(
                          color: white,
                          fontSize: 14.sp,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w700),
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

  void _onClickHasilIjazah(
      String kodeNegara, String tokenPT, String nomorSKIjazah) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => di.locator<VerifikasiskBloc>()
            ..add(FetchVerifikasiSk(kodeNegara, tokenPT, nomorSKIjazah)),
          child: BlocBuilder<VerifikasiskBloc, VerifikasiskState>(
            builder: (context, state) {
              if (state is VerifikasiskLoading) {
                return Scaffold(
                  backgroundColor: whiteBgPage,
                  appBar: CustomAppBar(
                    title: 'Ijazah LN',
                  ),
                  body: Container(
                    child: Center(child: CustomCircularProgress()),
                  ),
                );
              }
              if (state is VerifikasiskLoaded) {
                return HasilVerifikasi(
                  verifikasiBerhasil: true,
                  listVerif: state.listVerif,
                );
              }
              if (state is VerifikasiSkFailed) {
                return HasilVerifikasi(
                  verifikasiBerhasil: false,
                  listVerif: listVerif,
                );
              }
              return Center(child: CustomCircularProgress());
            },
          ),
        ),
      ),
    ).then((value) {
      setState(() {});
      ptController.clear();
      negaraController.clear();
      nomorSKController.clear();
      BlocProvider.of<NegaraBloc>(context)
          .add(UpdateNegaraEvent(kodeNegara: '', namaNegara: ''));
    });
  }

  InputDecoration styleBorder(String hint) {
    return InputDecoration(
        suffixIcon: Icon(
          Icons.arrow_drop_down,
          color: neutralCaption,
        ),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(style: BorderStyle.none, color: white)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(style: BorderStyle.none, color: white),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(style: BorderStyle.none, color: white),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(style: BorderStyle.none, color: white),
        ),
        contentPadding:
            EdgeInsets.symmetric(horizontal: 12.sp, vertical: 16.sp),
        hintText: hint,
        hintStyle: hintTextStyle);
  }

  DropdownMenuItem<String> buildMenuItem(String e) {
    return DropdownMenuItem(
        value: e,
        child: Text(
          e,
          style: TextStyle(
            fontSize: screenArea(context) * (0.00005),
          ),
        ));
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(gradient: beasiswaBgGradient),
      child: Stack(
        children: [
          Positioned(
            right: -12.w,
            bottom: -22.w,
            child: Opacity(
              opacity: 0.75,
              child: Image.asset(
                'assets/ijazahln/ilus_verifsk.png',
                width: 199.w,
                height: 199.w,
              ),
            ),
          ),
          Positioned(
            left: 23.w,
            bottom: 43.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Verifikasi SK\nPenyetaraan",
                  style: TextStyle(
                      color: whiteBgPage,
                      fontWeight: FontWeight.bold,
                      fontSize: 24.sp,
                      letterSpacing: 0.08.sp),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Text(
                  "Lacak SK Penyetaraan Ijazah Anda",
                  style: TextStyle(
                    color: white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget bannerSubJudul(String hintText) {
    return Column(
      children: [
        BannerSubJudul(
          subJudul: hintText,
          warna: blue3,
          edgeInsets: EdgeInsets.symmetric(horizontal: 16.w),
        ),
        SizedBox(
          height: 21.h,
        )
      ],
    );
  }

  Widget _bannerRecentDocument(){
    return GestureDetector(
      onTap: () {
        _onClickHasilIjazah(
          recentDocument[3],
          recentDocument[4],
          recentDocument[2]
        );
      },
      child: Container(
      width: 360.w,
      height: 115.sp,
      padding: EdgeInsets.symmetric(horizontal: 25.w),
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
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.006.sp,
                color: Colors.black
              ),
            ),
            SizedBox(
              height: 10.w,
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
              height: 10.w,
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
}
