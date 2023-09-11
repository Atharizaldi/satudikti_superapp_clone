import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/pages/showWebsite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PelajariSelengkapnyaPDDikti extends StatelessWidget {
  PelajariSelengkapnyaPDDikti({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'PDDikti'),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 225.sp,
              decoration:
                  BoxDecoration(gradient: pelajariSelengkapnyaBgGradient),
              child: Center(
                  child: Image.asset(
                'assets/pddikti/logo_pddikti_rev.png',
                width: 246.sp,
                height: 76.sp,
              )),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: 30.sp,
                left: 16.w,
                right: 16.w,
                bottom: 60.sp,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text:
                              'Pangkalan Data Perguruan Tinggi atau yang biasa dikenal sebagai PDDikti merupakan layanan yang dikelola oleh Direktorat Jenderal Pendidikan Tinggi, Kementerian Pendidikan dan Kebudayaan Republik Indonesia. PDDikti berfungsi untuk melayani seluruh stakeholder perguruan tinggi yang terintegrasi dengan PDDikti sehingga mendapatkan rujukan informasi perguruan tinggi. Pengelolaan data di perguruan tinggi membutuhkan proses penyusunan dan pengaturan informasi yang sistematis. Tiap perguruan tinggi semestinya telah memiliki pangkalan data masing-masing. Data yang tercantum dalam PDDIKTI merupakan kumpulan data penyelenggaraan Pendidikan Tinggi seluruh Perguruan Tinggi yang terintegrasi secara nasional. Pangkalan data ini menjadi salah satu instrumen pelaksanaan penjaminan mutu. Tautan layanan PDDikti dapat diakses pada ',
                          style: textStyleParagraph,
                        ),
                        WidgetSpan(
                          child: InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShowWebsite(
                                  title: 'PDDikti',
                                  link: 'https://pddikti.kemdikbud.go.id/',
                                ),
                              ),
                            ),
                            child: Text(
                              "https://pddikti.kemdikbud.go.id/ ",
                              style: textStyleParagraph.copyWith(color: blue4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.sp),
                  Text(
                    'Tujuan',
                    style: textStyleParagraph.copyWith(
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 16.sp),
                  Text(
                    'PDDikti memberikan kemudahan sebagai rujukan informasi Perguruan Tinggi dan memberikan kemudahan bagi para pengguna yang ingin mengakses informasi data seputar Perguruan Tinggi serta civitas akademika dimanapun dan kapanpun.\n\nDalam pasal 56 ayat 2 UU No. 12 Tahun 2012 tentang Pendidikan Tinggi menyebutkan bahwa Pangkalan Data Pendidikan Tinggi, sebagaimana dimaksud pada ayat (1) berfungsi sebagai sumber informasi bagi: Lembaga akreditasi, untuk melakukan akreditasi Program Studi dan Perguruan Tinggi.\nPemerintah, untuk melakukan pengaturan, perencanaan, pengawasan, pemantauan, dan evaluasi serta pembinaan dan koordinasi Program Studi dan Perguruan Tinggi.\nMasyarakat, untuk mengetahui kinerja Program Studi dan Perguruan Tinggi.',
                    style: TextStyle(
                      fontSize: 16.sp,
                      height: 1.75.sp,
                      letterSpacing: 0.5.sp,
                      color: abu7,
                      fontFamily: 'Plus Jakarta Sans',
                    ),
                  ),
                ],
              ),
            ),
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
                        title: 'PDDikti',
                        link: "https://pddikti.kemdikbud.go.id",
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
}
