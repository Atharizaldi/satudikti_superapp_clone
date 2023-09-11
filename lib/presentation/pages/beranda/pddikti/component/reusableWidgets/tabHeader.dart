import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/pddikti/cubit/tab_bar/tab_bar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabHeader extends StatelessWidget {
  final String header;
  final TabController tabController;
  final int index;

  const TabHeader(
      {Key? key,
      required this.header,
      required this.tabController,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: BlocBuilder<TabBarCubit, int>(
        builder: (context, currentIndex) {
          return Container(
            height: 36.h,
            decoration: BoxDecoration(
                color: currentIndex == index
                    ? Color.fromRGBO(36, 141, 218, 0.1)
                    : whiteBgPage,
                borderRadius: BorderRadius.circular(5.r)),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 8.w,
                vertical: 0.h,
              ),
              alignment: Alignment.centerLeft,
              child: Text(
                header,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  color: currentIndex == index ? blue4 : abu6,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
