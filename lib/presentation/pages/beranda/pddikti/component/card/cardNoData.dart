import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PDDiktiCardNoData extends StatelessWidget {
  // final String category;
  const PDDiktiCardNoData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/ilus_dataNotFound.png',
              width: 322.w,
            ),
            SizedBox(
              height: screenHeight(context) * (1 / 10),
            ),
            Text(
              'Hasil Pencarian Tidak ',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.sp),
            ),
            Text(
              'Silahkan coba cari kata kunci lainnya',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}

Widget noDataProdi() {
  return Center(
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/ilus_dataNotFound.png',
            width: 322.w,
          ),
          SizedBox(
            height: 16.h,
          ),
          Text(
            'Data Tidak Ditemukan',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.sp),
          ),
          Text(
            'Saat ini data program studi yang Anda cari tidak tersedia',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}

Widget noDataDosen() {
  return Center(
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/ilus_dataNotFound.png',
            width: 322.w,
          ),
          SizedBox(
            height: 16.h,
          ),
          Text(
            'Data Tidak Ditemukan',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.sp),
          ),
          Text(
            'Saat ini data dosen yang Anda cari tidak tersedia',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
