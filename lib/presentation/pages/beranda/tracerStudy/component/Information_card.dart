import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InformationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360.w,
      height: 68.h,
      child: Card(
        color: Color(0xFFD0E9FB),
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
                  color: Color(0xFF1C5CAD)
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Text(
                    'Terimakasih Telah mengisi Kuesioner',
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      color: Color(0xFF1C5CAD),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Berikut adalah tanggapan yang diterima.',
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      color: Color(0xFF1C5CAD),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
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
}

