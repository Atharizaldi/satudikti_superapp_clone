import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DataFoundCard extends StatelessWidget {
  const DataFoundCard({Key? key, required this.judulSkripsi
      // required this.sivil,
      })
      : super(key: key);
  final String judulSkripsi;

  // final Sivil? sivil;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
          color: Color.fromRGBO(0, 190, 130, 1),
          borderRadius: BorderRadius.circular(10.r)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle_rounded,
            size: 34.w,
            color: white,
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Data Ditemukan",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Plus Jakarta Sans',
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                            text: "Judul Skripsi “$judulSkripsi”",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Plus Jakarta Sans',
                              color: Colors.white,
                              height: 1.7.h,
                              wordSpacing: 0,
                            )),
                      ],
                    ),
                  )
                  // ),                  RichText(,
                  //                 textAlign: TextAlign.justify,
                  //                 style: TextStyle(
                  //                   fontSize: 14.sp,
                  //                   fontWeight: FontWeight.w500,
                  //                   fontFamily: 'Plus Jakarta Sans',
                  //                   color: Colors.white,
                  //                   height: 1.7.h,
                  //                   wordSpacing: 0,
                  //                 )),
                ],
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.copy,
              size: 22.w,
            ),
            constraints: BoxConstraints(),
            padding: EdgeInsets.zero,
            iconSize: 22.w,
            color: white,
            onPressed: () {
              // Clipboard.setData(ClipboardData(
              //   text: sivil?.data.mahasiswa[0].terdaftar.noIjazah,
              // ));
              Clipboard.setData(ClipboardData(text: judulSkripsi));

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      Icon(Icons.check_circle_rounded,
                          size: 20.w, color: green3),
                      SizedBox(width: 10),
                      Text("Judul skripsi berhasil disalin!",
                          style: TextStyle(color: Colors.black)),
                    ],
                  ),
                  backgroundColor: white,
                  action: SnackBarAction(
                    label: "X",
                    textColor: neutral60,
                    onPressed:
                        ScaffoldMessenger.of(context).hideCurrentSnackBar,
                  ),

                  // GestureDetector(
                  //   child: Icon(
                  //     Icons.clear,
                  //     color: neutral60,
                  //   ),
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //   },
                  // ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
