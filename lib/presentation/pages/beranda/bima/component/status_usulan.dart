import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'card_status_usulan.dart';

class StatusUsulan extends StatefulWidget {
  const StatusUsulan(
      {Key? key,
      required this.statususulan,
      required this.tanggaltahappertama,
      required this.jamtahappertama,
      required this.deskripsitahappertama,
      required this.statustahappertama,
      required this.tanggaltahapkedua,
      required this.jamtahapkedua,
      required this.deskripsitahapkedua,
      required this.statustahapkedua,
      required this.tanggaltahapketiga,
      required this.jamtahapketiga,
      required this.deskripsitahapketiga,
      required this.statustahaketiga,
      required this.tanggaltahapkeempat,
      required this.deskripsitahapkeempat,
      required this.statustahapkeempat,
      required this.jamtahapkeempat})
      : super(key: key);

  final String statususulan;

  final String tanggaltahappertama;
  final String jamtahappertama;
  final String deskripsitahappertama;
  final String statustahappertama;

  final String tanggaltahapkedua;
  final String jamtahapkedua;
  final String deskripsitahapkedua;
  final String statustahapkedua;

  final String tanggaltahapketiga;
  final String jamtahapketiga;
  final String deskripsitahapketiga;
  final String statustahaketiga;

  final String tanggaltahapkeempat;
  final String jamtahapkeempat;
  final String deskripsitahapkeempat;
  final String statustahapkeempat;

  @override
  State<StatusUsulan> createState() => _StatusUsulanState();
}

class _StatusUsulanState extends State<StatusUsulan> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 358.w,
        height: 551.h,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Container(
            padding: EdgeInsets.only(top: 20, left: 14, right: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: CardStatusUsulan(statususulan: Statususulan.disetujui),
                ),
                SizedBox(height: 20.h),
                Container(
                  padding: EdgeInsets.only(left: 4),
                  width: 318.w,
                  height: 360.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 318.w,
                        height: 88.h,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 8),
                              child: Column(
                                children: [
                                  Container(
                                    child: Text(
                                      widget.tanggaltahappertama,
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff333333),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "Jam ${widget.jamtahappertama}",
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff999999),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 16),
                              child: Image.asset(
                                'assets/bima/icon_firststep.png',
                                width: 32.w,
                                height: 88.h,
                              ),
                            ),
                            Container(
                              width: 160.w,
                              height: 88.h,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                      widget.deskripsitahappertama,
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff1f2937),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      widget.statustahappertama,
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff6b7280),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 318.w,
                        height: 88.h,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 8),
                              child: Column(
                                children: [
                                  Container(
                                    child: Text(
                                      widget.tanggaltahapkedua,
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff333333),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "Jam ${widget.jamtahapkedua}",
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff999999),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 16),
                              child: Image.asset(
                                'assets/bima/icon_secondstep.png',
                                width: 32.w,
                                height: 88.h,
                              ),
                            ),
                            Container(
                              width: 160.w,
                              height: 88.h,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                      widget.deskripsitahapkedua,
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff1f2937),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      widget.statustahapkedua,
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff6b7280),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 318.w,
                        height: 88.h,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 8),
                              child: Column(
                                children: [
                                  Container(
                                    child: Text(
                                      widget.tanggaltahapketiga,
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff333333),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "Jam ${widget.jamtahapketiga}",
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff999999),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 16),
                              child: Image.asset(
                                'assets/bima/icon_thirdstep.png',
                                width: 32.w,
                                height: 88.h,
                              ),
                            ),
                            Container(
                              width: 160.w,
                              height: 88.h,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                      widget.deskripsitahapketiga,
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff1f2937),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      widget.statustahaketiga,
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff6b7280),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 318.w,
                        height: 88.h,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 8),
                              child: Column(
                                children: [
                                  Container(
                                    child: Text(
                                      widget.tanggaltahapkeempat,
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff333333),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "Jam ${widget.jamtahapkeempat}",
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff999999),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 16),
                              child: Image.asset(
                                'assets/bima/icon_fourthstep.png',
                                width: 32.w,
                                height: 88.h,
                              ),
                            ),
                            Container(
                              width: 160.w,
                              height: 88.h,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                      widget.deskripsitahapkeempat,
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff1f2937),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      widget.statustahapkeempat,
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff6b7280),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
