import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/showWebsite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardButuhInfoDetail extends StatelessWidget {
  const CardButuhInfoDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 357.w,
      height: 96.w,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        gradient: berandaHubungiButtonGradient,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowWebsite(
              title: 'Beasiswa',
              link: 'https://beasiswa.kemdikbud.go.id/',
            ),
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              'assets/km/icons/statistik_icon.png',
              height: 64.w,
              width: 64.w,
            ),
            SizedBox(width: 20.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Lihat mengenai statistik Kampus \nMerdeka',
                  style: TextStyle(
                    color: white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    height: 1.5.h,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
