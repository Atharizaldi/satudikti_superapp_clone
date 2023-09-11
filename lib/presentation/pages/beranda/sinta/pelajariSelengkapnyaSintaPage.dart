import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/pages/showWebsite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PelajariSelengkapnyaSintaPage extends StatelessWidget {
  const PelajariSelengkapnyaSintaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBgPage,
      appBar: CustomAppBar(title: 'Sinta'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 225.h,
              decoration:
                  BoxDecoration(gradient: pelajariSelengkapnyaBgGradient),
              child: Image.asset(
                'assets/sinta/logo_banner.png',
                width: 129.w,
                height: 75.h,
              ),
            ),
            _desc(context)
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: white, boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            blurRadius: 25,
            spreadRadius: 0,
            offset: Offset(0, 6),
          )
        ]),
        child: Container(
          height: 100.h,
          padding: EdgeInsets.fromLTRB(16, 16, 16, 28),
          child: Center(
            child: Material(
              child: Ink(
                width: 358.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: Color(0xffE5F4FF),
                  // border: Border.all(color: blue4),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShowWebsite(
                        title: 'Sinta',
                        link: 'https://sinta.kemdikbud.go.id/',
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Kunjungi Website',
                      style: TextStyle(
                        color: blue4,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _desc(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        top: 30.w,
        left: 16.w,
        right: 16.w,
        bottom: 60.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SINTA adalah penelitian berbasis web yang dibangun untuk mengukur kinerja peneliti, institusi, dan jurnal ilmiah yang ada di Indonesia. Sistem informasi penelitian berbasis web yang menawarkan akses cepat, mudah, dan komprehensif untuk mengukur kinerja peneliti, institusi dan jurnal di Indonesia. SINTA memberikan benchmark dan analisis, identifikasi kekuatan penelitian masing-masing institusi untuk mengembangkan kemitraan kolaboratif, hingga menganalisis tren penelitian dan direktori pakar. SINTA dikelola oleh Ristekdikti. Jurnal yang terindex SINTA merupakan jurnal yang sudah terakreditasi oleh sistem akreditasi ARJUNA (Akreditasi Jurnal Nasional). SINTA dari jurnal Indonesia memiliki google scholar dan preview Scopus yang memuat beberapa kutipan, i-10 index, h-index, perkembangan terkait prosiding paper, bukum dan paten peneliti di Indonesia, serta profil penulis dari google scholar. SINTA secara otomatis dapat mengindeks hasil karya yang telah terindeks di Scopus, Google Scholar, dan InaSTI, IPI. Tautan untuk SINTA dapat diakses pada',
            style: textStyleParagraph,
          ),
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShowWebsite(
                  title: 'Sinta',
                  link: 'https://sinta.kemdikbud.go.id/',
                ),
              ),
            ),
            child: Text(
              'https://sinta.kemdikbud.go.id/.',
              style: textStyleParagraph.copyWith(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          SizedBox(height: 16.w),
          Text(
            'Tujuan',
            style: styleKMParagraph.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 16.w),
          Text(
            "Menilai kinerja jurnal berdasarkan standar akreditasi dan sitasi dengan mengindeks seluruh jurnal nasional yang sudah terakreditasi oleh ARJUNA.Memberikan tolak ukur analis, identifikasi kekuatan riset masing - masing institusi, dan melakukan analisis direktori pakar dan tren riset.Sebagai wadah hasil penelitian yang dipublikasikan secara daring sehingga diharapkan dapat memberikan kontribusi kepada peneliti dan dosen dalam menambah jurnal dan karya ilmiah.",
            style: textStyleParagraph,
          ),
        ],
      ),
    );
  }
}
