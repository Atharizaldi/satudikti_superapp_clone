import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Accordion extends StatefulWidget {
  final String title;
  final String content;

  Accordion({
    required this.title,
    required this.content,
  });

  @override
  _AccordionState createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  bool _showContent = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _showContent = !_showContent;
            });
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: white,
              borderRadius: _showContent
                  ? BorderRadius.only(
                      topLeft: Radius.circular(10.r),
                      topRight: Radius.circular(10.r),
                    )
                  : BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.02),
                  offset: Offset(0, 4),
                  blurRadius: 6,
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          color: blue2,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          // letterSpacing: 0.05.sp,
                          height: 1.28,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Icon(
                  _showContent
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: abu6,
                ),
              ],
            ),
          ),
        ),
        AnimatedContainer(
          duration: Duration(seconds: 0),
          curve: Curves.fastLinearToSlowEaseIn,
          constraints: _showContent
              ? BoxConstraints()
              : BoxConstraints(
                  maxHeight: 0,
                ),
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.r),
              bottomRight: Radius.circular(10.r),
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.02),
                offset: Offset(0, 4),
                blurRadius: 6,
              )
            ],
          ),
          child: Html(
            data: widget.content,
            style: {
              "body": Style(
                color: neutral70,
                fontSize: FontSize(14.sp),
                fontWeight: FontWeight.w500,
                // letterSpacing: 0.8.sp,
                lineHeight: LineHeight.number(1.285),
              ),
            },
          ),
        ),
      ],
    );
  }
}
