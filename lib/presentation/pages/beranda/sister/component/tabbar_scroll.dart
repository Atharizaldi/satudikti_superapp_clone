import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../component/constant.dart';

class TabBarScroll extends StatefulWidget {
  final List<Tab> tabs;
  final List<Widget> tabview;
  void Function(int)? onTap;
  final void Function(int)? onTabIndexChanged;

  int tabGO;

  TabBarScroll(
      {Key? key,
      required this.tabs,
      required this.tabview,
      this.onTap,
      this.onTabIndexChanged,
      this.tabGO = 0})
      : super(key: key);
  @override
  State<TabBarScroll> createState() => _TabBarScrollState();
}

class _TabBarScrollState extends State<TabBarScroll>
    with TickerProviderStateMixin {
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

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: Color(0xFFF9FAFE)),
            child: Stack(
              children: [
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: <Color>[Colors.black, Colors.transparent],
                    ).createShader(Rect.fromLTRB(
                        bounds.width - 25, 0, bounds.width, bounds.height));
                  },
                  blendMode: BlendMode.dstIn,
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: <Color>[Colors.black, Colors.transparent],
                      ).createShader(Rect.fromLTRB(0, 0, 25, bounds.height));
                    },
                    blendMode: BlendMode.dstOut,
                    child: TabBar(
                      onTap: widget.onTap,
                      controller: _tabController,
                      labelStyle: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Plus Jakarta Sans",
                      ),
                      indicatorPadding: EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 5,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 24.w,
                      ),
                      indicator: BoxDecoration(
                        color: biruMuda4,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      labelColor: blue4,
                      unselectedLabelColor: neutral50,
                      physics: BouncingScrollPhysics(),
                      isScrollable: true,
                      tabs: widget.tabs,
                    ),
                  ),
                ),
                _tabController.index == 0
                    ? Align()
                    : Align(
                        heightFactor: 2.w,
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () {
                            _tabController.animateTo(
                              _tabController.index - 1,
                            );
                          },
                          icon: Icon(
                            Icons.navigate_before,
                            size: 24.sp,
                            color: Color.fromRGBO(102, 102, 102, 1),
                          ),
                        ),
                      ),
                _tabController.index == _tabController.length - 1
                    ? Align()
                    : Align(
                        heightFactor: 2.w,
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: () {
                            _tabController.animateTo(
                              _tabController.index + 1,
                            );
                          },
                          icon: Icon(
                            Icons.navigate_next,
                            size: 24.sp,
                            color: Color.fromRGBO(102, 102, 102, 1),
                          ),
                        ),
                      ),
              ],
            ),
          ),
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
