
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'circular_persentase.dart';

class CardStatusUsulan extends StatelessWidget {
  final Statususulan statususulan;

  CardStatusUsulan({
    Key? key,
    required this.statususulan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double persen = 25.0;
    final statusUsulancard;
    final TextStyle fontStatusUsulan;
    final Color bgCardUsulan;
    final  progressStatus;
    final String deskripsiusulan;
    if (statususulan == Statususulan.disetujui) {
      statusUsulancard = persen.toString().replaceAll('.0', ' ') + "%";
      deskripsiusulan = "Usulanmu Sedang diproses";
      fontStatusUsulan = TextStyle(
        fontFamily: 'Plus Jakarta Sans',
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
        color: Color(0xff00be82),
      );
      bgCardUsulan = Color(0xffecfdf3);
      progressStatus = Center( child: CircularPersentase(persen: persen,
        info: Image.asset('assets/bima/icon_usulandiproses.png', width: 32.w, height: 40.h,
        alignment: Alignment.center,),
      ),
    );
    } else if (statususulan == Statususulan.ditolak) {
      statusUsulancard = "Ditolak";
      deskripsiusulan = "Mohon Perbaiki Berkas Usulan Anda";
      fontStatusUsulan = TextStyle(
        fontFamily: 'Plus Jakarta Sans',
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
        color: Color(0xfff04438),
      );
      bgCardUsulan = Color(0xfffef3f2);
      progressStatus = Image.asset('assets/bima/icon_usulanditolak.png', width:87.w, height: 87.h);
    } else {
      statusUsulancard = "Menunggu";
      deskripsiusulan = "Coba lagi";
      fontStatusUsulan = TextStyle(
        fontFamily: 'Plus Jakarta Sans',
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
        color: Color(0xfff04438),
      );
      bgCardUsulan = Color(0xfffef3f2);
    progressStatus = CircularPersentase(persen: 25.0,
      info: Image.asset('assets/bima/icon_usulandiproses.png',
        width: 32.w, height: 40.w),
    );
    }
    ;
    return Container(
      child: Container(
        width: 330.w,
        height: 131.h,
        decoration: BoxDecoration(
          color: bgCardUsulan,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Container(
          padding: EdgeInsets.only(top: 16, left: 20, bottom: 16, right: 20),
          width: 290.w,
          height: 99.h,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 99.h,
                width: 160.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          statusUsulancard,
                          style: fontStatusUsulan,
                        )),
                    Container(
                        child: Text(
                          deskripsiusulan ,
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff4d4d4d),
                      ),
                      maxLines: 3,
                    )),
                  ],
                ),
              ),
              SizedBox(width: 23.w),
              Container(
                child: progressStatus,
              )
            ],
          ),
        ),
      ),
    );
  }
}

enum Statususulan { disetujui, ditolak }
