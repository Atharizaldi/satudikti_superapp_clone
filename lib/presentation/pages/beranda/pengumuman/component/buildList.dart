import 'package:app/data/source/remote/model/pengumuman/pengumumanList.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/newBannerSubJudul.dart';
import 'package:app/presentation/pages/beranda/pengumuman/component/pengumuman_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildPengumumanList(
  String category,
  List<Data> pengumumanList,
  bool hasReachedMax,
  ScrollController scrollController,
  BuildContext context,
) {
  return Container(
    color: whiteBgPage,
    margin: EdgeInsets.symmetric(horizontal: 16.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.h),
        NewBannerSubJudul(
          subJudul: 'Pengumuman Terbaru',
          subJudul2: 'Temukan berbagai pengumuman Dikti terbaru',
          color: whiteBgPage,
        ),
        SizedBox(height: 32.h),
        Flexible(
          child: Container(
            height: screenHeight(context),
            color: whiteBgPage,
            child: ListView.separated(
              itemCount: (hasReachedMax)
                  ? pengumumanList.length
                  : pengumumanList.length + 1,
              controller: scrollController,
              itemBuilder: (context, index) {
                if (index < pengumumanList.length) {
                  return PengumumanCard(
                    category: category,
                    pengumuman: pengumumanList[index],
                  );
                } else {
                  return Center(
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(color: blueLinear1),
                    ),
                  );
                }
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 33.h);
              },
            ),
          ),
        ),
        SizedBox(height: 15.h),
      ],
    ),
  );
}
