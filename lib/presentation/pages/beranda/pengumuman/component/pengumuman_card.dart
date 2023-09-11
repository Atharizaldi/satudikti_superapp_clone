import 'package:app/common/dateFormat.dart';
import 'package:app/data/source/remote/model/pengumuman/pengumumanList.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/beritaDanPengumumanDetail/beritaDanPengumumanSubPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truncate/truncate.dart';

import 'bannerImageList.dart';

class PengumumanCard extends StatefulWidget {
  final Data pengumuman;
  final String category;

  const PengumumanCard(
      {Key? key, required this.pengumuman, required this.category})
      : super(key: key);

  @override
  State<PengumumanCard> createState() => _PengumumanCardState();
}

class _PengumumanCardState extends State<PengumumanCard> {
  @override
  Widget build(BuildContext context) {
    FormatDate formatDate = new FormatDate();

    String categoryWord = "Umum";
    if (widget.category == "23") {
      categoryWord = "Summber Daya";
    } else if (widget.category == "20") {
      categoryWord = "Kelembagaan";
    } else if (widget.category == "5") {
      categoryWord = "Pembelajaran dan Kemahasiswaan";
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BeritaDanPengumumanSubPage(
                category: categoryWord,
                id: widget.pengumuman.id,
              ),
            ));
      },
      child: Container(
        width: double.infinity,
        height: 105.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            image(),
            SizedBox(
              width: 16.w,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _tag(categoryWord),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    widget.pengumuman.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: blue2,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                    maxLines: 2,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Container(
                    child: Text(
                      "${formatDate.formatDate(widget.pengumuman.publisherDate.toString())}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(fontSize: 11.sp, color: neutral40),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget image() {
    return Container(
        width: 130.h,
        height: 84.h,
        decoration: BoxDecoration(
          color: Color(0xffE7F4FD),
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: bannerImageListPengumuman(
          widget.category,
          widget.pengumuman,
        ));
  }

  Widget _tag(String kategori) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: blue6,
      ),
      child: Text(
        truncate(kategori.toUpperCase(), 24),
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w200,
          letterSpacing: -0.02.sp,
          color: blue2,
        ),
      ),
    );
  }
}
