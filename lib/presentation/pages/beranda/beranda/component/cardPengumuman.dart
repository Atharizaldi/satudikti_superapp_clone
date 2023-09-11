import 'package:app/data/source/remote/model/pengumuman/pengumumanList.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/inkEffect.dart';
import 'package:app/presentation/pages/beranda/pengumuman/component/bannerImageList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardPengumuman extends StatelessWidget {
  final double leftMargin, rightMargin;
  final VoidCallback function;
  final Data? pengumuman;
  final String tanggalPengumuman, judulPengumuman, kategori;
  final dynamic image;
  const CardPengumuman(
      {Key? key,
      required this.pengumuman,
      required this.leftMargin,
      required this.rightMargin,
      required this.function,
      required this.image,
      required this.tanggalPengumuman,
      required this.judulPengumuman,
      required this.kategori})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkEffect(
      borderRadius: 4.r,
      onTap: function,
      child: Container(
        width: 168.w,
        margin: EdgeInsets.only(left: leftMargin, right: rightMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  color: Color(0xffE7F4FD),
                  image: DecorationImage(fit: BoxFit.cover, image: this.image),
                ),
                child: bannerImageListPengumuman(this.kategori, pengumuman),
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Text(
              this.judulPengumuman,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                  fontSize: 14.sp, color: blue2, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              '${this.tanggalPengumuman} | ${this.kategori}',
              style: TextStyle(
                  fontSize: 10.sp,
                  color: neutral40,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
