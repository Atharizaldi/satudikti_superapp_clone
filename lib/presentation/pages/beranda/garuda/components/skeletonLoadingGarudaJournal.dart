import 'package:app/presentation/component/SkeletonLoading.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SkeletonLoadingGarudaJournal extends StatelessWidget {
  const SkeletonLoadingGarudaJournal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // height: 800.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 16.w, right: 170.w),
                      child: SkeletonLoading(
                        height: 12.h,
                        width: double.infinity,
                        cornerRadius: 3.r,
                      )),
                  SizedBox(
                    height: 20.w,
                  ),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            left: 16.w, right: 16.w, bottom: 20.h),
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 0.25,
                                  blurRadius: 0.6,
                                  offset: Offset(
                                      0, 0.5), // changes position of shadow
                                ),
                              ],
                              color: white,
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 20.h,
                                      bottom: 20.h,
                                      left: 19.w,
                                      right: 19.w),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SkeletonLoading(
                                        height: 83.w,
                                        width: 64.w,
                                        cornerRadius: 4.r,
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
                                              SkeletonLoading(
                                                width: double.infinity,
                                                height: 14.w,
                                                cornerRadius: 4.r,
                                              ),
                                              SizedBox(
                                                height: 29.w,
                                              ),
                                              SkeletonLoading(
                                                width: double.infinity,
                                                height: 10.w,
                                                cornerRadius: 4.r,
                                              ),
                                              SizedBox(
                                                height: 23.w,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: 110.w),
                                                child: SkeletonLoading(
                                                  width: double.infinity,
                                                  height: 10.w,
                                                  cornerRadius: 4.r,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 22.w,
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8.w),
                                                    child: SkeletonLoading(
                                                      width: 50.w,
                                                      height: 8.w,
                                                      cornerRadius: 4.r,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 24.w),
                                                    child: SkeletonLoading(
                                                      width: 90.w,
                                                      height: 8.w,
                                                      cornerRadius: 4.r,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 36.h,
            )
          ],
        ),
      ),
    );
  }
}

class SkeletonLoadingGarudaJournalLihatLainnya extends StatelessWidget {
  const SkeletonLoadingGarudaJournalLihatLainnya({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // height: 800.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.w,
                  ),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            left: 16.w, right: 16.w, bottom: 20.h),
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 0.25,
                                  blurRadius: 0.6,
                                  offset: Offset(
                                      0, 0.5), // changes position of shadow
                                ),
                              ],
                              color: white,
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 20.h,
                                      bottom: 20.h,
                                      left: 19.w,
                                      right: 19.w),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SkeletonLoading(
                                        height: 83.w,
                                        width: 64.w,
                                        cornerRadius: 4.r,
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
                                              SkeletonLoading(
                                                width: double.infinity,
                                                height: 14.w,
                                                cornerRadius: 4.r,
                                              ),
                                              SizedBox(
                                                height: 29.w,
                                              ),
                                              SkeletonLoading(
                                                width: double.infinity,
                                                height: 10.w,
                                                cornerRadius: 4.r,
                                              ),
                                              SizedBox(
                                                height: 23.w,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: 110.w),
                                                child: SkeletonLoading(
                                                  width: double.infinity,
                                                  height: 10.w,
                                                  cornerRadius: 4.r,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 22.w,
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8.w),
                                                    child: SkeletonLoading(
                                                      width: 50.w,
                                                      height: 8.w,
                                                      cornerRadius: 4.r,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 24.w),
                                                    child: SkeletonLoading(
                                                      width: 90.w,
                                                      height: 8.w,
                                                      cornerRadius: 4.r,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 36.h,
            )
          ],
        ),
      ),
    );
  }
}
