import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/showWebsite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PelajariSelengkapnyaSiaga extends StatelessWidget {
  const PelajariSelengkapnyaSiaga({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Siaga',
          style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 1),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: appBarGradient,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 225,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/siaga/header_pelajari_selengkapnya.png",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 109.w, right: 109.w),
                    child: Container(
                      width: double.infinity,
                      child: Image.asset(
                        "assets/siaga/logo_siaga.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 22.0, right: 11),
              child: Text(
                "Sistem Informasi Kelembagaan (SIAGA) merupakan one stop service perizinan kelembagaan perguruan tinggi, dimana proses pengusulan sampai keluarnya SK Izin dapat dilayani dalam satu sistem informasi. SIAGA digunakan untuk menggantikan platform Silemkerma yang mulai berlaku pada tahun 2022. Laman portal siaga.kemdikbud.go.id dapat diakses bebas oleh masyarakat dan dapat digunakan untuk melakukan tracing usulan, unduh panduan, atau melihat berita terkini. Badan penyelenggara perguruan tinggi dan perguruan tinggi dapat mendaftarkan akun untuk dapat menggunakan layanan SIAGA lainnya.",
                style: styleKMParagraph,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 22.0, right: 11),
              child: Text(
                "Tujuan",
                style: TextStyle(
                    color: abu7,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 22.0, right: 11),
              child: Text(
                "Adanya platform ini diharapkan dapat mempermudah lembaga pendidikan tinggi untuk mengakses layanan berikut:\nOne stop service perizinan program studi, perubahan PTS, dan pendirian PTS.\nLayanan usul penyaluran bantuan revitalisasi LPTK dan akselerasi penyatuan / penggabungan PTS, dan insentif akreditasi.\nPengajuan izin kerja sama joint program, joint degree, dual degree, atau double degree PT Indonesia dengan PT Luar Negeri.\nAkses laman Beasiswa Pemerintah RI kepada calon mahasiswa internasional dari negara-negara berkembang.\nLayanan izin Mahasiswa Internasional yang akan belajar di Perguruan Tinggi Akademik di Indonesia.\nSistem pelaporan pelanggaran perguruan tinggi yang menyelenggarakan pendidikan tinggi akademik.",
                style: styleKMParagraph,
              ),
            ),
            SizedBox(
              height: 50.h,
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
                        title: 'Siaga',
                        link: 'https://siaga.kemdikbud.go.id/',
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
