import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RowResult extends StatelessWidget {
  final String keterangan;
  final String? hasil;
  final Widget? widgetHasil;
  final CrossAxisAlignment? crossAxisAlignment;
  final String? bold;
  const RowResult(
      {Key? key,
      required this.keterangan,
      this.hasil,
      this.widgetHasil,
      this.crossAxisAlignment,
      this.bold})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
      children: [
        Container(
            width: 130.w,
            child: SelectableText(
              keterangan,
              style: bold == "bold"
                  ? TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: blue4)
                  : TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: blue4),
            )),
        SizedBox(
          width: 15.w,
        ),
        Flexible(
          child: Container(
              // width: 158.w,
              // constraints: BoxConstraints(maxHeight: 34.w, maxWidth: 158.w),
              child: widgetHasil ??
                  SelectableText(
                    hasil ?? "",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: neutral60,
                      letterSpacing: 0.08.sp,
                    ),
                  )),
        ),
      ],
    );
  }
}
