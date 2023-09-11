import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/pages/showWebsite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PelajariSelengkapnyaPAKPage extends StatelessWidget {
  const PelajariSelengkapnyaPAKPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Selancar PAK'),
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
                'assets/selancar/selancarPAK.png',
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
                    "Selancar PAK atau Sistem Pelacakan Penilaian Angka Kredit adalah layanan berbasis web maupun aplikasi yang dibuat oleh Ditjen Dikti yang digunakan oleh para dosen untuk mengelola dan melakukan pemantauan terhadap angka kredit serta informasi proses kenaikan jabatan dan pangkat. Dosen dengan mudah dapat melakukan pelacakan terkait usulan kenaikan jabatan akademik atau pangkat yang diajukan ke Dikti sehingga dosen dapat mengikuti proses usulannya secara mandiri. Dengan adanya aplikasi dan sistem Selancar PAK ini diharapkan dapat meningkatkan kualitas elemen pendidikan tinggi terutama dosen. Tautan untuk Selancar PAK dapat diakses pada",
                    style: styleKMParagraph,
                  ),
                  InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShowWebsite(
                          title: 'Selancar PAK',
                          link: "https://pak.kemdikbud.go.id/",
                        ),
                      ),
                    ),
                    child: Text(
                      'https://pak.kemdikbud.go.id/',
                      style: styleKMParagraph.copyWith(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.w),
                  _tujuan(),
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
                        title: 'Selancar PAK',
                        link: 'https://pak.kemdikbud.go.id/portalv2/',
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

  Widget _tujuan() {
    List<String> subHeaders = [
      "Melacak Usulan Kenaikan Pangkat\n",
      "Meminimalisir Adanya Ketidakpastian yang Diajukan\n",
      "Memperoleh Informasi Perbaikan\n",
      "Adanya Pemberitahuan ke Aplikasi\n",
      "Fitur FAQ\n",
    ];
    List<String> points = [
      "Selancar PAK akan mempermudah dalam pemantauan dan pelacakan proses usulan kenaikan pangkat dan jabatan yang diajukan.",
      "Status terbaru ditampilkan secara real time, meliputi saat berkas dikumpul ke Perguruan Tinggi hingga terbitnya PAK, sehingga dosen tidak perlu lagi bertanya  tanya terkait perkembangan progress status usulannya.",
      "Sistem dapat menampilkan jika pengusul memiliki perbaikan sehingga perlu adanya tindak lanjut terhadap usulan yang dikumpul. Hal ini akan mempermudah pengusul dalam mempersingkat waktu sehingga dapat segera melakukan perbaikan.",
      "WhatsApp Pengusul Selancar PAK dapat memberi perkembangan proses usulan dengan mengirim notifikasi ke WhatsApp pengusul. Nomor WhatsApp pengusul dapat didaftarkan ke sistem agar memperoleh notifikasinya.",
      "Fitur FAQ atau Frequently Asked Question dapat mempermudah pengusul untuk mencari jawaban atas kebingungan maupun pertanyaan yang sering diajukan dalam proses usulan kenaikan pangkat dan jabatan."
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tujuan",
          style: TextStyle(
              color: neutral100, fontWeight: FontWeight.w700, fontSize: 16.sp),
        ),
        SizedBox(height: 16.sp),
        ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: subHeaders.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, index) {
              // return Text("${index.toString()}. ${points[index]}");
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 15.sp,
                    child: Text(".",
                        style: TextStyle(
                            color: neutral100,
                            fontWeight: FontWeight.w900,
                            fontSize: 20.sp)),
                  ),
                  Flexible(
                      child: Text.rich(TextSpan(
                    children: [
                      TextSpan(
                        text: "${subHeaders[index]}",
                        style: textStyleParagraph.copyWith(
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: "${points[index]}",
                        style: textStyleParagraph,
                      ),
                    ],
                  )))
                ],
              );
            })
      ],
    );
  }
}
