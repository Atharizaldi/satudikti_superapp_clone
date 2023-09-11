import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccordionKeselarasan extends StatefulWidget {
  final String title, content;

  AccordionKeselarasan({required this.title, required this.content});

  @override
  _AccordionKeselarasanState createState() => _AccordionKeselarasanState();
}

class _AccordionKeselarasanState extends State<AccordionKeselarasan> {
  bool _showContent = false;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
                    topLeft: Radius.circular(8.r),
                    topRight: Radius.circular(8.r),
                  )
                : BorderRadius.circular(8.r),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.02),
                offset: Offset(0, 4),
                blurRadius: 6,
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            color: blue3,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                            letterSpacing: -0.5.sp,
                          ),
                        ),
                      ]),
                ),
              ),
              SizedBox(width: 10.w),
              Icon(
                _showContent
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: blue4,
                size: 30.sp,
              ),
            ],
          ),
        ),
      ),
      Container(
        constraints: _showContent
            ? BoxConstraints()
            : BoxConstraints(
                maxHeight: 0,
              ),
        padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8.r),
            bottomRight: Radius.circular(8.r),
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.02),
              offset: Offset(0, 4),
              blurRadius: 6,
            )
          ],
        ),
        child: Container(
            decoration: BoxDecoration(
              color: biruMuda5,
              borderRadius: BorderRadius.circular(12.r),
            ),
            padding: EdgeInsets.all(16),
            child: Text(
              widget.content,
              textAlign: TextAlign.justify,
              style: TextStyle(
                  color: neutral70,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  letterSpacing: -0.6.sp,
                  height: 1.5),
            )),
      )
    ]);
  }
}
