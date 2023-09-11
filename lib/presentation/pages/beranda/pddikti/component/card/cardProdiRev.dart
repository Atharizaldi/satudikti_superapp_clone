import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/card/akreditasiColorSwitch.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/card/statusColorSwitch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truncate/truncate.dart';

class CardProdiRev extends StatelessWidget {
  final String namaPT, namaPD, kodePD, akreditasi, status;
  final dynamic jenjangDidik;
  const CardProdiRev({
    Key? key,
    required this.namaPT,
    required this.namaPD,
    required this.kodePD,
    required this.akreditasi,
    required this.status,
    required this.jenjangDidik,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30.h, bottom: 48.h, left: 15.w, right: 15.w),
      decoration: BoxDecoration(
        color: whiteBgPage,
      ),
      child: Column(
        children: [
          rowLogoAndName(
            logo: Image.asset(
              'assets/silemkerma.png',
              height: 51.sp,
            ),
            kode: this.kodePD,
            keteranganKode: "Kode program studi",
            nama: this.namaPD,
          ),
          Container(
            // height: 112.h,
            width: double.infinity,
            constraints: BoxConstraints(minHeight: 115.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.r),
                  bottomRight: Radius.circular(15.r)),
              color: white,
            ),
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 21.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: SelectableText(
                    truncate(this.namaPT, 50),
                    enableInteractiveSelection: false,
                    //maxLines: 2,
                    //overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: blue4,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(height: 26.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          this.akreditasi == ''
                              ? Container()
                              : Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4.r),
                                      color: akreditasiColor(this.akreditasi)),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 6.w, vertical: 3.5.h),
                                  child: Text(
                                    'Akreditasi ' + this.akreditasi,
                                    style: TextStyle(
                                      color: white,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  margin: EdgeInsets.only(right: 8.w),
                                ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                    color: statusColor(this.status))),
                            padding: EdgeInsets.symmetric(
                                horizontal: 6.w, vertical: 3.5.h),
                            child: Text(
                              this.status,
                              style: TextStyle(
                                color: statusColor(this.status),
                                fontSize: 12.sp,
                              ),
                            ),
                            margin: EdgeInsets.only(right: 8.w),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: blue2)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 6.w, vertical: 3.5.h),
                            child: Text(
                              jenjangDidik.nama,
                              style: TextStyle(
                                color: blue2,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Container rowLogoAndName(
    {required Widget logo,
    String? kode,
    String? keteranganKode,
    required String nama}) {
  return Container(
    // height: 66.h,
    width: double.infinity,
    padding: EdgeInsets.symmetric(
      horizontal: 20.w,
      vertical: 20.h,
    ),
    decoration: BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.fill,
        image: AssetImage(
          'assets/pddikti/background_card_detail.png',
        ),
      ),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15.r),
        topRight: Radius.circular(15.r),
      ),

      // color: Colors.amber,
    ),
    alignment: Alignment.centerLeft,
    child: Row(
      children: [
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              color: white.withOpacity(0.2),
            ),
            padding: EdgeInsets.all(8.w),
            child: logo),
        SizedBox(
          width: 10.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (kode != null && keteranganKode != null)
                ? (Text(
                    "$keteranganKode: $kode",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400),
                  ))
                : SizedBox(),
            SizedBox(
              height: (kode != null && keteranganKode != null) ? 4.h : 0,
            ),
            Container(
              width: kode == '002002' ? 140.w : 210.w,
              height: 34.h,
              alignment: Alignment.centerLeft,
              child: SelectableText(
                truncate(nama, 40),
                enableInteractiveSelection: false,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: white,
                  //overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}
