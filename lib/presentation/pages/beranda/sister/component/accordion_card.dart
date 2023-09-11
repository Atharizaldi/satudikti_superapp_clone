import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/inkEffect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccordionCard extends StatefulWidget {
  final String title;
  final List<Map<String, String>> content;
  final VoidCallback? onTapButton;

  final String date;
  bool isButton;

  AccordionCard({
    required this.title,
    required this.content,
    required this.date,
    this.isButton = false,
    this.onTapButton,
  });

  @override
  _AccordionState createState() => _AccordionState();
}

class _AccordionState extends State<AccordionCard> {
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
          margin: EdgeInsets.symmetric(horizontal: 16.w),
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
          padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 12.w),
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
                            color: neutral100,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            letterSpacing: 0.05.sp,
                            height: 1.28,
                          ),
                        ),
                        widget.date != ''
                            ? Column(children: [
                                SizedBox(height: 8.h),
                                Text(
                                  widget.date,
                                  style: TextStyle(
                                    color: neutral40,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ])
                            : SizedBox(),
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
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        constraints: _showContent
            ? BoxConstraints()
            : BoxConstraints(
                maxHeight: 0,
              ),
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
        decoration: BoxDecoration(
          borderRadius: widget.isButton == false
              ? BorderRadius.only(
                  bottomLeft: Radius.circular(10.r),
                  bottomRight: Radius.circular(10.r),
                )
              : null,
          color: white,
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
          child: Column(
            children: [
              // Isi content depends on API
              for (final item in widget.content)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.w),
                  child: rowContentDetail(item['nama']!, item['info']!),
                ),
              SizedBox(height: 8.h),
              // rowContentDetail(),
            ],
          ),
        ),
      ),
      if (widget.isButton == true && _showContent)
        Align(
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 10.w),
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.r),
                    bottomRight: Radius.circular(10.r),
                  )),
              margin: EdgeInsets.symmetric(horizontal: 15.w),
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: InkEffect(
                  onTap: widget.onTapButton!,
                  child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 91.w, vertical: 10.h),
                      child: Text("Download Sertifikat",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Plus Jakarta Sans",
                            color: white,
                          )),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(36, 141, 218, 1))),
                ),
              ),
            )),
    ]);
  }

  Widget rowContentDetail(String nama, String info) {
    return Row(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              nama,
              style: TextStyle(
                  fontSize: 14.sp, fontWeight: FontWeight.w600, color: blue4),
            ),
          ),
        ),
        Expanded(
            child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            info.toString(),
            textAlign: TextAlign.end,
            style: TextStyle(
                fontSize: 13.5.sp,
                fontWeight: FontWeight.w500,
                color: neutral80),
          ),
        ))
      ],
    );
  }
}
