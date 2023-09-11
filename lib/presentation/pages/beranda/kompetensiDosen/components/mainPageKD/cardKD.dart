import 'package:app/common/dateFormat.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truncate/truncate.dart';

class CardKD extends StatelessWidget {
  final String nama;
  final String startDate, endDate, persyaratan;
  final String tag;
  const CardKD({
    Key? key,
    required this.nama,
    required this.startDate,
    required this.endDate,
    required this.tag,
    required this.persyaratan,
  }) : super(key: key);
  String removeHtmlTags(String htmlString) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlString.replaceAll(exp, '');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 358.w,
      // height: 178.sp,
      padding: EdgeInsets.symmetric(vertical: 20.sp, horizontal: 20.w),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(151, 151, 151, 0.06),
              offset: Offset(0, 4),
              blurRadius: 15,
              spreadRadius: 10)
        ],
      ),
      child: _cardInfo(),
    );
  }

  Widget _cardInfo() {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SelectableText(
          removeHtmlTags(truncate(nama, 80)),
          enableInteractiveSelection: false,
          //maxLines: 4,
          //overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: blue4, fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.sp),
        _tag(tag),
        SizedBox(height: 16.5.sp),
        Row(
          children: [
            Image.asset(
              "assets/icons/calendar.png",
              width: 12.sp,
              height: 13.33.sp,
            ),
            SizedBox(width: 10.sp),
            Flexible(
                child: SelectableText(
              '${FormatDate.formatDateStatic(this.startDate)} - ${FormatDate.formatDateStatic(this.endDate)}',
              style: TextStyle(
                color: neutral80,
                fontSize: 10.5.sp,
                fontWeight: FontWeight.w700,
              ),
            ))
          ],
        ),
      ]),
    );
  }

  Widget _tag(String tag) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.sp),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          border: Border.all(color: green3)),
      child: SelectableText(
        truncate(tag, 60),
        enableInteractiveSelection: false,
        //maxLines: 1,
        style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w200,
            letterSpacing: 0.08.sp,
            color: green3),
      ),
    );
  }
}
