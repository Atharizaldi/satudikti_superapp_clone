import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/pages/showWebsite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PelajariSelengkapnyaGmagzPage extends StatelessWidget {
  const PelajariSelengkapnyaGmagzPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBgPage,
      appBar: CustomAppBar(title: 'G-Magz'),
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
                'assets/gmagz/logo_banner_gmagz.png',
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
                        title: 'G-Magz',
                        link: 'https://gmagz.kemdikbud.go.id',
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
            'G-Magz merupakan majalah elektronik yang diluncurkan oleh Direktorat Jenderal Pendidikan Tinggi (Ditjen Dikti) yang digunakan sebagai sumber sarana informasi terbaru dan terakurat. G-Magz hadir untuk memudahkan pengguna dalam mendapatkan informasi secara fleksibel, khususnya di bidang pendidikan. Selain dalam bentuk aplikasi, G-Magz juga tersedia dalam bentuk website, di mana setiap artikelnya dilengkapi dengan gambar yang sesuai dengan tema.',
            style: TextStyle(
              color: neutral70,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5.sp,
              height: 1.5.sp,
              fontSize: 16.sp
            ),
            textAlign: TextAlign.justify
          ),
          SizedBox(height: 16.h),
          Text(
            'Tujuan',
            style: styleKMParagraph.copyWith(fontWeight: FontWeight.w700, fontSize: 24.sp),
          ),
          SizedBox(height: 8.h),
          _tujuan()
        ],
      ),
    );
  }

  Widget _tujuan() {
    List<String> points = [
      "Menyajikan informasi yang terbaru dalam bentuk majalah",
      "Memudahkan pengguna untuk mendapatkan informasi dimanapun dan kapanpun",
      "Pemanfaatan teknologi secara maksimal"
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
                        fontSize: 14.sp,
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