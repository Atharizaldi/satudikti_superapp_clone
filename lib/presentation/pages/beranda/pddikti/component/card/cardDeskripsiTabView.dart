import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardDeskripsiTabView extends StatelessWidget {
  final String heading1, heading2;
  final Color? colorHeading2;
  const CardDeskripsiTabView({
    Key? key,
    required this.heading1,
    required this.heading2,
    this.colorHeading2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76.h,
      width: 171.w,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                this.heading1,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 10.sp,
                  color: neutral30,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Container(
            width: double.infinity,
            child: Text(
              this.heading2,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: cardTitleStyle.copyWith(color: colorHeading2 ?? blue3),
            ),
          )
        ],
      ),
    );
  }
}
