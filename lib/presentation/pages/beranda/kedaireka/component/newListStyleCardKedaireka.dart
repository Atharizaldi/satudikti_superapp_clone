import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewListStyleKedaireka extends StatelessWidget {
  final VoidCallback function;
  final double heightSpace;
  final dynamic image;
  final String? title, subTitle;
  const NewListStyleKedaireka(
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
        padding: EdgeInsets.only(left: 16.w, right: 17.w),
        child: Ink(
          width: double.infinity,
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
            onTap: function,
            customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r)),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 17.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 20, bottom: 20, right: 20),
                        child: Container(
                          // height: 64,
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFFF8F9FD),
                                    borderRadius: BorderRadius.circular(8.r)),
                                // width: 64,
                                // height: 64,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 16,
                                          bottom: 12,
                                          left: 8,
                                          right: 9),
                                      child: Container(
                                        height: 36.w,
                                        width: 47.w,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(this.image))),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 29,
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 26.0),
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          maxLines: 2,
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                          this.subTitle.toString(),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12.sp,
                                              color: neutral40),
                                        )
                                      ],
                                    ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
