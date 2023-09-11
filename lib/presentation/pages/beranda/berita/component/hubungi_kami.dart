import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/inkEffect.dart';
import 'package:app/presentation/pages/hubungiKamiPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget hubungiKami(BuildContext context, {required EdgeInsets edgeInsets}) {
  return Container(
    margin: edgeInsets,
    child: InkEffect(
      boxDecoration: BoxDecoration(
        gradient: berandaHubungiButtonGradient,
        borderRadius: BorderRadius.circular(10.r),
      ),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HubungiKamiPage()));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Container(
          width: 358.w,
          height: 82.w,
          child: Stack(
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/hubungikami_FAQ.png',
                    height: 52.w,
                    width: 52.w,
                  ),
                  SizedBox(width: 20.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Masih memerlukan bantuan?',
                        style: TextStyle(
                          color: white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 4.w),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Hubungi Kami',
                            style: TextStyle(
                              color: white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Icon(
                            Icons.navigate_next,
                            color: white,
                            size: 14.sp,
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
