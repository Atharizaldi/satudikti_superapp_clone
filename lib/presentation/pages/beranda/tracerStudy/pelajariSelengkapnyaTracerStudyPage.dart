import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../component/constant.dart';
import '../../../component/customAppBar.dart';
import '../../showWebsite.dart';

class PelajariSelengkapnyaTracerStudyPage extends StatelessWidget {
  const PelajariSelengkapnyaTracerStudyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBgPage,
      appBar: CustomAppBar(title: 'Tracer Study'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 225.h,
              decoration:
                  BoxDecoration(gradient: pelajariSelengkapnyaBgGradient),
              child: Image.asset(
                'assets/tracerStudy/logo_banner.png',
                scale: 4,
              ),
            ),
            _desc(context)
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
                        title: 'Tracer Study',
                        link: 'https://tracerstudy.kemdikbud.go.id/',
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

  Widget _desc(BuildContext context) {
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
            'Tracer Study adalah layanan dapat digunakan oleh Perguruan Tinggi untuk melacak aktivitas para lulusannya setelah masa pendidikan tinggi, baik masa transisi maupun pergerakan mereka di dunia kerja. Tracer study dinilai penting karena menjadi alat evaluasi kinerja PT dan sekarang telah dijadikan salah satu syarat kelengkapan akreditasi oleh Badan Akreditasi Nasional Perguruan Tinggi (BAN-PT), sebagai kelengkapan dalam dokumen Evaluasi Diri yang diperlukan dalam pengajuan proposal melalui Kemdikbud. Tracer Study memberikan informasi statistik mengenai tingkat relevansi alumni terhadap bidang kerja yang didapatkan dan juga persentase lulusan yang telah terserap dalam dunia kerja. Tautan layanan Tracer Study dapat diakses pada',
            style: textStyleParagraph,
          ),
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShowWebsite(
                  title: 'Tracer Study',
                  link: 'https://tracerstudy.kemdikbud.go.id/',
                ),
              ),
            ),
            child: Text(
              'https://tracerstudy.kemdikbud.go.id/',
              style: textStyleParagraph.copyWith(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          SizedBox(height: 16.w),
          Text(
            'Tujuan',
            style: styleKMParagraph.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 16.w),
          _tujuan()
        ],
      ),
    );
  }

  Widget _tujuan() {
    List<String> points = [
      "Outcome pendidikan dalam bentuk transisi dari dunia pendidikan tinggi ke dunia kerja (termasuk masa tunggu kerja dan proses pencarian kerja pertama), situasi kerja terakhir, dan aplikasi kompetensi di dunia kerja.",
      "Output pendidikan yaitu penilaian diri terhadap penguasaan dan pemerolehan kompetensi.",
      "Proses pendidikan berupa evaluasi proses pembelajaran dan kontribusi pendidikan tinggi terhadap pemerolehan kompetensi. Hasil tracer study akan membantu PT dalam mengetahui posisi lulusan yang telah terserap dalam dunia kerja serta menyiapkan lulusan sesuai dengan kompetansi yang diperlukan di dunia kerja. Hasil tracer study yang kemudian dilaporkan ke Dikti akan membantu program Pemerintah dalam rangka memetakan kebutuhan dunia kerja dengan pembangunan pendidikan di Indonesia."
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tracer study online Dikti ditujukan untuk melacak jejak lulusan/alumni yang dilakukan 2 tahun setelah lulus dan bertujuan untuk mengetahui :",
          style: textStyleParagraph,
        ),
        SizedBox(
          height: 20.sp,
        ),
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: points.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: 15.sp,
                    child: Text(
                      ".",
                      style: TextStyle(
                          color: neutral100,
                          fontWeight: FontWeight.w900,
                          fontSize: 20.sp),
                    )),
                Flexible(
                  //     child: Text.rich(TextSpan(children: [
                  //   TextSpan(text: "${points[index]}", style: textStyleParagraph)
                  // ]))
                  child: Text(
                    "${points[index]}",
                    style: textStyleParagraph,
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
