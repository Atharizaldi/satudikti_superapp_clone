import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/pages/showWebsite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PelajariSelengkapnyaPage extends StatelessWidget {
  const PelajariSelengkapnyaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Kampus Merdeka'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 225,
              decoration:
                  BoxDecoration(gradient: pelajariSelengkapnyaBgGradient),
              child: Image.asset(
                'assets/km/kampusmerdeka.png',
                scale: 4.25,
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
                    'Kampus Merdeka merupakan bagian dari kebijakan Merdeka Belajar oleh Kementerian Pendidikan, Kebudayaan, Riset, dan Teknologi Republik Indonesia yang memberikan kesempatan bagi mahasiswa/i untuk mengasah kemampuan sesuai bakat dan minat dengan terjun langsung ke dunia kerja sebagai persiapan karir masa depan. Pembelajaran dalam Kampus Merdeka memberikan tantangan dan kesempatan untuk pengembangan kreativitas, kapasitas, kepribadian, dan kebutuhan mahasiswa, serta mengembangkan kemandirian dalam mencari dan menemukan pengetahuan melalui kenyataan dan dinamika lapangan seperti persyaratan kemampuan, permasalahan riil, interaksi sosial, kolaborasi, manajemen diri, tuntutan kinerja, target dan pencapaian. Kampus Merdeka dapat diakses melalui:',
                    style: styleKMParagraph,
                    textAlign: TextAlign.justify,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShowWebsite(
                          title: 'Kampus Merdeka',
                          link: 'https://kampusmerdeka.kemdikbud.go.id/',
                        ),
                      ),
                    ),
                    child: Text(
                      "https://kampusmerdeka.kemdikbud.go.id/",
                      style: TextStyle(
                          fontSize: 16.sp,
                          height: 1.75.sp,
                          letterSpacing: 0.5.sp,
                          color: blue4),
                      textAlign: TextAlign.justify,
                    ),

                    // InkWell(

                    // onTap: () => Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => ShowWebsite(
                    //       title: 'Kampus Merdeka',
                    //       link: 'https://kampusmerdeka.kemdikbud.go.id/',
                    //     ),
                    //   ),
                    // ),
                  ),
                  SizedBox(height: 16.w),
                  Text(
                    'Tujuan',
                    style:
                        styleKMParagraph.copyWith(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 16.w),
                  Text(
                    'Sistem laman Merdeka Belajar – Kampus Merdeka dikembangkan untuk mempermudah pihak-pihak terkait yang terlibat dalam kegiatan pembelajaran Kampus Merdeka, mulai dari registrasi sampai dengan pelaporan kegiatan dan hasil pembelajaran. Melalui laman ini mahasiswa dapat mendaftar dan mengikuti seleksi berbagai program secara online. Dengan adanya program ini diharapkan dapat meningkatkan kompetensi lulusan, baik softskills maupun hardskills, agar lebih siap dan relevan dengan kebutuhan zaman, menyiapkan lulusan sebagai pemimpin masa depan bangsa yang unggul dan berkepribadian.',
                    style: styleKMParagraph,
                    textAlign: TextAlign.justify,
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
                        title: 'Kampus Merdeka',
                        link: 'https://kampusmerdeka.kemdikbud.go.id/',
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
