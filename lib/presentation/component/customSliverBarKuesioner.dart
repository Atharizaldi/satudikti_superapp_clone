import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSliverBarKuesioner extends StatelessWidget {
  final Widget child;
  final Widget? leading;
  final Color? bgColor;
  final String appBarTitle;
  final List<Widget>? appBarActions;

  const CustomSliverBarKuesioner({
    Key? key,
    required this.child,
    this.bgColor,
    this.leading,
    this.appBarActions,
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
            title: Text(
              this.appBarTitle,
              style: TextStyle(
                  color: white,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                  fontSize: 20.sp),
            ),
            actions: appBarActions ?? null),
        SliverToBoxAdapter(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: whiteBgPage,
            ),
            child: Column(
              children: [
                SizedBox(height: 8.w),
                this.child,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
