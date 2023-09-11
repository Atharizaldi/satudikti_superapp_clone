import 'package:app/presentation/component/SkeletonLoading.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SkeletonLoadingGaruda extends StatelessWidget {
  const SkeletonLoadingGaruda({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.h),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 0.25,
                              blurRadius: 0.6,
                              offset:
                                  Offset(0, 0.5), // changes position of shadow
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
                              child: Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SkeletonLoading(
                                      height: 64.w,
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
                                              height: 11.w,
                                              cornerRadius: 4.r,
                                            ),
                                            SizedBox(
                                              height: 2.w,
                                            ),
                                            SkeletonLoading(
                                              width: double.infinity,
                                              height: 11.w,
                                              cornerRadius: 4.r,
                                            ),
                                            SizedBox(
                                              height: 2.w,
                                            ),
                                            SkeletonLoading(
                                              width: double.infinity,
                                              height: 11.w,
                                              cornerRadius: 4.r,
                                            ),
                                            SizedBox(
                                              height: 7.w,
                                            ),
                                            SkeletonLoading(
                                              width: double.infinity,
                                              height: 8.w,
                                              cornerRadius: 4.r,
                                            ),
                                            SizedBox(
                                              height: 2.h,
                                            ),
                                            SkeletonLoading(
                                              width: double.infinity,
                                              height: 8.w,
                                              cornerRadius: 4.r,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 17.w),
                child: Text(
                  "Statistik",
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: blue3),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                width: double.infinity,
                child: GridView.count(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    CardStatistikLoading(),
                    CardStatistikLoading(),
                    CardStatistikLoading(),
                  ],
                  crossAxisCount: 3,
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardStatistikLoading extends StatelessWidget {
  const CardStatistikLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: white,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 188, 186, 186).withOpacity(0.15),
            spreadRadius: 0.2,
            blurRadius: 0.1,
            offset: Offset(0, 0.1), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 12.w,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.w),
            child: SkeletonLoading(
              height: 20.w,
              width: 20.w,
              cornerRadius: 3.r,
            ),
          ),
          SizedBox(
            height: 13.5.w,
          ),
          Padding(
              padding: EdgeInsets.only(left: 15.w, right: 17.w),
              child: SkeletonLoading(
                width: double.infinity,
                height: 12.w,
                cornerRadius: 20.r,
              )),
          SizedBox(
            height: 8.w,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.w, right: 17.w),
            child: SkeletonLoading(
              width: 50.w,
              height: 12.w,
              cornerRadius: 20.r,
            ),
          )
        ],
      ),
    );
  }
}
