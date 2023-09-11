import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DownloadWidgetCard extends StatelessWidget {
  const DownloadWidgetCard(
      {Key? key,
      required this.category,
      required this.noSurat,
      required this.judulDokumen,
      required this.date})
      : super(key: key);

  final String category;
  final String noSurat;
  final String judulDokumen;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          )
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Container(
        width: 358.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    gradient: category == 'Dikti'
                        ? bimaCategoryDikti
                        : bimaCategoryDiksi,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.02),
                        offset: Offset(0, 4),
                        blurRadius: 8,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(12, 4, 12, 4),
                    child: Text(
                      category,
                      style: TextStyle(
                        color: category == 'Dikti'
                            ? Color.fromRGBO(28, 92, 173, 1)
                            : Color.fromRGBO(45, 119, 56, 1),
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: bimaNomorSurat,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.02),
                        offset: Offset(0, 4),
                        blurRadius: 8,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(12, 4, 12, 4),
                    child: Text(
                      noSurat,
                      style: TextStyle(
                        color: Color.fromRGBO(37, 42, 49, 1),
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12.h,
            ),
            Text(
              judulDokumen,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: blue2,
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ImageIcon(
                  AssetImage('assets/km/icons/calendar_icon.png'),
                  size: 12.sp,
                  color: neutral40,
                ),
                SizedBox(
                  width: 6.w,
                ),
                Text(
                  // '${FormatDate.formatDateStatic(this.date)}',
                  date,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    color: neutral40,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              'Dokumen',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
                color: neutral50,
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ImageIcon(
                  AssetImage('assets/bima/icon_document.png'),
                  size: 16.sp,
                  color: neutral50,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Text(
                    // '${FormatDate.formatDateStatic(this.date)}',
                    judulDokumen,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      color: neutral50,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 318.w,
                height: 44.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Color(0xff248DDA)),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageIcon(
                      AssetImage('assets/bima/icon_download.png'),
                      size: 20.sp,
                      color: Color(0xff248DDA),
                    ),
                    SizedBox(width: 12.w,),
                    Text(
                      'Unduh Dokumen',
                      style: TextStyle(
                        color: Color(0xff248DDA),
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
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
