import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/showWebsite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TujuanKedaireka extends StatelessWidget {
  const TujuanKedaireka({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Kedaireka',
          style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 1),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: appBarGradient,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 225.w,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/kedaireka/pelajari_selengkapnya.png",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 22.0, right: 11),
              child: Text(
                  "Kedaireka adalah solusi terkini dalam mewujudkan kemudahan sinergi kontribusi perguruan tinggi dengan komersialisasi industri untuk kemajuan bangsa Indonesia, yang sejalan dengan visi Kampus Merdeka Kemendikbud RI.",
                  style: textStyleParagraph),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 22.0, right: 11),
              child: Text(
                "Tujuan",
                style: TextStyle(
                    height: 1.75.sp,
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
                "Kedaireka tercetus dari visi Menteri Pendidikan dan Kebudayaan Republik Indonesia Nadiem Makarim dan Direktur Jenderal Dikti Prof. Ir. Nizam M.Sc, DIC, Ph.D dalam mewujudkan kemudahan sinergi antara perguruan tinggi dan industri dalam satu platform. Komitmen terhadapt Kedaireka turut didukung hadirnya program Matching Fund sebagai insentif bersinergi.\n\nDikti telah mendedikasikan tim baru secara khusus untuk menciptakan dan mengelola platform Kedaireka. Profesionalisme menjadi kata kunci bagi tim pengelola platform Kedaireka karena turut melibatkan para konsultan dengan keahlian kerja yang telah teruji bertahun-tahun dan berasal dari perusahaan multinasional, media, dan juga kalangan akademisi.",
                style: textStyleParagraph,
              ),
            ),
            SizedBox(
              height: 70.h,
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
                        title: 'Kedaireka',
                        link: 'https://kedaireka.id/',
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
