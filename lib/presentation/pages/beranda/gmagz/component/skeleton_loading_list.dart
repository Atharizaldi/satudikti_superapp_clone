import 'package:app/presentation/component/SkeletonLoading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SkeletonLoadingListGMagz extends StatelessWidget {
  const SkeletonLoadingListGMagz({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
      child: ListView(
        children: [
          Align(
              alignment: Alignment.topRight,
              child: SkeletonLoading(
                width: 200,
                height: 50,
                cornerRadius: 10.r,
              )),
          SizedBox(
            height: 10.w,
          ),
          ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              // return Text(state.listBook[index].judul);
              return SkeletonLoading(
                width: double.infinity,
                height: 200,
                cornerRadius: 10.r,
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 12.h);
            },
          ),
        ],
      ),
    );
  }
}
