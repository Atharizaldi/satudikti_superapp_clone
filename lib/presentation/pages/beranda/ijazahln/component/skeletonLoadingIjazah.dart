import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeleton_text/skeleton_text.dart';

class SkeletonLoadingIjazah extends StatelessWidget {
  const SkeletonLoadingIjazah({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
      shimmerColor: white,
      curve: Curves.linear,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
          height: 800.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 17.w),
                child: Text(
                  "Pilih Layanan",
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: blue3),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 0.25,
                          blurRadius: 0.6,
                          offset: Offset(0, 0.5), // changes position of shadow
                        ),
                      ],
                      color: white,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.h, bottom: 20.h, left: 19.w, right: 19.w),
                          child: Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 64.w,
                                  width: 64.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.r),
                                    color: Color(0xffCAD0FA),
                                  ),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Flexible(
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 0,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 12.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4.r),
                                            color: Color(0xffCAD0FA),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 14.h,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 10.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4.r),
                                            color: Color(0xffCAD0FA),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4.h,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 10.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4.r),
                                            color: Color(0xffCAD0FA),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4.h,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 10.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4.r),
                                            color: Color(0xffCAD0FA),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4.h,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 10.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4.r),
                                            color: Color(0xffCAD0FA),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 0.25,
                          blurRadius: 0.6,
                          offset: Offset(0, 0.5), // changes position of shadow
                        ),
                      ],
                      color: white,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.h, bottom: 20.h, left: 19.w, right: 19.w),
                          child: Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 64.w,
                                  width: 64.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.r),
                                    color: Color(0xffCAD0FA),
                                  ),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Flexible(
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 0,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 12.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4.r),
                                            color: Color(0xffCAD0FA),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 14.h,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 10.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4.r),
                                            color: Color(0xffCAD0FA),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4.h,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 10.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4.r),
                                            color: Color(0xffCAD0FA),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4.h,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 10.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4.r),
                                            color: Color(0xffCAD0FA),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4.h,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 10.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4.r),
                                            color: Color(0xffCAD0FA),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 0.25,
                          blurRadius: 0.6,
                          offset: Offset(0, 0.5), // changes position of shadow
                        ),
                      ],
                      color: white,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.h, bottom: 20.h, left: 19.w, right: 19.w),
                          child: Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 64.w,
                                  width: 64.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.r),
                                    color: Color(0xffCAD0FA),
                                  ),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Flexible(
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 0,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 12.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4.r),
                                            color: Color(0xffCAD0FA),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 14.h,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 10.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4.r),
                                            color: Color(0xffCAD0FA),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4.h,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 10.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4.r),
                                            color: Color(0xffCAD0FA),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4.h,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 10.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4.r),
                                            color: Color(0xffCAD0FA),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4.h,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 10.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4.r),
                                            color: Color(0xffCAD0FA),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
