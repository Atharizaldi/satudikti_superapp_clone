import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/inkEffect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardBerita extends StatelessWidget {
  final double leftMargin, rightMargin;
  final String image, tanggalBerita, judulBerita;
  final VoidCallback function;
  const CardBerita(
      {Key? key,
      required this.leftMargin,
      required this.rightMargin,
      required this.image,
      required this.tanggalBerita,
      required this.judulBerita,
      required this.function})
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
                    image: DecorationImage(
                      image: AssetImage('assets/default-con/berita.png'),
                      fit: BoxFit.cover,
                    )),
                child: this.image == 'assets/default-con/berita.png'
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(4.r),
                        child: Image.asset(
                          'assets/default-con/berita.png',
                          fit: BoxFit.cover,
                          height: 160.h,
                          width: double.infinity,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(4.r),
                        child: Image.network(
                          this.image,
                          fit: BoxFit.cover,
                          height: 160.h,
                          width: double.infinity,
                        ),
                      ),
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Text(
              this.judulBerita,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                  fontSize: 14.sp, color: blue2, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 4.h,
            ),
            Text(
              this.tanggalBerita,
              style: TextStyle(
                  fontSize: 10.sp,
                  color: neutralCaption,
                  fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  }
}
