import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truncate/truncate.dart';

class CardProdi extends StatelessWidget {
  final String namaProdi, lembaga, jenjang, akreditas, status, kodePD;
  final VoidCallback function;
  final bool isDetail;
  final Color warnaKodePD;
  const CardProdi(
      {Key? key,
      required this.function,
      required this.namaProdi,
      required this.lembaga,
      required this.jenjang,
      required this.status,
      required this.kodePD,
      required this.isDetail,
      required this.warnaKodePD,
      required this.akreditas})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.function,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Container(
                    child: SelectableText(
                      truncate(this.namaProdi, 30),
                      onTap: this.function,
                      enableInteractiveSelection: false,
                      //overflow: TextOverflow.ellipsis,
                      //maxLines: 2,
                      style: cardTitleStyle,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            SelectableText(
              this.lembaga,
              onTap: this.function,
              enableInteractiveSelection: false,
              style: TextStyle(
                fontSize: 12.sp,
                color: teksAbuCerah4,
              ),
            ),
            // SizedBox(
            //   height: 8.h,
            // ),
            // Text(
            //   'Kode Program Studi: ${this.kodePD}',
            //   style: TextStyle(color: this.warnaKodePD, fontSize: 12.sp),
            // ),
            // SizedBox(
            //   height: 8.h,
            // ),
            // Row(
            //   children: [
            //     isDetail
            //         ? Row(
            //             children: [
            //               Container(
            //                 decoration: BoxDecoration(
            //                     color: green,
            //                     borderRadius: BorderRadius.circular(8)),
            //                 padding: EdgeInsets.symmetric(
            //                     horizontal: screenWidth(context) * (1 / 60),
            //                     vertical: screenHeight(context) * (1 / 200)),
            //                 child: Center(
            //                   child: Text(
            //                     'Akreditasi ${this.akreditas}',
            //                     style: TextStyle(
            //                         color: white,
            //                         fontWeight: FontWeight.bold,
            //                         fontSize: 12.sp,
            //                         letterSpacing: 1),
            //                   ),
            //                 ),
            //               ),
            //               SizedBox(
            //                 width: screenWidth(context) * (1 / 20),
            //               ),
            //               Container(
            //                 decoration: BoxDecoration(
            //                     color: green,
            //                     borderRadius: BorderRadius.circular(8)),
            //                 padding: EdgeInsets.symmetric(
            //                     horizontal: screenWidth(context) * (1 / 60),
            //                     vertical: screenHeight(context) * (1 / 200)),
            //                 child: Center(
            //                   child: Text(
            //                     this.status,
            //                     style: TextStyle(
            //                         color: white,
            //                         fontWeight: FontWeight.bold,
            //                         fontSize: 12.sp,
            //                         letterSpacing: 1),
            //                   ),
            //                 ),
            //               ),
            //               SizedBox(
            //                 width: screenWidth(context) * (1 / 20),
            //               ),
            //             ],
            //           )
            //         : Container(),
            //     this.jenjang == ''
            //         ? Container()
            //         : Container(
            //             decoration: BoxDecoration(
            //                 color: biruTua3,
            //                 borderRadius: BorderRadius.circular(8)),
            //             padding: EdgeInsets.symmetric(
            //                 horizontal: screenWidth(context) * (1 / 60),
            //                 vertical: screenHeight(context) * (1 / 200)),
            //             child: Center(
            //               child: Text(
            //                 this.jenjang,
            //                 style: TextStyle(
            //                     color: white,
            //                     fontWeight: FontWeight.bold,
            //                     fontSize: 12.sp,
            //                     letterSpacing: 1),
            //               ),
            //             ),
            //           ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
