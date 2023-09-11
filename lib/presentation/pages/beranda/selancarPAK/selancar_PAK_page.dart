import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/cardWithImage.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customSliverBar.dart';
import 'package:app/presentation/component/pop_up_alert/show_pop_up_alert.dart';
import 'package:app/presentation/pages/beranda/selancarPAK/component/header_PAK.dart';
import 'package:app/presentation/pages/beranda/selancarPAK/component/informasi_mutakhir_PAK.dart';
import 'package:app/presentation/pages/faq/bloc/faq_module/faqmodule_bloc.dart';
import 'package:app/presentation/pages/faq/faq_page_per_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelancarPAKPage extends StatelessWidget {
  const SelancarPAKPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration(microseconds: 500),
      () => showPopUpAlert(context, 'Selancar PAK'),
    );

    return Container(
      decoration: BoxDecoration(gradient: sliverBgGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomSliverBar(
          appBarTitle: 'Selancar PAK',
          appBarActions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return BlocProvider(
                        create: (context) => di.locator<FaqmoduleBloc>()
                          ..add(FetchfaqModuleEvent('pak-dosen')),
                        child: FAQModul(),
                      );
                    },
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: ImageIcon(
                  AssetImage("assets/icons/to_faq_icon.png"),
                ),
              ),
            ),
          ],
          header: headerPAK(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: loginCardWithLogoutPopUp(context, 'Selancar PAK'),
              ),
              SizedBox(height: 48.h),
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w),
                child: Text(
                  "Apa sih Selancar PAK itu?",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: blue3,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              CardWithImage(
                colorCard: Color(0xffDFF7FF),
                colorTextTitle: Color(0xff00ACC3),
                colorTextSubTitle: neutral40,
                textTitle: "Modul Bagi Dosen",
                positionRightImage: 4.w,
                positionBottomImage: 0,
                textSubTitle:
                    "Selancar PAK merupakan modul yang diperuntukkan oleh dosen",
                image: 'assets/selancar/ilustrasi_bagidosen.png',
                imageHeight: 150.h,
                imageWidth: 140.w,
              ),
              SizedBox(height: 8.h),
              CardWithImage(
                positionLeftImage: 22.w,
                positionBottomImage: 14.w,
                positionLeftColumn: 190.w,
                positionTopColumn: 1.w,
                positionBottomColumn: 1.w,
                positionRightColumn: 0.w,
                colorCard: Color(0xffDFFFF0),
                colorTextTitle: Color(0xff00BE82),
                colorTextSubTitle: neutral40,
                textTitle: "Kemudahan Akses",
                textSubTitle:
                    "Dengan login anda akan mendapatkan kemudahan untuk mengakses status pengajuan anda",
                image: 'assets/selancar/ilustrasi_mudahakses.png',
                imageHeight: 134.h,
                imageWidth: 124.w,
              ),
              SizedBox(height: 8.h),
              CardWithImage(
                positionRightImage: 0.w,
                positionBottomImage: 8.w,
                colorCard: Color(0xffFFF9DF),
                colorTextTitle: Color(0xffC3B000),
                colorTextSubTitle: neutral40,
                textTitle: "Melacak Status Pengajuan",
                textSubTitle:
                    "Dosen dapat melihat progress dari status pengajuan jabatan maupun pangkat",
                image: 'assets/selancar/ilustrasi_statuspengajuan.png',
                imageWidth: 125.w,
              ),
              SizedBox(height: 8.h),
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w),
                child: Text(
                  "Informasi Mutakhir Selancar PAK",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: blue3,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              informasiMutakhir(context),
              _bannerFAQ(context),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bannerFAQ(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return BlocProvider(
                create: (context) => di.locator<FaqmoduleBloc>()
                  ..add(FetchfaqModuleEvent('pak-dosen')),
                child: FAQModul(),
              );
            },
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 25.w, horizontal: 15.h),
        width: 358.w,
        child: Card(
          color: blueLinear1,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/faq/faq_icon.png'),
                  ),
                ),
                SizedBox(width: 20.w),
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
                          color: white),
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
                              color: white),
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
}
