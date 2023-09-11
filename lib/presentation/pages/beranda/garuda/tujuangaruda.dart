import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/inkEffect.dart';
import 'package:app/presentation/pages/showWebsite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TujuanGaruda extends StatelessWidget {
  const TujuanGaruda({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Garuda'),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 225.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/garuda/headergaruda.png",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 17.w, right: 16.w),
                    child: Container(
                      width: double.infinity,
                      child: Image.asset(
                        "assets/garuda/logogarudav2.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 32.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 17.w, right: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text:
                              "Garuda (Garba Rujukan Digital) adalah platform sumber informasi publikasi ilmiah di Indonesia yang dikelola oleh Kemenristekdikti. Garuda mencakup semua aspek ilmu pengetahuan seperti seni, humaniora,ilmu perilaku, ilmu sosial, fisika, teknik, matematika & computer, kimia & biologi, dan lain sebagainya. Hal yang melatar belakangi pembuatan platform ini yakni, pemanfaatan informasi ilmiah di Indonesia belum optimal karena letak sumber informasi dan lokasi pengelola tersebar luas dimana-mana, dan belum ada kesepakatan dalam pengelolaan informasi di Indonesia, terutama informasi dalam format digital yang berakibat sulitnya aksesibilitas informasi. Diharapkan Garuda dapat menjadi acuan pertama dan utama untuk akses informasi ilmiah demi pengembangan ilmu dan kemajuan peradaban bangsa.\n\nUntuk mengakses platform Garuda dapat dilakukan dengan: Mengakses link ",
                          style: textStyleParagraph,
                        ),
                        WidgetSpan(
                          child: InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShowWebsite(
                                  title: 'Garuda',
                                  link: 'https://garuda.kemdikbud.go.id/',
                                ),
                              ),
                            ),
                            child: Text(
                              "https://garuda.kemdikbud.go.id/ ",
                              style: textStyleParagraph.copyWith(color: blue4),
                            ),
                          ),
                        ),
                        TextSpan(
                          text:
                              "Masukkan kata kunci Laman akan menampilkan hasil pencarian meliputi Judul, Penulis, Nama Lembaga, dan URL menuju permalink dari masing-masing universitas atau instansi kontributor. Klik Permalink  untuk melihat data lengkap mulai dari data bibliografi, abstrak sampai dengan file fulltext (jika ada) dari beberapa Perguruan Tinggi dan Lembaga di Indonesia, misalnya IPB, PDII-LIPI dan sebagainya",
                          style: textStyleParagraph,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 17.w, right: 16.w),
              child: Text(
                "Tujuan",
                style: TextStyle(
                    height: 1.75.sp,
                    color: abu7,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5.sp),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 17.w, right: 16.w),
              child: Text(
                "Platform Garuda dibangun dengan tujuan untuk mengelola informasi berbagai bidang keilmuan seperti teknologi, seni, ilmu sosial, dan lain sebagainya dalam bentuk digital sehingga dapat mempermudah akses informasi ilmiah, membangun jaringan perpustakaan digital, membangung jaringan resource sharing, serta upaya untuk digitalisasi kekayaan lokal (local content) khususnya perguruan tinggi di Indonesia.",
                style: TextStyle(
                  fontSize: 16.sp,
                  height: 1.75.sp,
                  letterSpacing: 0.5.sp,
                  color: abu7,
                  fontFamily: 'Plus Jakarta Sans',
                ),
              ),
            ),
            SizedBox(
              height: 30.h,
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
                        title: 'Garuda',
                        link: 'https://garuda.kemdikbud.go.id/',
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
