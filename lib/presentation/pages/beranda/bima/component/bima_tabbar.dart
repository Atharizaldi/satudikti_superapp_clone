import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../component/constant.dart';

class BimaTabBar extends StatefulWidget {
  const BimaTabBar({Key? key, required this.tabview}) : super(key: key);
  final List<Widget> tabview;

  @override
  State<BimaTabBar> createState() => _BimaTabBarState();
}

class _BimaTabBarState extends State<BimaTabBar>
    with SingleTickerProviderStateMixin {
  static List<Tab> _tabBima = <Tab>[
    Tab(
      child: Container(
        width: 358.w,
        height: 58.h,
        alignment: Alignment.center,
        child: Text(
          'Dikti',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
    Tab(
      child: Container(
        width: 358.w,
        height: 58.h,
        alignment: Alignment.center,
        child: Text(
          'Diksi',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabBima.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabBima.length,
      initialIndex: 0,
      child: Column(
        children: [
          Container(
            width: 358.w,
            height: 58.h,
            padding: EdgeInsets.symmetric(
              horizontal: 4.w,
              vertical: 4.h,
            ),
            decoration: BoxDecoration(
              color: neutral10,
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: TabBar(
              unselectedLabelColor: neutral40,
              indicator: BoxDecoration(
                  color: blue4, borderRadius: BorderRadius.circular(4.r)),
              tabs: _tabBima,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Expanded(child: TabBarView(children: widget.tabview))
        ],
      ),
    );
  }
}
