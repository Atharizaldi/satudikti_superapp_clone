import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customSliverBar.dart';
import 'package:app/presentation/component/inkEffect.dart';
import 'package:app/presentation/pages/beranda/ijazahln/bloc/ijazahln/verifikasisk/negarapt/negara_bloc.dart';
import 'package:app/presentation/pages/beranda/ijazahln/pelajariSelengkapnya.dart';
import 'package:app/presentation/pages/beranda/ijazahln/pencarianPTLN/pencarianPTLN.dart';
import 'package:app/presentation/pages/beranda/ijazahln/status%20pengajuan/statusSKPage.dart';
import 'package:app/presentation/pages/beranda/ijazahln/verifikasi/verifikasiSKPage.dart';
import 'package:app/presentation/pages/faq/bloc/faq_module/faqmodule_bloc.dart';
import 'package:app/presentation/pages/faq/faq_page_per_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IjazahLNMainPage extends StatefulWidget {
  const IjazahLNMainPage({Key? key}) : super(key: key);

  @override
  _IjazahLNMainPageState createState() => _IjazahLNMainPageState();
}

class _IjazahLNMainPageState extends State<IjazahLNMainPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: blueLinear2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomSliverBar(
            expandedHeight: 280.w,
            appBarTitle: "Ijazah LN",
            header: FlexibleSpaceBar(background: _header()),
            child: Padding(
              padding: EdgeInsets.only(
                  left: 16.w, right: 16.w, bottom: 20.h, top: 30.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pilihan Layanan",
                    style: TextStyle(
                      color: blue3,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20.w,
                  ),

                  // verifikasi
                  cardLayanan(
                    "Verifikasi SK Penyetaraan",
                    "Program Verifikasi SK penyetaraan ijazah luar negeri sesuai jenjang pendidikan yang berlaku di Indonesia.",
                    () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => di.locator<NegaraBloc>(),
                              child: VerifikasiSKPage(),
                            ),
                          ));
                    },
                    Image.asset(
                      "assets/ijazahln/ijazahLN_menu_logo_1.png",
                      width: 24.w,
                      height: 27.w,
                      fit: BoxFit.fill,
                      alignment: Alignment.center,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),

                  // status
                  cardLayanan(
                    "Cek Status Pengajuan Penyetaraan",
                    "Cek status pengajuan penyetaraan ijazah luar negeri yang sedang diproses oleh tim verifikator Ijazah Luar Negeri.",
                    () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StatusSKPage(),
                          ));
                    },
                    Image.asset(
                      "assets/ijazahln/ijazahLN_menu_logo_2.png",
                      width: 24.w,
                      height: 27.w,
                      fit: BoxFit.fill,
                      alignment: Alignment.center,
                    ),
                  ),
                  SizedBox(
                    height: 20.w,
                  ),

                  //pencarian pt
                  cardLayanan(
                    "Pencarian Perguruan Tinggi LN",
                    'Temukan Perguruan Tinggi luar negeri berdasarkan negara yang dapat melakukan penyetaraan ijazah di Indonesia.',
                    () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => di.locator<NegaraBloc>(),
                              child: PencarianPTLN(),
                            ),
                          ));
                    },
                    Image.asset(
                      "assets/ijazahln/ijazahLN_menu_logo_3.png",
                      width: 24.w,
                      height: 27.w,
                      fit: BoxFit.fill,
                      alignment: Alignment.center,
                    ),
                  ),
                  _bannerFAQ(context)
                ],
              ),
            )),
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
            bottom: -8.w,
            right: 0,
            child: Opacity(
              opacity: 0.75,
              child: Image.asset(
                "assets/ijazahln/ilustrasi_ijazah_LN.png",
                width: 237.w,
                height: 212.h,
                fit: BoxFit.contain,
                alignment: Alignment.centerRight,
              ),
            ),
          ),
          Positioned(
            top: 145.w,
            left: 30.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 81.w,
                  height: 29.w,
                  alignment: Alignment.centerLeft,
                  child: Image.asset("assets/ijazahln/ic_header_ijazahln.png"),
                ),
                Container(
                  margin: EdgeInsets.only(top: 12.h),
                  width: 220.w,
                  child: Text(
                    "Dapatkan kemudahan dalam \nmelacak penyetaraan ijazah \nLuar Negeri Anda",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 14.h),
                  width: 220.w,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PelajariSelengkapnya(),
                        ),
                      );
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            width: 189.w,
                            height: 40.h,
                            padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.r),
                                color: bgPelajariSelengkapnya
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Pelajari Selengkapnya",
                                  style: stylePelajariSelengkapnya,
                                  textAlign: TextAlign.center,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                  size: 14.h,
                                )

                              ],)
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget cardLayanan(
      String title, String subTitle, VoidCallback onTap, Widget centerImage) {
    return InkEffect(
      onTap: onTap,
      boxDecoration: BoxDecoration(
          color: white, borderRadius: BorderRadius.circular(10.r)),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 64.h,
              height: 64.h,
              decoration: BoxDecoration(
                color: Color(0xffF8F9FD),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Center(child: centerImage),
            ),
            SizedBox(
              width: 20.w,
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: blue4,
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    subTitle,
                    style: TextStyle(
                        color: teksAbuCerah4,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                        letterSpacing: 0.5),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _bannerFAQ(BuildContext context){
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return BlocProvider(
                create: (context) => di.locator<FaqmoduleBloc>()
                  ..add(FetchfaqModuleEvent('ijazah-ln')),
                child: FAQModul(),
              );
            },
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 30.h),
        width: 358.w,
        child: Card(
          color: blueLinear1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                      'assets/faq/faq_icon.png'
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.w
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Butuh Informasi lainnya?",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.006.sp,
                        color: white
                      ),
                    ),
                    SizedBox(
                      height: 10.w,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Lihat FAQ",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.006.sp,
                            color: white
                          ),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Icon(
                          Icons.navigate_next,
                          color: white,
                          size: 16,
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
