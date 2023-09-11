import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InformationCard extends StatelessWidget {
  final Widget text;
  const InformationCard({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 358.w,
      height: 111.sp,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: informationCardColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Informasi",
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.08.sp,
                    color: neutralCaption),
              ),
              SizedBox(
                width: 8.w,
              ),
              Container(
                  height: 12.h,
                  child: Image.asset('assets/ijazahln/information.png'))
            ],
          ),
          SizedBox(
            height: 8.w,
          ),
          text
        ],
      ),
    );
  }
}
