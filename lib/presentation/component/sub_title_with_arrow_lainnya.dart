import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubTitleWithArrowLainnya extends StatelessWidget {
  final String subJudul;
  final VoidCallback function;

  const SubTitleWithArrowLainnya(
      {Key? key, required this.subJudul, required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Text(
                this.subJudul,
                style: styleSubJudul,
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            GestureDetector(
              onTap: this.function,
              child: Container(
                margin: EdgeInsets.only(top: 4.h),
                height: double.infinity,
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Lihat Lainnya',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff118EEA),
                      ),
                    ),
                    SizedBox(
                      width: 6.w,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xff118EEA),
                      size: 12.h,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
