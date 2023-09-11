import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/gradientText.dart';
import 'package:app/presentation/pages/showWebsite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PelajariSelengkapnya extends StatelessWidget {
  const PelajariSelengkapnya({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Ijazah LN'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 225,
              decoration:
                  BoxDecoration(gradient: pelajariSelengkapnyaBgGradient),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/ijazahln/ijazah_logo_4x.png',
                    width: 42.58.w,
                    height: 44.w,
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  GradientText(
                    "Ijazah LN",
                    style:
                        TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
                    gradient: appBarGradient,
                  )
                ],
              ),
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
                    'Penyetaraan Ijazah Luar Negeri atau LN merupakan layanan dari Dikti Ristek untuk masyarakat Indonesia guna mengecek dan memvalidasi apakah ijazah yang diperoleh dari studi luar negeri setara dengan ijazah yang berlaku di Indonesia. Tautan untuk Ijazah LN dapat diakses pada',
                    style: styleKMParagraph,
                  ),
                  InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShowWebsite(
                          title: "Ijazah LN",
                          link: 'https://ijazahln.kemdikbud.go.id/ijazahln/',
                        ),
                      ),
                    ),
                    child: Text(
                      'https://ijazahln.kemdikbud.go.id/ijazahln/.',
                      style: styleKMParagraph.copyWith(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.w),
                  Text(
                    'Tujuan',
                    style:
                        styleKMParagraph.copyWith(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 16.w),
                  Text(
                    'Layanan ini bertujuan untuk memberikan pengakuan atas kualifikasi ijazah yang diperoleh dari perguruan tinggi di luar negeri dengan kualifikasi ijazah pendidikan tinggi di Indonesia dengan mengacu pada Kerangka Kualifikasi Nasional Indonesia (KKNI). Selain itu, layanan ini juga menyetarakan Indeks Prestasi Kumulatif (IPK) dari perguruan tinggi di luar negeri sesuai dengan Standar Nasional Pendidikan Tinggi di Indonesia.\n\nTujuan lainnya :\nWNI yang ingin menyetarakan kepemilikan ijazah luar negeri ke Indonesia (keperluan pendidikan dan pekerjaan).\nWNA yang ingin menyetarakan kepemilikan ijazah luar negeri ke Indonesia (keperluan pendidikan dan pekerjaan).\nWNI yang ingin menyetarakan kepemilikan nilai IPK luar negeri ke Indonesia (keperluan pendidikan dan pekerjaan).',
                    style: styleKMParagraph,
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
                        title: "Ijazah LN",
                        link: 'https://ijazahln.kemdikbud.go.id/ijazahln/',
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
