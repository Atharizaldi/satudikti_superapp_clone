import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CustomPercentIndicator extends StatelessWidget {
  final double radius;
  final double lineWidth;
  final Color? progressColor;
  final Color backgroundColor;
  final Color? containerColor;
  final double containerHeight;
  final double containerWidth;
  final String image;
  final double fontSize;
  final num progressPercentage;
  const CustomPercentIndicator({
    Key? key,
    this.radius = 30,
    this.progressColor = green3,
    this.backgroundColor = Colors.transparent,
    this.containerColor = green3,
    this.progressPercentage = 75,
    this.containerHeight = 50,
    this.containerWidth = 50,
    this.lineWidth = 2.5,
    this.fontSize = 10,
    this.image = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: radius.r,
      lineWidth: lineWidth.w,
      progressColor: progressColor,
      backgroundColor: backgroundColor,
      animation: true,
      animationDuration: 1000,
      startAngle: 270,
      percent: progressPercentage / 100,
      center: Container(
        width: containerWidth.r,
        height: containerHeight.r,
        decoration: BoxDecoration(
          color: containerColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: image == ''
              ? Text(
                  '$progressPercentage%',
                  style: TextStyle(
                    color: white,
                    fontSize: fontSize.sp,
                  ),
                )
              : Image.asset(image, width: 40.r, height: 40.r),
        ),
      ),
    );
  }
}
