import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CekKomponen extends StatefulWidget {
  const CekKomponen({Key? key}) : super(key: key);

  @override
  State<CekKomponen> createState() => _CekKomponenState();
}

class _CekKomponenState extends State<CekKomponen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabsContent.length, vsync: this);
//     _tabController.animateTo(2);
    print(_tabController.index);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
      print("Selected Index: " + _tabController.index.toString());
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Widget> tabsContent = [
    Flexible(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
        child: Center(child: Text("dataa")),
      ),
    ),
    Container(
      color: Color(0xFFD1D1D1),
    ),
    Container(
      color: Color(0xFFD1D1D1),
    ),
    Container(
      color: Colors.yellow,
      child: Center(
        child: Text("data"),
      ),
    ),
    Container(
      color: Colors.red,
    ),
    Container(
      color: Colors.orange,
    ),
    Container(
      color: Colors.grey,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: tabsContent,
      controller: _tabController,
    );
  }
}
