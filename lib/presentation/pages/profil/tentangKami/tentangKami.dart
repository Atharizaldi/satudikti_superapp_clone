import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/pages/showWebsite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TentangKami extends StatelessWidget {
  TentangKami({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Tentang SatuDikti'),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 225.w,
              decoration: BoxDecoration(gradient: tentangSatuDiktiBgGradient),
              child: Center(
                  child: Image.asset(
                'assets/profil/satudikti_horizontal.png',
                width: 237.w,
                height: 67.w,
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
                    'Akses berbagai layanan unggulan DITJEN DIKTIRISTEK (Direktorat Jenderal Pendidikan Tinggi, Riset dan Teknologi) dalam aplikasi SatuDikti. SatuDikti terintegrasi dengan berbagai layanan meliputi Kampus Merdeka, PDDikti, Kedaireka, Penyetaraan Ijazah LN, SIVIL, Selancar PAK, dan Silemkerma.  Aplikasi ini juga dilengkapi dengan fitur terbaik berupa pencarian, bantuan, berita, hingga pengumuman untuk memenuhi kebutuhan seluruh insan dikti. SatuDikti mengusung misi untuk menyediakan layanan prima pada lingkup pendidikan tinggi. ',
                    style: textStyleParagraph,
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 16.w),
                  Text(
                    'Tujuan',
                    style: textStyleParagraph.copyWith(
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 16.w),
                  Text(
                    'SatuDikti bertujuan untuk memberikan kemudahan kepada insan dikti dalam mengakses berbagai layanan dan informasi tentang pendidikan tinggi. Layanan dan informasi ini dapat diakses dimanapun dan kapanpun melalui ponsel pengguna yang terhubung dengan internet. Adanya fitur notifikasi tentu dapat membantu pengguna untuk mengetahui informasi terkini seputar pendidikan tinggi.',
                    style: textStyleParagraph,
                    textAlign: TextAlign.left,
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
          height: 100.sp,
          child: Center(
            child: Material(
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShowWebsite(
                      title: 'SatuDikti',
                      link: 'https://satudikti.id/',
                    ),
                  ),
                ),
                child: Container(
                  width: 358.w,
                  height: 48.sp,
                  decoration: BoxDecoration(
                    border: Border.all(color: red),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Center(
                    child: Text(
                      'Kunjungi Website',
                      style: TextStyle(
                        color: red,
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
