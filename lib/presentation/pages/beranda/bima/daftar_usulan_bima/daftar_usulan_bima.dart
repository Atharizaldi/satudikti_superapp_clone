import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/pages/beranda/bima/component/bima_tabbar.dart';
import 'package:app/presentation/pages/beranda/bima/component/card_persen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DaftarUsulanBima extends StatefulWidget {
  const DaftarUsulanBima({Key? key}) : super(key: key);

  @override
  State<DaftarUsulanBima> createState() => _DaftarUsulanBimaState();
}

class _DaftarUsulanBimaState extends State<DaftarUsulanBima> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FAFE),
      appBar: CustomAppBar(
        title: "Daftar Ususlan",
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Container(
            child: BimaTabBar(tabview: [
              SingleChildScrollView(
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  // itemCount: widget.listFAQ.data.faq.length,
                  itemBuilder: (context, index) {
                    return CardPersen(
                        kategori: Kategori.disetujui,
                        judul: "Selesai Judul",
                        date: "2020/12/02",
                        onTap: () {},
                        persen: 25);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 12.h);
                  },
                ),
              ),
              SingleChildScrollView(
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  // itemCount: widget.listFAQ.data.faq.length,
                  itemBuilder: (context, index) {
                    return CardPersen(
                        kategori: Kategori.disetujui,
                        judul: "Selesai Judul",
                        date: "2020/12/02",
                        onTap: () {},
                        persen: 25);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 12.h);
                  },
                ),
              ),
            ]),
          )),
    );
  }
}
