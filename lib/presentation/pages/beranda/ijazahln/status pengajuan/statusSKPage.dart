import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/customSliverBar.dart';
import 'package:app/presentation/pages/beranda/ijazahln/bloc/ijazahln/statuspengajuan/statuspengajuan_bloc.dart';
import 'package:app/presentation/pages/beranda/ijazahln/component/bottom_sheet_noRegistrasi.dart';
import 'package:app/presentation/pages/beranda/ijazahln/component/reusableWidgets/customCircularProgress.dart';
import 'package:app/presentation/pages/beranda/ijazahln/component/reusableWidgets/informationCard.dart';
import 'package:app/presentation/pages/beranda/ijazahln/component/statusPengjuanPage/detailHasilStatusPage.dart';
import 'package:app/presentation/pages/beranda/ijazahln/status%20pengajuan/hasilStatusPengajuan.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../component/bannerSubJudul.dart';

class StatusSKPage extends StatefulWidget {
  const StatusSKPage({Key? key}) : super(key: key);

  @override
  _StatusSKPageState createState() => _StatusSKPageState();
}

class _StatusSKPageState extends State<StatusSKPage> {
  // var ip = urlDev;
  // var port = '8089';
  TextEditingController nomorRegistrasiController = new TextEditingController();
  String? nomorResgistrasiValue;
  bool pengajuanBerhasil = false;

  var listByReg;
  var listByEmail;

  bool emailValid = true;
  bool nomorValid = true;
  List<String> recentDocument = [];

  static Future<SharedPreferences> getPrefs() async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    return await _prefs;
  }

  void getRecentDocument() async {
    SharedPreferences prefs = await getPrefs();
    setState(() {
      if(prefs.getStringList("statusSK")!.isNotEmpty){
        recentDocument = [
          prefs.getStringList("statusSK")![0],
          prefs.getStringList("statusSK")![1],
          prefs.getStringList("statusSK")![2],
        ];
      }
    });
  }

  @override
  void initState() {
    nomorRegistrasiController.clear();
    getRecentDocument();
    super.initState();
  }

  Future getByEmailBloc(BuildContext context, query) async {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => BlocProvider(
              create: (context) => di.locator<StatuspengajuanBloc>()
                ..add(FetchStatusPengajuan(query)),
              child: BlocBuilder<StatuspengajuanBloc, StatuspengajuanState>(
                builder: (context, state) {
                  if (state is StatuspengajuanLoading) {
                    return Scaffold(
                      appBar: CustomAppBar(
                        title: 'Ijazah LN',
                      ),
                      body: Container(
                        child: Center(child: CustomCircularProgress()),
                      ),
                    );
                  }
                  if (state is StatusPengajuanLoaded) {
                    return HasilStatusPengajuan(
                      pengajuanBerhasil: true,
                      listByEmail: state.listByEmail,
                    );
                  }
                  if (state is StatusPengajuanLoadedFailed) {
                    return HasilStatusPengajuan(
                      pengajuanBerhasil: false,
                      listByEmail: listByEmail,
                    );
                  }
                  return Center(child: CustomCircularProgress());
                },
              ))),
    ).then((value) {
      nomorRegistrasiController.clear();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: blueLinear2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomSliverBar(
          expandedHeight: 260.w,
          appBarTitle: "Ijazah LN",
          header: FlexibleSpaceBar(background: _header()),
          child: Container(
            color: whiteBgPage,
            height: 650.h,
            child: Stack(
              children: [
                // form
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 30.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // information
                      InformationCard(
                        text: Text(
                          "Untuk melacak status pengajuan status Penyetaraan Ijazah, anda dapat menggunakan nomor registrasi  atau email anda mendaftar pengajuan penyetaraan.",
                          style: TextStyle(
                              letterSpacing: 0.08.sp,
                              fontSize: 10.sp,
                              color: neutralCaption,
                              height: 1.5),
                        ),
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

                      RichText(
                        text: TextSpan(children: [
                          WidgetSpan(
                              child: Image.asset(
                            'assets/icons/ijazahln/icon_email.png',
                            width: 16.sp,
                            height: 16.sp,
                          )),
                          WidgetSpan(
                              child: SizedBox(
                            width: 8.w,
                          )),
                          TextSpan(
                            text: 'Nomor Registrasi / Email ',
                            style: TextStyle(
                                color: blue4,
                                fontSize: 12.sp,
                                letterSpacing: 0.08.sp),
                          ),
                          TextSpan(
                              text: '*',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold)),
                        ]),
                      ),
                      SizedBox(height: 9.h),
                      GestureDetector(
                        onTap: () {
                          nomorRegistrasiController.clear();
                          showModalBottomSheet(
                            isScrollControlled: true,
                            isDismissible: true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return BottomSheetNomorRegistrasi(
                                siagaPageContext: context, 
                                textEditingController: nomorRegistrasiController,
                                );
                            },
                          );
                        },
                        child: Container(
                          color: white,
                          child: TextFormField(
                            enabled: false,
                            style: hintTextStyle.copyWith(color: neutral80),
                            controller: nomorRegistrasiController,
                            // validator: ValidasiEmail.validate,
                            decoration: InputDecoration(
                              hintText: '1906399442 / abc@domain.com',
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12.sp, vertical: 16.sp),
                              hintStyle: TextStyle(
                                color: abu,
                                // fontSize: screenArea(context) * (0.00005),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                    color:
                                        emailValid == false || nomorValid == false
                                            ? Colors.red
                                            : white,
                                    style: BorderStyle.solid,
                                    width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                    color:
                                        emailValid == false || nomorValid == false
                                            ? Colors.red
                                            : white,
                                    style: BorderStyle.solid,
                                    width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                    color:
                                        emailValid == false || nomorValid == false
                                            ? Colors.red
                                            : white,
                                    style: BorderStyle.solid,
                                    width: 1.2),
                              ),
                              isDense: true,
                            ),
                            onChanged: (value) => {
                              setState(() {
                                this.nomorResgistrasiValue = value;
                              })
                            },
                            onSaved: (value) => nomorResgistrasiValue = value,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      emailValid == false
                          ? Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                'Email tidak valid',
                                style: TextStyle(
                                    color: Colors.red, fontSize: 10.sp),
                              ),
                            )
                          : Container(),
                      nomorValid == false
                          ? Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                'Nomor tidak valid',
                                style: TextStyle(
                                    color: Colors.red, fontSize: 10.sp),
                              ),
                            )
                          : Container(),
                      Align(
                        alignment: Alignment.centerRight,
                        child:
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            nomorValid = true;
                          });
                          if (nomorRegistrasiController.text.isEmpty) {
                            SnackBar isiPt = SnackBar(
                              content: Text(
                                'Harap isi semua kolom terlebih dahulu',
                                style: TextStyle(fontSize: 12.sp),
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(isiPt);
                          } else {
                            final nomor = RegExp(r'^[0-9]+$');
                            if (nomor
                                .hasMatch(nomorRegistrasiController.text)) {
                              var validasiNomor = nomorRegistrasiController.text
                                  .split("")
                                  .length;
                              print(validasiNomor);
                              if (7 > validasiNomor) {
                                print('masukkk');
                                setState(() {
                                  nomorValid = false;
                                  emailValid = true;
                                });
                                return;
                              } else if (validasiNomor > 9) {
                                print('masukkk');
                                setState(() {
                                  nomorValid = false;
                                  emailValid = true;
                                });
                                return;
                              } else {
                                print("else atas");
                                setState(() {
                                  nomorValid = true;
                                  emailValid = true;
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DetailHasilStatusPage(
                                              noRegis: nomorRegistrasiController
                                                  .text),
                                    )).then((value) {
                                  setState(() {});
                                  nomorRegistrasiController.clear();
                                });
                                print('gamasukkk');
                              }
                            } else if (EmailValidator.validate(
                                    nomorRegistrasiController.text) ==
                                true) {
                              emailValid = true;
                              print("keyword String");
                              getByEmailBloc(
                                  context, nomorRegistrasiController.text);
                            } else if (EmailValidator.validate(
                                    nomorRegistrasiController.text) ==
                                false) {
                              print("keyword String 2");

                              setState(() {
                                emailValid = false;
                                nomorValid = true;
                              });
                            }
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
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(gradient: beasiswaBgGradient),
      child: Stack(
        children: [
          Positioned(
            right: -6.w,
            bottom: -35.w,
            child: Opacity(
              opacity: 0.75,
              child: Image.asset(
                'assets/ijazahln/ilus_statuspengajuan.png',
                width: 226.w,
                height: 226.w,
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
                  "Cek Status Pengajuan \nPenyetaraan",
                  style: TextStyle(
                      color: whiteBgPage,
                      fontWeight: FontWeight.bold,
                      fontSize: 24.sp,
                      letterSpacing: 0.08.sp),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Container(
                  width: 320.w,
                  child: Text(
                    "Lacak Status Pengajuan Penyetaraan Ijazah Anda",
                    style: TextStyle(
                        color: white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500),
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
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DetailHasilStatusPage(
                    noRegis: recentDocument[2] 
                    ),
          )
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
