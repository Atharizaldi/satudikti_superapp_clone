import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final TextStyle? textStyle;
  final Widget? flexibleSpace;
  final Widget? leading;
  final PreferredSizeWidget? bottom;
  final bool? centerTitle;
  final double? paddingBottom;

  const CustomAppBar(
      {Key? key,
      this.title,
      this.titleWidget,
      this.textStyle,
      this.flexibleSpace,
      this.leading,
      this.bottom,
      this.centerTitle,
      this.paddingBottom,
      this.actions = const []})
      : super(key: key);
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle ?? true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: this.leading,
      title: titleWidget ??
          Text(
            this.title ?? "",
            style: textStyle ??
                TextStyle(
                    color: white,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                    fontSize: 20.sp),
          ),
      flexibleSpace: flexibleSpace ??
          Container(
              decoration: BoxDecoration(
            gradient: appBarGradient,
          )),
      bottom: this.bottom,
      actions: this.actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
