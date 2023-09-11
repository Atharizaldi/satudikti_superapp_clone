import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CustomSlidingPannel extends StatelessWidget {
  final Widget? child;
  final double? maxPercentageHeight;
  final double? minPercentageHeight;
  final bool showRectanglePullBar;
  final Color? bgColor;
  const CustomSlidingPannel(
      {Key? key,
      this.child,
      this.maxPercentageHeight,
      this.minPercentageHeight,
      this.showRectanglePullBar = true,
      this.bgColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SlidingUpPanel(
      color: bgColor ?? whiteBgPage,
      parallaxEnabled: true,
      maxHeight: size.height * (maxPercentageHeight ?? 1.h),
      minHeight: size.height * (minPercentageHeight ?? 0.7.h),
      panelBuilder: (controller) {
        return SingleChildScrollView(
            controller: controller,
            child: Column(
              children: [
                SizedBox(
                  height: 12,
                ),
                showRectanglePullBar
                    ? Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 30,
                          height: 2,
                          color: neutral20,
                        ),
                      )
                    : SizedBox(
                        height: 2,
                      ),
                child ?? SizedBox()
              ],
            ));
      },
      borderRadius: BorderRadius.vertical(top: Radius.circular(10.r)),
    );
  }
}
