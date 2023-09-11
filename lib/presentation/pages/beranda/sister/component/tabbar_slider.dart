import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabBarSlider extends StatefulWidget {
  final List<Tab> tabs;
  final List<Widget> tabview;
  void Function(int)? onTap;
  int tabGO;
  final void Function(int)? onTabIndexChanged;

  TabBarSlider(
      {Key? key,
      this.onTap,
      this.tabGO = 0,
      this.onTabIndexChanged,
      required this.tabs,
      required this.tabview})
      : super(key: key);
  @override
  State<TabBarSlider> createState() => _TabBarSlider();
}

class _TabBarSlider extends State<TabBarSlider> with TickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.tabs.length, vsync: this);
    _tabController.animateTo(widget.tabGO);

    _tabController.addListener(() {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        setState(() {
          _selectedIndex = _tabController.index;
        });

        if (widget.onTabIndexChanged != null) {
          widget.onTabIndexChanged!(_tabController.index);
        }
      });
    });
  }

  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        children: [
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 8.h,
            ),
            child: TabBar(
                controller: _tabController,
                onTap: widget.onTap,
                labelStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
                indicatorPadding:
                    EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.w),
                indicator: BoxDecoration(
                    color: biruMuda4, borderRadius: BorderRadius.circular(8.r)),
                isScrollable: true,
                physics: BouncingScrollPhysics(),
                labelColor: blue4,
                unselectedLabelColor: neutral50,
                tabs: widget.tabs),
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: Container(
              child: TabBarView(
                controller: _tabController,
                children: widget.tabview,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
