import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/showWebsite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PelajariSelengkapnyaSivilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'SIVIL',
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
                    "assets/sivil/header_pelajariselengkapnya.png",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 86.w, right: 109.w),
                    child: Container(
                      width: double.infinity,
                      child: Image.asset(
                        "assets/sivil/icon_pelajariselengkapnya.png",
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
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                "Ijazah adalah surat tanda tamat belajar yang berisi nilai, prestasi seseorang yang terkait selama menempuh pendidikan. Pemerintah semakin memudahkan masyarakat untuk mengetahui keaslian ijazah dengan cara mengecek langsung di situs dikti. Untuk meminimalisir terjadinya pemalsuan ijazah dan demi meningkatkan pelayanan kepada masyarakat. Kementerian Riset, Teknologi, dan Pendidikan Tinggi (Kemristekdikti) meluncurkan Sistem Verifikasi Ijazah Secara Online (SIVIL). SIVIL merupakan sistem verifikasi ijazah online yang terintegrasi dengan Pangkalan Data Pendidikan Tinggi (PDDikti), sehingga keabsahan seorang lulusan akan diverifikasi konsistensinya dengan riwayat proses pendidikan di perguruan tinggi dan pemenuhan atas standar nasional pendidikan tinggi. Pendataan PDDikti secara resmi dilakukan mulai pada tahun 2002/2003, bagi lulusan dibawah tahun tersebut apabila tidak ditemukan di SIVIL dapat menghubungi Perguruan Tinggi terkait. SIVIL dapat diakses melalui url",
                style: textStyleParagraph,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShowWebsite(
                      title: 'SIVIL',
                      link: 'https://ijazah.kemdikbud.go.id/.',
                    ),
                  ),
                ),
                child: Text(
                  'https://ijazah.kemdikbud.go.id/.',
                  style: textStyleParagraph.copyWith(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                "Tujuan",
                style: TextStyle(
                  color: abu7,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                "Laman SIVIL (Sistem Verifikasi Ijazah secara Elektronik) yang dapat diakses secara langsung oleh masyarakat ini adalah dapat digunakan untuk memastikan keabsahan ijazah dengan cara memasukkan nomor yang terdapat pada ijazah  yang dapat diverifikasi melalui SIVIL.",
                style: textStyleParagraph,
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
                        title: 'SIVIL',
                        link: 'https://ijazah.kemdikbud.go.id/',
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
