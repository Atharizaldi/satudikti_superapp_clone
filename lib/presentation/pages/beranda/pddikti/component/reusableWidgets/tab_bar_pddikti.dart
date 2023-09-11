import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/reusableWidgets/tabHeader.dart';
import 'package:app/presentation/pages/beranda/pddikti/cubit/tab_bar/tab_bar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabBarPDDikti extends StatelessWidget {
  final List<String> headersTitle;
  const TabBarPDDikti({
    Key? key,
    required this.tabController,
    required this.headersTitle,
  }) : super(key: key);

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TabBarCubit(),
      child: Builder(builder: (context) {
        return Container(
          // height: 55.h,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(color: whiteBgPage),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  int indexAfter =
                      BlocProvider.of<TabBarCubit>(context).moveLeftTab();
                  tabController.animateTo(indexAfter);
                },
                child: Image.asset(
                  "assets/icons/tabbar/arrow_left.png",
                  width: 6.w,
                ),
              ),
              SizedBox(
                width: 12.w,
              ),
              Flexible(
                child: TabBar(
                  onTap: (index) {
                    print("indexx $index");
                    BlocProvider.of<TabBarCubit>(context).changeTabIndex(index);
                  },
                  controller: tabController,
                  isScrollable: true,
                  labelColor: blue3,
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: screenWidth(context) * (1 / 25)),
                  unselectedLabelColor: neutralCaption,
                  unselectedLabelStyle: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: screenWidth(context) * (1 / 25)),
                  indicatorColor: Colors.transparent,
                  indicatorWeight: 0.01,
                  labelPadding: EdgeInsets.symmetric(horizontal: 4.w),
                  tabs: [
                    for (int i = 0; i < headersTitle.length; i++)
                      TabHeader(
                          header: headersTitle[i],
                          tabController: tabController,
                          index: i),
                  ],
                ),
              ),
              SizedBox(
                width: 12.w,
              ),
              GestureDetector(
                onTap: () {
                  int indexAfter = BlocProvider.of<TabBarCubit>(context)
                      .moveRightTab(headersTitle.length);
                  tabController.animateTo(indexAfter);
                },
                child: Image.asset(
                  "assets/icons/tabbar/arrow_right.png",
                  width: 6.w,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
