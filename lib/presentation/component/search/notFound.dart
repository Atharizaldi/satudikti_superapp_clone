import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotFound extends StatelessWidget {
  const NotFound({ Key? key }) : super(key: key);

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
              height: 16.h
            ),
            Text(
              'Hasil Pencarian Tidak Ditemukan',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16.sp
              ),
            ),
            Text(
              'Silahkan coba cari kata kunci lainnya',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400
              ),
            ),
          ],
        ),
      ),
    );
  }
}