import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/pop_up_alert/show_pop_up_alert.dart';
import 'package:app/presentation/pages/beranda/bima/component/card_Download.dart';
import 'package:app/presentation/pages/beranda/bima/daftar_pengumuman/daftar_pengumuman_bima.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../component/cardWithImage.dart';
import '../../../component/constant.dart';
import '../../faq/bloc/faq_module/faqmodule_bloc.dart';
import '../../faq/faq_page_per_module.dart';
import 'component/bima_tabbar.dart';

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
            child: loginCardWithLogoutPopUp(context, 'BIMA'),
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.w, right: 16.w),
            child: Text(
              'Apa sih BIMA itu?',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: blue3,
              ),
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          CardWithImage(
            colorCard: Color(0xFFF0F9FF),
            colorTextTitle: Color(0xFF248DDA),
            colorTextSubTitle: neutral80,
            textTitle: 'Modul Bagi Dosen',
            positionRightImage: 4.w,
            positionBottomImage: 0,
            textSubTitle: 'BIMA merupakan modul yang disediakan untuk dosen.',
            image: 'assets/bima/state_modu_bagi_dosen.png',
            imageHeight: 160.h,
            imageWidth: 160.w,
          ),
          SizedBox(
            height: 8.h,
          ),
          CardWithImage(
            colorCard: Color(0xffDFFFF0),
            colorTextTitle: Color(0xff00BE82),
            colorTextSubTitle: neutral80,
            textTitle: 'Berfungsi Penuh',
            positionLeftImage: 4.w,
            positionBottomImage: 0,
            positionLeftColumn: 160.w,
            positionTopColumn: 1.w,
            positionBottomColumn: 1.w,
            positionRightColumn: 0.w,
            textSubTitle:
                'Mendukung penuh dalam pembuatan usulan penelitian maupun pengabdian.',
            image: 'assets/bima/state_berfungsi_penuh.png',
            imageHeight: 160.h,
            imageWidth: 160.w,
          ),
          SizedBox(
            height: 8.h,
          ),
          CardWithImage(
            colorCard: Color.fromRGBO(255, 250, 235, 1),
            colorTextTitle: Color.fromRGBO(233, 172, 29, 1),
            colorTextSubTitle: neutral80,
            textTitle: 'Melacak Status Usulan',
            positionRightImage: 4.w,
            positionBottomImage: 0,
            textSubTitle:
                'Dosen dapat melihat progress pengajuan usulan penelitian maupun pengabdian dengan mudah.',
            image: 'assets/bima/state_melacak_status_usulan.png',
            imageHeight: 160.h,
            imageWidth: 160.w,
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
            ),
            child: Text(
              'Pengumuman Terbaru',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: blue3,
              ),
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          _bimaTabBar(context),
          SizedBox(
            height: 12.h,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DaftarPengumumanBima(),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Lihat pengumuman lainnya',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(36, 141, 218, 1),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          _bannerFAQ(context)
        ],
      ),
    );
  }

  Widget _bimaTabBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: BimaTabBar(
          tabview: [
            SingleChildScrollView(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 2,
                // itemCount: widget.listFAQ.data.faq.length,
                itemBuilder: (context, index) {
                  return DownloadWidgetCard(
                    category: 'Diksi',
                    noSurat: '0187/E5.3/HM.01.00/2023',
                    judulDokumen:
                        'Pemberitahuan Hasil Akreditasi Jurnal Ilmiah Periode IV Tahun 2022 (Revisi)',
                    date: '11/11/11',
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 12.h);
                },
              ),
            ),
            SingleChildScrollView(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 3,
                // itemCount: widget.listFAQ.data.faq.length,
                itemBuilder: (context, index) {
                  return DownloadWidgetCard(
                    category: 'Diksi',
                    noSurat: '0187/E5.3/HM.01.00/2023',
                    judulDokumen:
                        'Panduan Penelitian dan Pengabdian Kepada Masyarakat Tahun 2023',
                    date: '11/11/11',
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 12.h);
                },
              ),
            ),
          ],
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
                    radius: 25.r,
                    backgroundImage:
                        AssetImage('assets/faq/sister_lihat_faq.png'),
                    backgroundColor: white,
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
