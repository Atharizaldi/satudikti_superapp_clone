import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/card/akreditasiColorSwitch.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/card/statusColorSwitch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardProdiRev extends StatelessWidget {
  final String namaPT, namaPD, kodePD, akreditasi, status;
  const CardProdiRev(
      {Key? key,
      required this.namaPT,
      required this.namaPD,
      required this.kodePD,
      required this.akreditasi,
      required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330.w,
      height: 188.h,
      margin: EdgeInsets.symmetric(vertical: 16.h, horizontal: 15.w),
      child: Column(
        children: [
          Container(
            height: 66.h,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                color: white),
            child: Row(
              children: [
                SizedBox(
                  width: 18.w,
                ),
                Image.asset(
                  'assets/silemkerma.png',
                  height: 51.sp,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Container(
                  width: 210.w,
                  height: 34.h,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    this.namaPD,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 122.h,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
                color: blue2,
                image: DecorationImage(
                    image: AssetImage(
                  'assets/pddikti/vektor_lembaga.png',
                ))),
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 21.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 30.h,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    this.namaPT,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Text(
                  'Kode program studi: ' + this.kodePD,
                  style: TextStyle(
                      color: white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          this.akreditasi == ''
                              ? Container()
                              : Container(
                                  height: 19.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: akreditasiColor(this.akreditasi)),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 6.w, vertical: (2.5).h),
                                  child: Text(
                                    'Akreditasi ' + this.akreditasi,
                                    style: TextStyle(
                                        color: white,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  margin: EdgeInsets.only(right: 13.w),
                                ),
                          Container(
                            height: 19.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: statusColor(this.status)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 6.w, vertical: (2.5).h),
                            child: Text(
                              this.status,
                              style: TextStyle(
                                  color: white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
