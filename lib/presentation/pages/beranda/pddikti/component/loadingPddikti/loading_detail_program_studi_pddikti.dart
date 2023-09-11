import 'dart:async';

import 'package:app/presentation/component/SkeletonLoading.dart';
import 'package:app/presentation/component/bannerSubJudul.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingDetailProgramStudiPDDikti extends StatefulWidget {
  const LoadingDetailProgramStudiPDDikti({Key? key}) : super(key: key);

  @override
  State<LoadingDetailProgramStudiPDDikti> createState() => _LoadingDetailProgramStudiPDDiktiState();
}

class _LoadingDetailProgramStudiPDDiktiState extends State<LoadingDetailProgramStudiPDDikti> {

  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(seconds: 45),
            () =>
            setState(() {
              loading = false;
            })
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBgPage,
      body: loading ? SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: 30.h, bottom: 48.h, left: 15.w, right: 15.w),
              child: Column(
                children: [
                  rowLogoAndNameLoading(),
                  Container(
                    width: double.infinity,
                    //height: 112.h,
                    constraints: BoxConstraints(minHeight: 115.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15.r),
                            bottomRight: Radius.circular(15.r)),
                        color: white),
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        SkeletonLoading(
                          width: 80.w,
                          height: 11.w,
                          cornerRadius: 10.r,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        SizedBox(
                          height: 28.h,
                        ),
                        Row(
                          children: [
                            SkeletonLoading(
                              width: 40.w,
                              height: 11.w,
                              cornerRadius: 10.r,
                            ),
                            SizedBox(
                              width: 8.h,
                            ),
                            SkeletonLoading(
                              width: 40.w,
                              height: 11.w,
                              cornerRadius: 10.r,
                            ),
                            SizedBox(
                              width: 8.h,
                            ),
                            SkeletonLoading(
                              width: 40.w,
                              height: 11.w,
                              cornerRadius: 10.r,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 80.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                    child: SkeletonLoading(
                      width: double.infinity,
                      height: 11.w,
                      cornerRadius: 10.r,
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      pddiktiKotak(judul: "Tanggal Berdiri"),
                      SizedBox(
                        width: screenWidth(context) * (1 / 30),
                      ),
                      pddiktiKotak(judul: "Tanggal SK")
                    ],
                  ),
                  SizedBox(
                    height: 13.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      pddiktiKotak(judul: "SK Penyelenggaraan"),
                      SizedBox(
                        width: screenWidth(context) * (1 / 30),
                      ),
                      pddiktiKotak(judul: "Rasio Dosen")
                    ],
                  ),
                  SizedBox(
                    height: 13.h,
                  ),
                  pddiktiKotak(judul: "Rasio Mahasiswa"),
                  SizedBox(
                    height: 20.h,
                  ),
                  Column(
                    children: [
                      BannerSubJudul(
                        subJudul: 'Kontak',
                        warna: blue3,
                        edgeInsets: EdgeInsets.zero,
                        fontWeight: FontWeight.w700,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      ListView.separated(
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 10.h,
                          );
                        },
                        itemCount: 5,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
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
                                        height: 60.w,
                                        width: 67.w,
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
                                                height: 10.h,
                                              ),
                                              SkeletonLoading(
                                                width: double.infinity,
                                                height: 11.w,
                                                cornerRadius: 4.r,
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              SkeletonLoading(
                                                width: double.infinity,
                                                height: 10.w,
                                                cornerRadius: 4.r,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ) :
      Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 30.w,
          ),
          Center(
            child: Image.asset(
              'assets/km/tutup.png',
              width: 190.w,
              height: 122.w,
            ),
          ),
          SizedBox(
            height: 30.w,
          ),
          Center(
            child: Text(
              "Data tidak dapat ditampilkan.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w400, fontSize: 16.sp, color: neutral50),
            ),
          ),
          SizedBox(
            height: 20.w,
          ),
        ],
      )
    );
  }

  Container pddiktiKotak({required String judul}) {
    return Container(
      height: 71.h,
      width: 171.w,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                judul,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 10.sp,
                  color: neutral30,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          SkeletonLoading(
            width: 50.w,
            height: 11.w,
            cornerRadius: 10.r,
          ),
        ],
      ),
    );
  }

  Container rowLogoAndNameLoading({
    String? kode,
    String? keteranganKode,
  }) {
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
          SkeletonLoading(
            width: 60.w,
            height: 67.h,
            cornerRadius: 10.r,
          ),
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
              SkeletonLoading(
                width: 130.w,
                height: 11.w,
                cornerRadius: 10.r,
              ),
              SizedBox(
                height: 15.h,
              ),
              SkeletonLoading(
                width: 130.w,
                height: 11.w,
                cornerRadius: 10.r,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget rowBioProfil({required BuildContext context, required String label}) {
    return Flexible(
      child: Container(
        width: 109.w,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 10.sp,
                color: neutral30,
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Flexible(
              child: SkeletonLoading(
                width: 70.w,
                height: 11.w,
                cornerRadius: 10.r,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoadingDetailPerguruanTinggiCardProdiPDDikti extends StatelessWidget {
  const LoadingDetailPerguruanTinggiCardProdiPDDikti({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteBgPage,
        body: ListView.separated(
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(left: 12.w, top: 15.h, right: 12.w),
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
                        child: Row(
                          children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  SkeletonLoading(
                                    width: 80.w,
                                    height: 10.w,
                                    cornerRadius: 4.r,
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  SkeletonLoading(
                                    width: 130.w,
                                    height: 10.w,
                                    cornerRadius: 4.r,
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
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 10.h,
              );
            },
            itemCount: 3));
  }
}
