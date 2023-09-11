import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/card/cardProdiRev.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truncate/truncate.dart';

class CardMahasiswaDosenRev extends StatelessWidget {
  final String namaPT, nama, nomorInduk, namaProdi, keteranganNomor;
  const CardMahasiswaDosenRev({
    Key? key,
    required this.namaPT,
    required this.nama,
    required this.nomorInduk,
    required this.namaProdi,
    required this.keteranganNomor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30.h, bottom: 48.h, left: 15.w, right: 15.w),
      child: Column(
        children: [
          rowLogoAndName(
            logo: Image.asset(
              'assets/silemkerma.png',
              height: 51.sp,
            ),
            nama: this.nama,
          ),
          Container(
            width: double.infinity,
            //height: 112.h,
            constraints: BoxConstraints(minHeight: 115.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.r),
                    bottomRight: Radius.circular(15.r)),
                color: white),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                SelectableText(
                  truncate(this.namaPT, 50),
                  enableInteractiveSelection: false,
                  //maxLines: 3,
                  //overflow: TextOverflow.ellipsis,
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  "Prodi:",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: neutral60,
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                SelectableText(
                  truncate(this.namaProdi, 40),
                  enableInteractiveSelection: false,
                  // maxLines: 3,
                  // overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: red,
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                SelectableText(
                  truncate("$keteranganNomor ${this.nomorInduk}", 40),
                  enableInteractiveSelection: false,
                  // maxLines: 3,
                  // overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: neutral20,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
