import 'package:app/common/dateFormat.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final FormatDate formatDate = FormatDate();

class CardJenisProgramKD extends StatelessWidget {
  final String nama;
  final String deskripsi;
  const CardJenisProgramKD({
    Key? key,
    required this.nama,
    required this.deskripsi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 358.w,
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
        Text(
          nama,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: blue4, fontSize: 14.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.sp),
        Text(
          deskripsi,
          style: textStyleSmallParagraph,
        )
      ]),
    );
  }
}
