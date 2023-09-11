import 'package:app/presentation/component/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBarFilterGaruda extends StatefulWidget {
  final TextEditingController? controller;
  final double yMargin, xPadding;
  final Color iconColor;
  final bool openKeyboard, iconAction;
  final Function(String)? isSubmitted;
  final String hintText;
  final double? customHeight;
  final List<BoxShadow>? boxShadowList;
  const SearchBarFilterGaruda({
    Key? key,
    required this.yMargin,
    required this.xPadding,
    required this.iconColor,
    required this.openKeyboard,
    this.controller,
    required this.iconAction,
    this.isSubmitted,
    this.customHeight,
    this.boxShadowList,
    required this.hintText,
  }) : super(key: key);

  @override
  _SearchBarFilterGarudaState createState() => _SearchBarFilterGarudaState();
}

class _SearchBarFilterGarudaState extends State<SearchBarFilterGaruda> {
  bool isPaper = false;
  bool isJurnal = false;
  bool isConference = false;
  bool isSubject = false;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.customHeight ?? 80.3.w,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth(context) * (widget.xPadding), vertical: 18.w),
      margin: EdgeInsets.symmetric(
        vertical: widget.yMargin,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.sp),
        boxShadow: widget.boxShadowList ??
            [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.02),
                offset: Offset(0, 2.sp),
                blurRadius: 6.sp,
              )
            ],
      ),
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
                margin: EdgeInsets.only(left: 20.77.w),
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
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return StatefulBuilder(
                          builder: (BuildContext context, setState) =>
                              SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.h, vertical: 30.h),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Center(
                                        child: Text(
                                      'Filter Pencarian',
                                      style: TextStyle(fontSize: 18.sp),
                                    )),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    CheckboxListTile(
                                        contentPadding:
                                            EdgeInsets.only(left: 4),
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        title: Text("All"),
                                        value: isChecked,
                                        onChanged: (val) {
                                          setState(() {
                                            setState(() {
                                              if (isPaper &&
                                                  isJurnal &&
                                                  isConference &&
                                                  isSubject) {
                                                isPaper = false;
                                                isJurnal = false;
                                                isConference = false;
                                                isSubject = false;
                                                isChecked = false;
                                              } else {
                                                isPaper = true;
                                                isJurnal = true;
                                                isConference = true;
                                                isSubject = true;
                                                isChecked = true;
                                              }
                                            });
                                          });
                                        }),
                                    CheckboxListTile(
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        title: Text("Paper"),
                                        value: isPaper,
                                        selected: isPaper,
                                        onChanged: (val) {
                                          setState(() {
                                            isPaper = !isPaper;
                                          });
                                        }),
                                    CheckboxListTile(
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        title: Text("Jurnal"),
                                        value: isJurnal,
                                        selected: isJurnal,
                                        onChanged: (val) {
                                          setState(() {
                                            isJurnal = !isJurnal;
                                          });
                                        }),
                                    CheckboxListTile(
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        title: Text("Conference"),
                                        value: isConference,
                                        selected: isConference,
                                        onChanged: (val) {
                                          setState(() {
                                            isConference = !isConference;
                                          });
                                        }),
                                    CheckboxListTile(
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        title: Text("Subject"),
                                        value: isSubject,
                                        selected: isSubject,
                                        onChanged: (val) {
                                          setState(() {
                                            isSubject = !isSubject;
                                          });
                                        }),
                                    SizedBox(
                                      height: 20.w,
                                    ),
                                    GestureDetector(
                                      onTap: () => Navigator.pop(context),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          height: 36.w,
                                          width: 141.w,
                                          decoration: BoxDecoration(
                                              color: blue4,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Center(
                                            child: Text(
                                              'Filter',
                                              style: TextStyle(
                                                  color: white,
                                                  fontSize: 14.sp,
                                                  letterSpacing: 1,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  icon: Image.asset(
                    'assets/icons/icon_filter.png',
                    width: 20.w,
                    color: abu6,
                  ),
                ),
              )
            : SizedBox(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
          color: white,
        ),
      ),
    );
  }
}
