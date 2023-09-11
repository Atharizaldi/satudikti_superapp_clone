import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabBarViewSister extends StatefulWidget {
  final List<Map<String, dynamic>> data;

  const TabBarViewSister({Key? key, required this.data}) : super(key: key);

  @override
  State<TabBarViewSister> createState() => _TabBarViewSisterState();
}

class _TabBarViewSisterState extends State<TabBarViewSister> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only(
      //   left: 16.w,
      //   right: 16.w,
      // ),
      margin: EdgeInsets.only(bottom: 24.w),
      decoration: BoxDecoration(color: Color(0xFFF9FAFE)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: SingleChildScrollView(
          child: Wrap(children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 28.w, right: 28.w),
              // margin: EdgeInsets.only(bottom: 24.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x0D5C5E61),
                    spreadRadius: -4,
                    blurRadius: 16,
                    offset: Offset(4, 0), // changes position of shadow
                  ),
                  BoxShadow(
                    color: Color(0x0D5C5E61),
                    spreadRadius: -2,
                    blurRadius: 6,
                    offset: Offset(0, 4), // changes position of shadow
                  )
                ],
              ),
              child: Column(
                children: [
                  for (final item in widget.data)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: _namainfo(item['nama']!, item['info']),
                    ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _namainfo(String nama, dynamic info) {
    if (info is String) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            child: Container(
              width: double.infinity,
              child: Text(nama,
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: blue4,
                      fontFamily: "Plus Jakarta Sans")),
            ),
          ),
          SizedBox(width: 10.w),
          Flexible(
            flex: 1,
            child: Container(
              width: double.infinity,
              child: Text(info,
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF2D3748),
                      fontFamily: "Plus Jakarta Sans")),
            ),
          ),
        ],
      );
    } else if (info is Widget) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            child: Container(
              width: double.infinity,
              child: Text(nama,
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: blue4,
                      fontFamily: "Plus Jakarta Sans")),
            ),
          ),
          SizedBox(width: 10.w),
          Flexible(flex: 1, child: info),
        ],
      );
    } else {
      return Container();
    }
  }
}
