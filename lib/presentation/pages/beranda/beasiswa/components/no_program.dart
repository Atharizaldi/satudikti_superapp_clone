import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget noProgram(bool isSedangDibuka) {
  return Column(
    children: [
      ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 28.w),
            child: Column(
              children: [
                Image.asset(
                  'assets/km/tutup.png',
                  width: 190.w,
                  height: 122.h,
                ),
                SizedBox(height: 32.w),
                isSedangDibuka
                    ? RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            color: neutral40,
                            fontSize: 10.sp,
                          ),
                          children: [
                            TextSpan(
                              text: 'Belum ada',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text:
                                  ' program beasiswa dibuka, silahkan lihat\nprogram yang ',
                            ),
                            TextSpan(
                              text: 'sudah ditutup',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text:
                                  ' untuk melihat daftar beasiswa\nyang terdaftar',
                            ),
                          ],
                        ),
                      )
                    : RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            color: neutral40,
                            fontSize: 10.sp,
                          ),
                          children: [
                            TextSpan(
                              text: 'Semua ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: 'program '),
                            TextSpan(
                              text: 'sedang dibuka ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                                text:
                                    'silahkan lihat program yang dibuka untuk melihat seluruh  daftar beasiswa')
                          ],
                        ),
                      )
              ],
            ),
          ),
        ],
      ),
      SizedBox(height: 60.w),
    ],
  );
}
