import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/cardWithImage.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/pop_up_alert/show_pop_up_alert.dart';
import 'package:app/presentation/pages/beranda/sister/component/informasi_mutakhir_sister.dart';
import 'package:app/presentation/pages/faq/bloc/faq_module/faqmodule_bloc.dart';
import 'package:app/presentation/pages/faq/faq_page_per_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScrolledContent extends StatelessWidget {
  const ScrolledContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: loginCardWithLogoutPopUp(context, 'SISTER'),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.only(left: 16.w, right: 16.w),
            child: Text(
              "Apa sih SISTER itu?",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: blue3,
              ),
            ),
          ),
          SizedBox(height: 15.h),
          CardWithImage(
            colorCard: Color(0xFFF0F9FF),
            colorTextTitle: Color(0xFF248DDA),
            colorTextSubTitle: neutral80,
            textTitle: "Modul Bagi Dosen",
            positionRightImage: 4.w,
            positionBottomImage: 0,
            textSubTitle:
                "SISTER merupakan modul yang diperuntukkan untuk dosen.",
            image: 'assets/sister/modul_bagi_dosen.png',
            imageHeight: 170.h,
            imageWidth: 140.w,
          ),
          SizedBox(height: 8.h),
          CardWithImage(
            positionLeftImage: 10.w,
            positionBottomImage: 8.w,
            positionLeftColumn: 150.w,
            positionTopColumn: 1.w,
            positionBottomColumn: 1.w,
            positionRightColumn: 0.w,
            colorCard: Color(0xffDFFFF0),
            colorTextTitle: Color(0xff00BE82),
            colorTextSubTitle: neutral60,
            textTitle: "Kemudahan Akses",
            textSubTitle:
                "Dengan login, dosen akan mendapatkan kemudahan untuk mengakses data diri di PDDikti.",
            image: 'assets/sister/kemudahan_akses.png',
            imageHeight: 155.h,
            imageWidth: 141.w,
          ),
          SizedBox(height: 8.h),
          CardWithImage(
            positionRightImage: 10.w,
            positionBottomImage: 8.w,
            colorCard: Color.fromRGBO(255, 250, 235, 1),
            colorTextTitle: Color.fromRGBO(233, 172, 29, 1),
            colorTextSubTitle: neutral60,
            textTitle: 'Melacak Status Penilaian BKD',
            textSubTitle:
                "Dosen dapat melihat progress dari status penilaian yang diberikan oleh asesor BKD.",
            image: 'assets/sister/lacak_status_bkd.png',
            imageWidth: 135.w,
            imageHeight: 126.h,
          ),
          SizedBox(height: 30.h),
          Padding(
            padding: EdgeInsets.only(left: 16.w, right: 16.w),
            child: Text(
              "Informasi Mutakhir SISTER",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: blue3,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          informasiMutakhirSister(context),
          _bannerFAQ(context),
          SizedBox(height: 20.h),
        ],
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
                  ..add(FetchfaqModuleEvent('sister')),
                child: FAQModul(),
              );
            },
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 25.w, horizontal: 25.h),
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
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 50.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          // borderRadius: BorderRadius.circular(25.r)
                          shape: BoxShape.circle
                          ),
                    ),
                    Image.asset(
                      'assets/faq/sister_lihat_faq.png',
                      width: 34.w,
                      height: 41.h,
                      scale: 2.0,
                    ),
                  ],
                ),
                SizedBox(width: 15.w),
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
