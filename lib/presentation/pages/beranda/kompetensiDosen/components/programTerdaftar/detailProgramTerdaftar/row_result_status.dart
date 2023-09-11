import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RowResultStatus extends StatelessWidget {
  final String keterangan;
  final String? hasil;
  final Widget? widgetHasil;

  const RowResultStatus(
      {Key? key, required this.keterangan, this.hasil, this.widgetHasil})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            width: 130.w,
            child: Text(
              keterangan,
              style: TextStyle(
                  fontSize: 14.sp, fontWeight: FontWeight.w400, color: blue4),
            )),
        SizedBox(
          width: 15.w,
        ),
        Container(
            // width: 158.w,
            constraints: BoxConstraints(maxHeight: 34.w, maxWidth: 158.w),
            child: widgetHasil ??
                Text(
                  hasil ?? "",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: neutral60,
                    letterSpacing: 0.08.sp,
                  ),
                )),
      ],
    );
  }
}
