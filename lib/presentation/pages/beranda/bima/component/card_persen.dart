import 'package:app/presentation/pages/beranda/bima/component/circular_persentase.dart';
import 'package:app/presentation/pages/beranda/bima/detail_usulan_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardPersen extends StatelessWidget {
  final Kategori kategori;
  final String judul;
  final String date;
  final VoidCallback onTap;
  final double persen;

  CardPersen(
      {Key? key,
      required this.kategori,
      required this.judul,
      required this.date,
      required this.onTap,
      required this.persen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle fontkategori;
    final Color bgkategori;
    final String namakategori;
    if (kategori == Kategori.draft) {
      fontkategori = TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: Color.fromRGBO(181, 71, 8, 1),
          fontFamily: "Inter");
      bgkategori = Color.fromRGBO(255, 250, 235, 1);
      namakategori = "Draft";
    } else if (kategori == Kategori.disetujui) {
      fontkategori = TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: Color.fromRGBO(2, 122, 72, 1),
          fontFamily: "Inter");
      bgkategori = Color.fromRGBO(236, 253, 243, 1);
      namakategori = "Disetujui";
    } else if (kategori == Kategori.ditolak) {
      fontkategori = TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: Color.fromRGBO(180, 35, 24, 1),
          fontFamily: "Inter");
      bgkategori = Color.fromRGBO(254, 243, 242, 1);
      namakategori = "Ditolak";
    } else if (kategori == Kategori.submitted) {
      fontkategori = TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: Color.fromRGBO(2, 106, 162, 1),
          fontFamily: "Inter");
      bgkategori = Color.fromRGBO(240, 249, 255, 1);
      namakategori = "Submitted";
    } else {
      fontkategori = TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
          fontFamily: "Inter");
      bgkategori = Colors.grey;
      namakategori = "Pilihdulu";
    }
    return Wrap(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              boxShadow: [
                BoxShadow(
                  color: Color(0x1A5C5E61),
                  spreadRadius: -4,
                  blurRadius: 16,
                  offset: Offset(0, 12), // changes position of shadow
                ),
              ]),
          padding: EdgeInsets.all(20.w),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 2.w),
                        decoration: BoxDecoration(
                            color: bgkategori,
                            borderRadius: BorderRadius.circular(16.r)),
                        child: Text(
                          namakategori,
                          style: fontkategori,
                        )),
                    SizedBox(
                      height: 4.w,
                    ),
                    Text(
                      judul,
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(29, 30, 37, 1),
                          fontFamily: "Plus Jakarta Sans"),
                    ),
                    SizedBox(
                      height: 10.w,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.date_range,
                          color: Color.fromRGBO(128, 128, 128, 1),
                          size: 14,
                        ),
                        Text(
                          " Diusulkan" + date,
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(128, 128, 128, 1),
                              fontFamily: "Plus Jakarta Sans"),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 17.w,
                    ),
                    GestureDetector(
                      onTap: onTap,
                      child: Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailUsulanPage(),
                                ),
                              );
                            },
                            child: Text(
                              "Lihat detail ",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(36, 141, 218, 1),
                                  fontFamily: "Plus Jakarta Sans"),
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: Color.fromRGBO(36, 141, 218, 1),
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 40.w),
              // Text("data"),
              CircularPersentase(persen: persen)
            ],
          ),
        ),
      ],
    );
  }
}

enum Kategori { draft, submitted, disetujui, ditolak }
