import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/card/akreditasiColorSwitch.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/card/statusColorSwitch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truncate/truncate.dart';

class CardPerguruanTinggiRev extends StatelessWidget {
  final String namaPT, namaRektor, akreditasi, status, kodePT;
  final Image logo;
  const CardPerguruanTinggiRev(
      {Key? key,
      required this.logo,
      required this.namaPT,
      required this.namaRektor,
      required this.akreditasi,
      required this.status,
      required this.kodePT})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 358.w,
      // height: 222.h,
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      decoration: BoxDecoration(),
      child: Column(
        children: [
          SizedBox(
            height: 30.h,
          ),
          rowLogoAndName(
            logo: this.logo,
            kode: this.kodePT,
            keteranganKode: "Kode PT",
            nama: this.namaPT,
          ),
          rowKeterangan(),
          SizedBox(
            height: 54.h,
          ),
        ],
      ),
    );
  }

  Container rowKeterangan() {
    return Container(
      // height: 112.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15.r),
            bottomRight: Radius.circular(15.r)),
        color: white,
      ),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 21.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Rektor :",
            style: TextStyle(
              fontSize: 12.sp,
              color: neutral60,
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          SelectableText(
            this.namaRektor == '' ? '-' : '${this.namaRektor}',
            enableInteractiveSelection: false,
            style: TextStyle(
              color: blue4,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
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
                            horizontal: 8.w, vertical: 4.h),
                        child: Text(
                          'Terakreditasi ' + this.akreditasi,
                          style: TextStyle(
                            color: white,
                            fontSize: 12.sp,
                          ),
                        ),
                        margin: EdgeInsets.only(right: 13.w),
                      ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.r),
                      border: Border.all(color: statusColor(this.status))),
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  child: Text(
                    this.status,
                    style: TextStyle(
                      color: statusColor(this.status),
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container rowLogoAndName(
      {required Widget logo,
      required String kode,
      required String keteranganKode,
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
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText(
                  truncate("$keteranganKode: $kode", 40),
                  enableInteractiveSelection: false,
                  // maxLines: 1,
                  // overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Container(
                  width: kode == '002002' ? 140.w : 210.w,
                  height: 34.h,
                  alignment: Alignment.centerLeft,
                  child: SelectableText(
                    truncate(nama, 50),
                    enableInteractiveSelection: false,
                    // maxLines: 2,
                    // overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: white,
                    ),
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
