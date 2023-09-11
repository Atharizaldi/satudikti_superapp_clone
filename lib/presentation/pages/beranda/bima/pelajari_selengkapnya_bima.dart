import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/pages/showWebsite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PelajariSelengkapnyaBimaPage extends StatelessWidget {
  const PelajariSelengkapnyaBimaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBgPage,
      appBar: CustomAppBar(title: 'BIMA'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 225.h,
              decoration:
                  BoxDecoration(gradient: gmagzPelajariSelengkapnyaBgGradient),
              child: Image.asset(
                'assets/bima/logo_banner_bima.png',
                scale: 3,
              ),
            ),
            _description(context)
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
                        title: 'BIMA',
                        link: 'https://bima.kemdikbud.go.id',
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

  Widget _description(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        top: 20.h,
        left: 16.w,
        right: 16.w,
        bottom: 50.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'BIMA (Basis Informasi Penelitian dan Pengabdian kepada Masyarakat) merupakan sebuah layanan untuk mengajukan usulan penelitian maupun pengabdian, hingga melaporkan kegiatan yang bisa dilakukan secara online melalui website. BIMA bertujuan untuk mengelola program penelitian dan pengabdian, serta proses pemberian hibah kepada masyarakat di perguruan tinggi di bawah Direktorat Jenderal Pendidikan Tinggi, Riset, dan Teknologi. BIMA dikembangkan untuk menggantikan layanan SIMLITABMAS yang sebelumnya diluncurkan oleh Ditjen Dikti. \n\nLahirnya suatu karya penelitian secara tidak langsung akan berpengaruh terhadap kemampuan berpikir dan menulis bagi para pembacanya sekaligus menjadi solusi atas permasalahan yang timbul di masyarakat, daerah, nasional hingga global. Selain itu, pengabdian terhadap masyarakat juga menjadi hal yang penting dalam dunia pendidikan tinggi. Hal tersebut memiliki pengaruh dan manfaat yang besar terhadap tingkat kepedulian pada lingkungan sosial.',
            style: TextStyle(
              color: neutral70,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.9.sp,
              height: 1.5.sp,
              fontSize: 16.sp
            ),
            textAlign: TextAlign.justify
          ),
          SizedBox(height: 16.h),
          Text(
            'Tujuan',
            style: styleKMParagraph.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 8.h),
          _tujuan()
        ],
      ),
    );
  }

  Widget _tujuan() {
    List<String> points = [
      "Mendukung penuh program penelitian dan pengabdian",
      "Berkontribusi dalam peningkatan kualitas maupun kuantitas karya ilmiah",
      "Pendorong lahirnya hasil penelitian yang inovatif dan unggul",
      "Melindungi karya para peneliti/penulis",
      "Meningkatkan minat penelitian dan pengabdian terhadap masyarakat"
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: points.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 13.sp,
                  child: Image.asset('assets/sister/icon_check.png'),
                  margin: EdgeInsets.fromLTRB(0, 15, 10, 15),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${points[index]}",
                      style: TextStyle(
                        fontSize: 15.sp,
                        height: 1.sp,
                        letterSpacing: -0.5.sp,
                        fontWeight: FontWeight.w500,
                        color: neutral80,
                      ),
                      textAlign: TextAlign.justify
                    ),
                  ),
                )
              ],
            );
          },
        )
      ],
    );
  }
}