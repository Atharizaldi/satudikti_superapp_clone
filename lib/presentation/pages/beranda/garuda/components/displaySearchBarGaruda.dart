import 'package:app/presentation/component/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBarGaruda extends StatefulWidget {
  final TextEditingController? controller;
  final Color iconColor;
  final bool openKeyboard, iconAction;
  final Function(String)? isSubmitted;
  final String hintText;
  const SearchBarGaruda({
    Key? key,
    required this.iconColor,
    required this.openKeyboard,
    this.controller,
    required this.iconAction,
    this.isSubmitted,
    required this.hintText,
  }) : super(key: key);

  @override
  State<SearchBarGaruda> createState() => _SearchBarGarudaState();
}

class _SearchBarGarudaState extends State<SearchBarGaruda> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 17.w, right: 17.w),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.04),
                offset: Offset(0, 2),
                blurRadius: 6,
              )
            ],
            color: white),
        height: 52,
        width: double.infinity,
        child: CupertinoTextField(
          style: TextStyle(
            fontSize: 14.sp,
          ),
          controller: widget.controller,
          autofocus: widget.openKeyboard,
          onSubmitted: widget.isSubmitted,
          textInputAction: TextInputAction.search,
          textAlignVertical: TextAlignVertical.center,
          placeholder: widget.hintText,
          placeholderStyle: TextStyle(
            color: neutralCaption,
          ),
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          prefix: widget.iconAction
              ? SizedBox()
              : Container(
                  padding: EdgeInsets.only(left: 20.77.w),
                  child: Image.asset(
                    'assets/icons/search_active.png',
                    width: 20.w,
                    color: abu6,
                  ),
                ),
          suffix: widget.iconAction
              ? Container(
                  margin: EdgeInsets.only(right: 10.w),
                  child: IconButton(
                    onPressed: () {
                      (widget.controller)!.clear();
                    },
                    icon: Icon(
                      Icons.clear,
                      color: widget.iconColor,
                      size: 20.w,
                    ),
                  ),
                )
              : SizedBox(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.sp),
            color: white,
          ),
        ),
      ),
    );
  }
}
