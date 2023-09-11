import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardDaftarProdi extends StatelessWidget {
  final String namaProdi, lembaga, jenjang, akreditas, status, kodePD;
  final VoidCallback function;
  final bool isDetail;
  final Color warnaKodePD;
  const CardDaftarProdi(
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
            this.jenjang == "" ? Text("-") : Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: blue2)),
              padding: EdgeInsets.symmetric(
                  horizontal: 6.w, vertical: 3.5.h),
              child: Text(
                this.jenjang,
                style: TextStyle(
                  color: blue2,
                  fontSize: 12.sp,
                ),
              ),
            ),
            SizedBox(height: 12.h),
            this.namaProdi == "" ? Text("-") : Container(
              child: Text(
                this.namaProdi,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: cardTitleStyle,
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            this.kodePD == "" ? Text("Kode Program Studi : -", style:
            TextStyle(color: this.warnaKodePD, fontSize: 12.sp)) :
            Text(
              'Kode Program Studi : ${this.kodePD}',
              style: TextStyle(color: this.warnaKodePD, fontSize: 12.sp),
            ),
            SizedBox(
              height: 8.h,
            ),
          ],
        ),
      ),
    );
  }
}
