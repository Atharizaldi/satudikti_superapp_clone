import 'package:app/presentation/pages/beranda/bima/authors_detail/bima_authors_detail_page.dart';
import 'package:app/presentation/pages/beranda/bima/lihat_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardStatistikDosen extends StatelessWidget {
  const CardStatistikDosen(
      {Key? key,
      required this.imageUrl,
      required this.jumlahData,
      required this.kategoriStatistik})
      : super(key: key);

  final String imageUrl;
  final int jumlahData;
  final String kategoriStatistik;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        width: 172.w,
        height: 118.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Color(0x1A5C5E61),
              spreadRadius: -4,
              blurRadius: 16,
              offset: Offset(0, 12), // changes position of shadow
            ),
            BoxShadow(
              color: Color(0x0D5C5E61),
              spreadRadius: -2,
              blurRadius: 6,
              offset: Offset(0, 4), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      kategoriStatistik,
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(52, 64, 84, 1),
                          fontFamily: 'Plus Jakarta Sans'),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      jumlahData.toString(),
                      style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(52, 64, 84, 1),
                          fontFamily: 'Plus Jakarta Sans'),
                    ),
                  ],
                ),
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(237, 242, 249, 1),
                  ),
                  child: Center(
                    child: Transform.scale(
                      scale: 1.5,
                      child: Image.asset(
                        imageUrl,
                        width: 20.w,
                        height: 20.h,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 12.h,
            ),
            LihatDetail(
              function: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BimaAuthorsDetailPage(),
                    ));
              },
            )
          ],
        ),
      ),
    );
  }
}
