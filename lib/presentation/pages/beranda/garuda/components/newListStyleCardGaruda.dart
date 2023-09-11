import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truncate/truncate.dart';

class NewListStyleGaruda extends StatelessWidget {
  final VoidCallback? function;
  final double heightSpace;
  final dynamic image;
  final String? title, subTitle;
  const NewListStyleGaruda(
      {Key? key,
      required this.heightSpace,
      required this.function,
      required this.image,
      required this.title,
      required this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w),
        child: Ink(
          // height: 121.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 0.25,
                blurRadius: 0.6,
                offset: Offset(0, 0.5), // changes position of shadow
              ),
            ],
            color: white,
          ),
          child: InkWell(
            customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r)),
            onTap: function,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: 20.h, bottom: 20.h, left: 19.w, right: 19.w),
                  child: Container(
                    height: 81.h,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 64.h,
                          width: 64.w,
                          decoration: BoxDecoration(
                              color: Color(0xFFF8F9FD),
                              borderRadius: BorderRadius.circular(8.r),
                              image: DecorationImage(
                                  image: AssetImage(this.image))),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Flexible(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: this.heightSpace,
                                ),
                                Text(
                                  this.title.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: blue4,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                Text(
                                  this.subTitle.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.sp,
                                      color: neutral40),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NewListStyleGarudaJurnal extends StatelessWidget {
  final VoidCallback? function;
  final double heightSpace;
  final dynamic image;
  final String? title, subTitle;
  const NewListStyleGarudaJurnal(
      {Key? key,
      required this.heightSpace,
      required this.function,
      required this.image,
      required this.title,
      required this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w),
        child: Ink(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 0.25,
                  blurRadius: 0.6,
                  offset: Offset(0, 0.5), // changes position of shadow
                ),
              ],
              color: white),
          child: InkWell(
            onTap: function,
            customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r)),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: 20.h, bottom: 20.h, left: 19.w, right: 19.w),
                  child: Container(
                    // height: 102.h,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            color: Color(0xffC0F0FF),
                          ),
                          height: 83.h,
                          width: 64.w,
                          child: Container(
                            height: 61.h,
                            width: 60.w,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(this.image))),
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Flexible(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: this.heightSpace,
                                ),
                                Text(
                                  this.title.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: blue4,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 3,
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                Text(
                                  this.subTitle.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 12.sp,
                                      color: neutral40),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NewListStyleGarudaJurnalSearch extends StatelessWidget {
  final VoidCallback? function;
  final double heightSpace;
  final dynamic image;
  final String? title, subTitle, ssn;
  final List<String> listTagName;

  const NewListStyleGarudaJurnalSearch(
      {Key? key,
      required this.heightSpace,
      required this.function,
      required this.image,
      required this.title,
      required this.subTitle,
      required this.ssn,
      required this.listTagName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w),
        child: Ink(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 0.25,
                  blurRadius: 0.6,
                  offset: Offset(0, 0.5), // changes position of shadow
                ),
              ],
              color: white),
          child: InkWell(
            onTap: function,
            customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r)),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: 20.h, bottom: 20.h, left: 19.w, right: 19.w),
                  child: Container(
                    // height: 150.h,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            color: Color(0xffC0F0FF),
                          ),
                          height: 83.h,
                          width: 64.w,
                          child: Container(
                            height: 61.h,
                            width: 60.w,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(this.image))),
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Flexible(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: this.heightSpace,
                                ),
                                SelectableText(
                                  truncate(this.title.toString(), 70),
                                  onTap: function,
                                  enableInteractiveSelection: false,
                                  //overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: blue4,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 3,
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                SelectableText(
                                  truncate(this.subTitle.toString(), 50),
                                  onTap: function,
                                  enableInteractiveSelection: false,
                                  //overflow: TextOverflow.ellipsis,
                                  //maxLines: 2,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 12.sp,
                                      color: neutral40),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                SelectableText(
                                  truncate(
                                      this.ssn.toString() == ""
                                          ? " - "
                                          : "Jurnal ISSN : " +
                                              this.ssn.toString(),
                                      40),
                                  onTap: function,
                                  enableInteractiveSelection: false,
                                  //overflow: TextOverflow.ellipsis,
                                  //maxLines: 2,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 12.sp,
                                      color: neutral40),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Wrap(
                                  spacing: 6.w,
                                  runSpacing: 10.h,
                                  children: this
                                      .listTagName
                                      .map((e) => _listTag(e))
                                      .toList(),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _listTag(String areaName) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        border: Border.all(color: green3),
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Text(
        areaName,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w200,
          color: green3,
        ),
      ),
    );
  }
}

class NewListStyleGarudaPaperSearch extends StatelessWidget {
  final VoidCallback? function;
  final double heightSpace;
  final String? title, subTitle, judulJurnal, univ;
  const NewListStyleGarudaPaperSearch(
      {Key? key,
      required this.heightSpace,
      required this.function,
      required this.title,
      required this.subTitle,
      required this.judulJurnal,
      required this.univ})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w),
        child: Ink(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 0.25,
                  blurRadius: 0.6,
                  offset: Offset(0, 0.5), // changes position of shadow
                ),
              ],
              color: white),
          child: InkWell(
            customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r)),
            onTap: function,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: 20.h, bottom: 20.h, left: 20.w, right: 20.w),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 5.0.w),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: this.heightSpace,
                                ),
                                SelectableText(
                                  truncate(this.title.toString(), 70),
                                  onTap: function,
                                  enableInteractiveSelection: false,
                                  //overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: blue4,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold),
                                  //maxLines: 2,
                                ),
                                // SizedBox(
                                //   height: 16.h,
                                // ),
                                // SelectableText(
                                //   truncate(this.subTitle.toString(), 70),
                                //   onTap: function,
                                //   enableInteractiveSelection: false,
                                //   //overflow: TextOverflow.ellipsis,
                                //   //maxLines: 2,
                                //   style: TextStyle(
                                //       fontWeight: FontWeight.w500,
                                //       fontSize: 12.sp,
                                //       color: neutral50),
                                // ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                SelectableText(
                                  truncate(this.judulJurnal.toString(), 70),
                                  onTap: function,
                                  enableInteractiveSelection: false,
                                  // overflow: TextOverflow.ellipsis,
                                  // maxLines: 2,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 12.sp,
                                      color: teksAbuCerah4),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                SelectableText(
                                  truncate(this.univ.toString(), 70),
                                  onTap: function,
                                  enableInteractiveSelection: false,
                                  // overflow: TextOverflow.ellipsis,
                                  // maxLines: 2,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 12.sp,
                                      color: teksAbuCerah4),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
