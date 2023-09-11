import 'package:app/data/source/remote/model/pengumuman/pengumumanList.dart';
import 'package:app/presentation/pages/beranda/pengumuman/component/kategoriNumber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget bannerImageListPengumuman(String? category, Data? pengumuman) {
  if (pengumuman?.thumbnailImage != null && pengumuman?.thumbnailImage != "") {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.r),
      child: Image.network(
        pengumuman?.thumbnailImage ?? '',
        fit: BoxFit.cover,
      ),
    );
  } else {
    bool kategoriUmum = false;
    bool sumberDaya = false;
    bool kelembagaan = false;
    bool pembelajaranDanMahasiswa = false;
    List<Categories> categories = pengumuman?.categories ?? [];

    if (categories.isEmpty) {
      return Image.asset(
        'assets/default-con/newpengumuman.png',
        fit: BoxFit.cover,
      );
    } else {
      for (int i = 0; i < categories.length; i++) {
        if (categories[i].categoryId.toString() == kategori1) {
          kategoriUmum = true;
        } else if (categories[i].categoryId.toString() == kategori2) {
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
      return Image.asset(
        'assets/ilustrasiPengumuman/sumberdaya.png',
        fit: BoxFit.cover,
      );
    } else if (kelembagaan) {
      return Image.asset(
        'assets/ilustrasiPengumuman/lembaga.png',
        fit: BoxFit.cover,
      );
    } else if (pembelajaranDanMahasiswa) {
      return Image.asset(
        'assets/ilustrasiPengumuman/belmawa.png',
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        'assets/ilustrasiPengumuman/umum.png',
        fit: BoxFit.cover,
      );
    }
  }
}
