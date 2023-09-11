import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PDDiktiPopUpDosenKembali extends StatelessWidget {
  const PDDiktiPopUpDosenKembali({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 107.w, right: 107.w, top: 40.h),
            child: Image.asset("assets/pddikti/popup_pddikti.png"),
          ),
          SizedBox(
            height: 30.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 84.w, right: 84.w),
            child: Text(
              "Modul tidak bisa diakses",
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: blueLinear1),
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 69.w, right: 69.w),
            child: Text(
              "Modul in hanya bisa diakses oleh dosen",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: neutral70),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          GestureDetector(
            onTap: () {
              print("refresh");
            },
            child: Container(
              width: 154.w,
              height: 44.h,
              decoration: BoxDecoration(
                border: Border.all(color: red),
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: Center(
                child: Text(
                  'Kembali',
                  style: TextStyle(
                    color: red,
                    fontWeight: FontWeight.w700,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
