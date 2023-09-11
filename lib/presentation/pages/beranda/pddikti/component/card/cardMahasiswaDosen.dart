import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truncate/truncate.dart';

class CardMahasiswaDosen extends StatelessWidget {
  final bool isMahasiswa;
  final bool isDetail;
  final String nomorInduk, nama, namaProdi, namaPerguruanTinggi;
  final VoidCallback function;
  const CardMahasiswaDosen(
      {Key? key,
      required this.isMahasiswa,
      required this.isDetail,
      required this.function,
      required this.nomorInduk,
      required this.nama,
      required this.namaProdi,
      required this.namaPerguruanTinggi})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.function,
      child: Container(
        height: screenHeight(context) * (1 / 5),
        width: screenWidth(context) * (1 / 1.2),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectableText(
              truncate((this.nama == "") ? "-" : this.nama, 30),
              onTap: this.function,
              enableInteractiveSelection: false,
              style: cardTitleStyle,
            ),
            SizedBox(
              height: 12.sp,
            ),
            Container(
              width: screenWidth(context) * (1 / 1.3),
              child: SelectableText(
                truncate(
                    (this.namaPerguruanTinggi == "")
                        ? "-"
                        : this.namaPerguruanTinggi,
                    40),
                onTap: this.function,
                enableInteractiveSelection: false,
                //overflow: TextOverflow.ellipsis,
                style: cardTextStyle,
              ),
            ),
            SizedBox(
              height: 12.sp,
            ),
            SelectableText(
              (this.namaProdi == "") ? "-" : this.namaProdi,
              onTap: this.function,
              enableInteractiveSelection: false,
              style: cardTextStyle.copyWith(color: neutral40),
            ),
            SizedBox(
              height: 8.sp,
            ),
            SelectableText(
              isMahasiswa
                  ? (this.nomorInduk == "")
                      ? "NIM : -"
                      : "NIM : " + this.nomorInduk
                  : (this.nomorInduk == "")
                      ? "NIDN : -"
                      : "NIDN : "
                              "" +
                          this.nomorInduk,
              onTap: this.function,
              enableInteractiveSelection: false,
              style: cardTextStyle.copyWith(color: teksAbuCerah4),
            ),
          ],
        ),
      ),
    );
  }
}
