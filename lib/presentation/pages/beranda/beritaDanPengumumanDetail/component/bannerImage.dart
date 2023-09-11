import 'package:app/data/source/remote/model/berita/newsDetail.dart';
import 'package:app/data/source/remote/model/pengumuman/pengumumanDetail.dart';
import 'package:app/presentation/pages/beranda/pengumuman/component/kategoriNumber.dart';
import 'package:flutter/material.dart';

import '../../../../component/constant.dart';

Widget bannerImage(String? category, NewsDetail? newsDetail,
    PengumumanDetail? pengumumanDetail) {
  if (category == "") {
    if (newsDetail?.thumbnailImage != null &&
        newsDetail?.thumbnailImage != "") {
      return Image.network(
        newsDetail?.thumbnailImage ?? '',
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        'assets/default-con/berita.png',
        fit: BoxFit.cover,
      );
    }
  } else {
    if (pengumumanDetail?.thumbnailImage != null &&
        pengumumanDetail?.thumbnailImage != "") {
      return Image.network(
        pengumumanDetail?.thumbnailImage ?? '',
        fit: BoxFit.cover,
      );
    } else {
      bool sumberDaya = false;
      bool kelembagaan = false;
      bool pembelajaranDanMahasiswa = false;
      List<Categories> categories = pengumumanDetail?.categories ?? [];

      if (categories.isEmpty) {
        return Image.asset(
          'assets/default-con/newpengumuman.png',
          fit: BoxFit.cover,
        );
      } else {
        for (int i = 0; i < categories.length; i++) {
          if (categories[i].categoryId.toString() == kategori2) {
            sumberDaya = true;
          } else if (categories[i].categoryId.toString() == kategori3) {
            kelembagaan = true;
          } else if (categories[i].categoryId.toString() == kategori4) {
            pembelajaranDanMahasiswa = true;
          }
        }
      }
      //umum terakhir karena yg diutamain yg ketiga lainnya dulu
      if (sumberDaya) {
        return imageContainer('assets/ilustrasiPengumuman/sumberdaya.png');
      } else if (kelembagaan) {
        return imageContainer('assets/ilustrasiPengumuman/lembaga.png');
      } else if (pembelajaranDanMahasiswa) {
        return imageContainer('assets/ilustrasiPengumuman/belmawa.png');
      } else {
        return imageContainer('assets/ilustrasiPengumuman/umum.png');
      }
    }
  }
}

Widget imageContainer(String assetRes) {
  return Container(
    decoration: BoxDecoration(gradient: pengumumanDetailLinearGradient),
    child: Image.asset(assetRes, fit: BoxFit.cover),
  );
}
