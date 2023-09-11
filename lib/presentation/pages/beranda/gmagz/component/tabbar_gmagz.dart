import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabBarGMagz extends StatefulWidget {
  final List<Tab> tabs;
  final List<Widget> tabview;

  const TabBarGMagz({Key? key, required this.tabs, required this.tabview})
      : super(key: key);

  @override
  State<TabBarGMagz> createState() => _TabBarGMagzState();
}

class _TabBarGMagzState extends State<TabBarGMagz>
    with TickerProviderStateMixin {
  late TabController _tabController;

  // List<Tab> tabs = [
  //   Tab(child: Text("Sinopsis")),
  //   Tab(child: Text("Review")),
  // ];

  // List<Widget> tabview = [
  //   Container(
  //     color: Colors.white,
  //     child: Column(
  //       children: [
  //         Container(
  //           // color: Color.fromRGBO(196, 196, 196, 1),
  //           width: 32.w,
  //           height: 32.w,
  //           child: Image.asset(
  //             'assets/silemkerma.png',
  //             width: 32.w,
  //           ),
  //         )
  //       ],
  //     ),
  //   ),
  //   Container(
  //     color: Color(0xFFD1D1D1),
  //   ),
  // ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(color: Color(0xFFF9FAFE)),
          child: TabBar(
            tabs: widget.tabs,
            isScrollable: false,
            // labelPadding: EdgeInsets.symmetric(horizontal: 25.w),
            padding: EdgeInsets.symmetric(horizontal: 90.w, vertical: 0.w),
            unselectedLabelColor: Color.fromRGBO(128, 128, 128, 1),
            controller: _tabController,
            labelColor: Color.fromRGBO(36, 141, 218, 1),
            labelStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                fontFamily: "Plus Jakarta Sans"),
            indicatorColor: Color.fromRGBO(36, 141, 218, 1),
          ),
        ),
        Expanded(
          child: Container(
            child: TabBarView(
              children: widget.tabview,
              controller: _tabController,
            ),
          ),
        )
      ],
    );
  }
}
