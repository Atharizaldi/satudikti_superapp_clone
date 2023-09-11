import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/bima/component/card_profile.dart';
import 'package:app/presentation/pages/faq/faq_page_per_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../faq/bloc/faq_module/faqmodule_bloc.dart';
import 'component/bima_tabbar.dart';
import 'component/card_Download.dart';
import 'component/expansion_statistik_profil.dart';
import 'daftar_pengumuman/daftar_pengumuman_bima.dart';

class ProfileScrolledContent extends StatefulWidget {
  const ProfileScrolledContent({Key? key}) : super(key: key);

  @override
  State<ProfileScrolledContent> createState() => _ProfileScrolledContentState();
}

class _ProfileScrolledContentState extends State<ProfileScrolledContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: whiteBgPage,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Profil Saya',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: blue3,
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              CardProfileBIMA(
                namaUser: 'Prof. Susi Sanusi, M.Pd., Ph.D',
                namaKampus:
                    'Institut Keuangan-Perbankan dan Informatika Asia Perbanas',
                nidn: 1122077201,
                imageURL:
                    'https://i.pinimg.com/280x280_RS/e4/de/1f/e4de1f7d3225ae69e9e8d7134e0df2a0.jpg',
              ),
              SizedBox(
                height: 12.h,
              ),
              Divider(
                thickness: 1,
              ),
              ExpansionCardStatistic(),
              Divider(
                thickness: 1,
              ),
              SizedBox(
                height: 12.h,
              ),
              Text(
                'Status Usulan Terakhir',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: blue3,
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Pengumuman Terbaru',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: blue3,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              //KONTENNYA TABBAR DAN ISINYA
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
              _bannerFAQ(context),
              SizedBox(
                height: 32.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bimaTabBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
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
