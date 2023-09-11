import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentReview extends StatefulWidget {
  final String name;
  final String detail;
  final String date;
  final int star;

  const CommentReview(
      {Key? key,
      required this.date,
      required this.detail,
      required this.name,
      required this.star})
      : super(key: key);

  @override
  State<CommentReview> createState() => _CommentReviewState();
}

class _CommentReviewState extends State<CommentReview> {
  var children;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 16.w),
      color: Colors.transparent,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(32 / 2.r),
                child: widget.name == ''
                    ? Container()
                    : Container(
                        color: Color.fromRGBO(196, 196, 196, 1),
                        width: 32.w,
                        height: 32.w,
                        child: Image.asset(
                          'assets/silemkerma.png',
                          width: 32.w,
                          height: 32.w,
                        ),
                      ),
              ),
              SizedBox(
                width: 7.w,
              ),
              Text(
                widget.name,
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(43, 46, 60, 1),
                    fontFamily: "Plus Jakarta Sans"),
              )
            ],
          ),
          // Icon(
          //   Icons.star_rate_rounded,
          //   size: 20,
          //   color: Color.fromRGBO(243, 215, 95, 1),
          // );
          widget.name == ''
              ? Container()
              : Row(
                  children: [
                    for (int i = 0; i < widget.star; i++)
                      Icon(
                        Icons.star_rate_rounded,
                        size: 20,
                        color: Color.fromRGBO(243, 215, 95, 1),
                      ),
                    for (int i = 0; i < (5 - widget.star); i++)
                      Icon(
                        Icons.star_rate_rounded,
                        size: 20,
                        color: Color.fromRGBO(237, 236, 236, 1),
                      ),
                    SizedBox(width: 5.w),
                    Text(
                      widget.date,
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(153, 153, 153, 1),
                          fontFamily: "Plus Jakarta Sans"),
                    )
                  ],
                ),
          Container(
            padding: EdgeInsets.only(left: 8.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.detail,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(77, 77, 77, 1),
                    fontFamily: "Plus Jakarta Sans"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
