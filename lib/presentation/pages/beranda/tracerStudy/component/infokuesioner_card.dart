import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoKuesionerCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 358.w,
      height: 128.h,
      child: Card(
        color: Color(0xFFFAE2C7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 13, right: 9, top: 12),
              alignment: Alignment.topCenter,
              child: Icon(
                Icons.info,
                size: 20.w,
                color: Color(0xFFAE5700),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 10, right: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Text(
                          'Silahkan masukan data diri untuk memvalidasi partisipasi Anda dalam pengisian kuesioner.',
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            color: Color(0xFFAE5700),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    Text(
                          'Kuesioner ini hanya dapat diisi oleh mahasiswa yang telah dinyatakan lulus dari perguruan tinggi masing-masing.',
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            color: Color(0xFFAE5700),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}