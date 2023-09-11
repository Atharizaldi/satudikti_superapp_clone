import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/pages/showWebsite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PelajariSelengkapnyaBeasiswa extends StatelessWidget {
  PelajariSelengkapnyaBeasiswa({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Beasiswa'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 225.w,
              decoration:
                  BoxDecoration(gradient: pelajariSelengkapnyaBgGradient),
              child: Center(
                  child: Image.asset(
                'assets/beasiswa/beasiswa_horizontal.png',
                width: 239.w,
                height: 77.w,
              )),
            ),
            Container(
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
                    'Beasiswa merupakan suatu penghargaan yang diberikan kepada individu untuk melanjutkan pendidikan ke jenjang yang lebih tinggi. Penghargaan itu dapat berupa akses tertentu pada suatu instansi atau bantuan keuangan. Beasiswa tentunya menjadi incaran seluruh sivitas akademika. Untuk itu, satudikti hadir untuk memfasilitasi pemberian informasi mengenai beasiswa khususnya beasiswa yang diselenggarakan oleh lingkungan Kementerian Pendidikan dan Kebudayaan (Kemdikbud). Beasiswa yang diselenggarakan diantaranya Program Pendidikan Magister menuju Doktor untuk Sarjana Unggul (PMDSU), Beasiswa Pendidikan Pascasarjana Dalam Negeri (BPPDN), dan Beasiswa Pendidikan Pascasarjana Luar Negeri (BPPLN).',
                    style: textStyleParagraph,
                  ),
                  SizedBox(height: 16.w),
                  Text(
                    'Tujuan',
                    style: textStyleParagraph.copyWith(
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 16.w),
                  Text(
                    'Laman beasiswa ini bertujuan mempermudah akses pencarian informasi beasiswa yang diselenggarakan oleh Kementerian Pendidikan dan Kebudayaan (Kemdikbud) sehingga dapat meningkatkan kemampuan dan kompetensi sumber daya manusia Indonesia yang mendukung percepatan pembangunan Negara Kesatuan Republik Indonesia.',
                    style: textStyleParagraph,
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
                        title: "Beasiswa",
                        link: 'https://beasiswa.kemdikbud.go.id/',
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
