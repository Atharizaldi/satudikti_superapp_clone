import 'package:app/common/dateFormat.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truncate/truncate.dart';

final FormatDate formatDate = FormatDate();

class CardProgramTerdaftar extends StatelessWidget {
  final String nama;
  final String startDate;
  final String tag;
  final Color? backgroundColor;
  final Function()? onTap;
  const CardProgramTerdaftar(
      {Key? key,
      required this.nama,
      required this.startDate,
      required this.tag,
      this.backgroundColor,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        width: 358.w,

        // height: 178.sp,
        padding: EdgeInsets.symmetric(vertical: 20.sp, horizontal: 20.w),
        decoration: BoxDecoration(
            color: backgroundColor ?? white,
            borderRadius: BorderRadius.circular(5.r)),
        child: _cardInfo(),
      ),
    );
  }

  Widget _cardInfo() {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SelectableText(
          truncate(nama, 60),
          onTap: onTap ?? () {},
          enableInteractiveSelection: false,
          //maxLines: 3,
          //overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: blue4, fontSize: 14.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.sp),
        _tag(tag),
        SizedBox(height: 12.sp),
        SelectableText(
          'Terdaftar ${FormatDate.formatDateStatic(startDate)}',
          onTap: onTap ?? () {},
          enableInteractiveSelection: false,
          style: textStyleSmallParagraph,
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
        onTap: onTap ?? () {},
        enableInteractiveSelection: false,
        //maxLines: 1,
        //overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w200,
            letterSpacing: 0.08.sp,
            color: green3),
      ),
    );
  }
}
