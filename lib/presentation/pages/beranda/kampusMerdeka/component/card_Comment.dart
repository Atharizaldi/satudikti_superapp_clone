import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../component/constant.dart';

class CommentCKM extends StatefulWidget {
  const CommentCKM(
      {Key? key,
      required this.name,
      required this.date,
      required this.detailComment,
      required this.imageURL})
      : super(key: key);

  final String name;
  final String date;
  final String detailComment;
  final String imageURL;

  @override
  State<CommentCKM> createState() => _CommentCKMState();
}

class _CommentCKMState extends State<CommentCKM> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.imageURL),
              ),
              SizedBox(
                width: 13.w,
              ),
              Text(
                widget.name,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(43, 46, 60, 1),
                  fontFamily: 'Plus Jakarta Sans',
                ),
              ),
              SizedBox(
                width: 13.w,
              ),
              Text(
                //'${FormatDate.formatDateStatic(this.date)}'
                widget.date,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: neutral40,
                  fontFamily: 'Plus Jakarta Sans',
                ),
              )
            ],
          ),
          SizedBox(
            height: 18.h,
          ),
          Text(
            widget.detailComment,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: neutral70,
              fontFamily: 'Plus Jakarta Sans',
            ),
          )
        ],
      ),
    );
  }
}
