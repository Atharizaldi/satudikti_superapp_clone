import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/pages/showWebsite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PelajariSelengkapnyaKD extends StatelessWidget {
  PelajariSelengkapnyaKD({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Kompetensi Dosen'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 225.sp,
              decoration:
                  BoxDecoration(gradient: pelajariSelengkapnyaBgGradient),
              child: Center(
                  child: Image.asset(
                'assets/kompetensiDosen/logo_large_kompetensi_dosen.png',
                width: 134.sp,
                height: 126.sp,
              )),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: 30.sp,
                left: 16.w,
                right: 16.w,
                bottom: 60.sp,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text:
                              'Layanan ini memuat informasi terkait modul penawaran dan pengusulan program sertifikasi yang dapat diikuti oleh dosen dan tenaga pendidik (tendik). Dosen dan tendik dapat melakukan pendaftaran program melalui layanan ini sesuai periode pembukaan program. Layanan ini juga menyediakan panduan. Pada layanan ini mewajibkan pendaftar untuk mengisi persyaratan, data usulan, dan target luaran sesuai dari program yang dipilih. Tautan untuk layanan Kompetensi Sumber Daya dapat diakses pada ',
                          style: textStyleParagraph,
                        ),
                        WidgetSpan(
                          child: InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShowWebsite(
                                  title: 'Kompetensi Dosen',
                                  link:
                                      "https://kompetensi-ditdaya.kemdikbud.go.id/",
                                ),
                              ),
                            ),
                            child: Text(
                              "https://kompetensi-ditdaya.kemdikbud.go.id/\n",
                              style: textStyleParagraph.copyWith(color: blue4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _persyaratan(),
                  SizedBox(height: 16.sp),
                  Text(
                    'Tujuan',
                    style: textStyleParagraph.copyWith(
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 16.sp),
                  Text(
                    'Tujuan utama dari layanan ini adalah sebagai wadah untuk penawaran program kepada dosen dan tendik berupa training, lomba, maupun magang. Program ini juga memiliki sertifikasi. Layanan ini diharapkan dapat meningkatkan kompetensi serta meningkatkan kualitas pendidikan bagi dosen dan tendik.',
                    style: textStyleParagraph,
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
                        title: 'Kompetensi Dosen',
                        link:
                            "https://kompetensi.sumberdaya.ristekdikti.go.id/",
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

  Widget _persyaratan() {
    List<String> subHeaders = [
      "Program Sertifikasi Kompetensi Teknis Dosen dan Tenaga Kependidikan\n",
      "Program Kemitraan Dosen LPTK\n",
      "Program World Class Professor\n",
      "Program Detasering\n",
      "Magang Dosen ke Perguruan Tinggi\n",
      "Program Magang Dosen ke Industri\n",
    ];
    List<String> points = [
      "Program yang diberikan untuk meningkatkan kompetensi teknis Dosen dan Tenaga Kependidikan dalam menghadapi persaingan pasar kerja global melalui sertifikasi kompetensi. Sertifikasi kompetensi merupakan pengakuan bahwa Dosen dan Tendik mempunyai keterampilan dan kemampuan yang mumpuni sesuai standar kerja yang ditetapkan, serta menunjukan bukti pengakuan tertulis atas kompetensi yang dikuasai.",
      "Program pengiriman dosen LPTK ke sekolah untuk melakukan kegiatan dengan guru dalam pengembangan sistem pendidikan calon guru di LPTK.",
      "Program yang memfasilitasi dosen PTDN untuk berinteraksi dengan Institusi dan Professor berkelas dunia dan meningkatkan kinerja (produktivitas riset) akademisi PTDN dan meningkatkan peringkat PT menuju QS WUR 500 terbaik dunia.",
      "Program penugasan dosen Detaser (pakar/ahli) pada Perguruan Tinggi Sasaran (Pertisas) yang membutuhan kepakaran dan keahlian seorang Detaser untuk melakukan pendampingan dan peningkatan mutu Tridarma dan Tata Kelola di Perguruan Tinggi Sasaran.",
      "Program pembinaan yang dikelola secara terpusat dan merupakan suatu program nasional bertujuan untuk meningkatkan  kemampuan seorang dosen dalam melaksanakan Tridharma Perguruan Tinggi dan untuk mendorong pelaksanaan Merdeka Belajar Kampus Merdeka (MBKM).",
      "Program magang dosen di industri adalah program penugasan dosen bidang ilmu tertentu di suatu Perguruan Tinggi di lingkungan Kementerian Pendidikan dan Kebudayaan untuk melakukan pemagangan bidang ilmu tertentu pada industri yang dipilih dalam jangka waktu tertentu.\n"
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Layanan ini meliputi beberapa program seperti :",
          style: textStyleParagraph,
        ),
        SizedBox(height: 20.sp),
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
                    width: 20.sp,
                    child: Text(
                      "${(index + 1).toString()}.",
                      style: textStyleParagraph,
                    ),
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
