import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../component/constant.dart';
import '../../../component/customAppBar.dart';
import '../../showWebsite.dart';


class PelajariSelengkapnyaSisterPage extends StatelessWidget {
  const PelajariSelengkapnyaSisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBgPage,
      appBar: CustomAppBar(title: 'SISTER'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 225.h,
              decoration:
                  BoxDecoration(gradient: pelajariSelengkapnyaBgGradient),
              child: Padding(
                padding: const EdgeInsets.all(80),
                child: Image.asset(
                  'assets/sister/logo_banner_sister.png',
                  scale: 4,
                ),
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
          padding: EdgeInsets.fromLTRB(16, 21, 16, 28),
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
                        title: 'SISTER',
                        link: 'https://sister.kemdikbud.go.id/',
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
        top: 30.w,
        left: 16.w,
        right: 16.w,
        bottom: 60.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SISTER atau Sistem Informasi Sumber Daya Terintegrasi merupakan layanan yang diluncurkan oleh Direktorat Jenderal Pendidikan Tinggi (Ditjen Dikti) yang digunakan sebagai sumber sistem yang berisi data-data para tenaga pendidik di Indonesia. Salah satu data yang ditampilkan pada SISTER adalah BKD (Beban Kerja Dosen). \n\nBKD adalah salah satu layanan di SISTER yang telah digunakan oleh ratusan ribu dosen di Indonesia. Dosen dapat dengan mudah melakukan pelacakan status penilaian BKD yang diberikan oleh asesor. Dengan adanya modul SISTER ini diharapkan dapat mempermudah rencana pengembangan kompetensi dan karir dosen di Indonesia, serta memudahkan dosen dalam mengakses dan mengelola data-datanya. Tautan layanan SISTER dapat diakses pada',
            style: textStyleParagraph.copyWith(fontWeight: FontWeight.w500),
            textAlign: TextAlign.justify
          ),
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShowWebsite(
                  title: 'SISTER',
                  link: 'https://sister.kemdikbud.go.id/',
                ),
              ),
            ),
            child: Text(
              'https://sister.kemdikbud.go.id/',
              style: textStyleParagraph.copyWith(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          SizedBox(height: 16.w),
          Text(
            'Tujuan',
            style: styleKMParagraph.copyWith(fontWeight: FontWeight.w700, fontSize: 24.sp),
          ),
          SizedBox(height: 16.w),
          _tujuan()
        ],
      ),
    );
  }

  Widget _tujuan() {
    List<String> points = [
      "Memudahkan perencanaan pengembangan kompetensi dosen di Indonesia",
      "Membantu pengembangan karir dosen",
      "Memudahkan dosen dalam mengelola data agar lebih terorganisir"
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
                  child: Text(
                    "${points[index]}",
                    style: TextStyle(
                      fontSize: 14.sp,
                      height: 1.5.sp,
                      letterSpacing: 0.5.sp,
                      fontWeight: FontWeight.w500,
                      color: abu7,
                    ),
                    textAlign: TextAlign.justify
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