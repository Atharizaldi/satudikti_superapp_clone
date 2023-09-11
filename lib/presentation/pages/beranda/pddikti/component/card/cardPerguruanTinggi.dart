import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truncate/truncate.dart';

class CardPerguruanTinggi extends StatelessWidget {
  final String namaPt, npsn;
  final VoidCallback function;
  final dynamic logo;
  const CardPerguruanTinggi(
      {Key? key,
      required this.function,
      required this.namaPt,
      required this.npsn,
      required this.logo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.function,
      child: Container(
        height: 121.h,
        width: 358.w,
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: SelectableText(
                truncate(this.namaPt, 30),
                onTap: this.function,
                enableInteractiveSelection: false,
                //maxLines: 2,
                //overflow: TextOverflow.ellipsis,
                style: cardTitleStyle,
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            SelectableText(
              'Kode PT: ${this.npsn}',
              onTap: this.function,
              enableInteractiveSelection: false,
              style: TextStyle(
                  color: neutralCaption,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
