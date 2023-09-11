import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSliverBar extends StatelessWidget {
  final Widget child;
  final Widget? header;
  final Widget? leading;
  final Color? bgColor;
  final String appBarTitle;
  final List<Widget>? appBarActions;
  final double? expandedHeight;

  const CustomSliverBar({
    Key? key,
    required this.child,
    this.bgColor,
    this.leading,
    this.header,
    this.appBarActions,
    this.expandedHeight,
    required this.appBarTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: ClampingScrollPhysics(),
      slivers: [
        SliverAppBar(
            leading: this.leading,
            backgroundColor: bgColor ?? blueLinear2,
            pinned: true,
            centerTitle: true,
            elevation: 0,
            expandedHeight: this.expandedHeight ?? 320.h,
            title: Text(
              this.appBarTitle,
              style: TextStyle(
                  color: white,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                  fontSize: 20.sp),
            ),
            flexibleSpace: header,
            actions: appBarActions ?? null),
        SliverToBoxAdapter(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: whiteBgPage,
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
            ),
            child: Column(
              children: [
                SizedBox(height: 8.w),
                greyIconBar(),
                this.child,
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget greyIconBar() {
  return Container(
    width: 28.w,
    height: 4.sp,
    decoration: BoxDecoration(
      color: neutral20,
      borderRadius: BorderRadius.circular(4.r),
    ),
  );
}
