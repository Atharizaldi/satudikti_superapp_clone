import 'package:app/common/regex.dart';
import 'package:app/presentation/component/SkeletonLoading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class MajalahPopulerCard extends StatefulWidget {
  const MajalahPopulerCard(
      {Key? key,
      required this.imageURL,
      required this.judulMajalah,
      required this.penilaian,
      required this.review,
      required this.description,
      required this.onTap})
      : super(key: key);
  final VoidCallback onTap;
  final String imageURL;
  final String judulMajalah;
  final double penilaian;
  final int review;
  final String description;

  @override
  State<MajalahPopulerCard> createState() => _MajalahPopulerCardState();
}

class _MajalahPopulerCardState extends State<MajalahPopulerCard> {
  @override
  Widget build(BuildContext context) {
    var _review = NumberFormat.compact().format(widget.review);
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color(0x1A5C5E61),
          spreadRadius: -4,
          blurRadius: 16,
          offset: Offset(0, 16), // changes position of shadow
        ),
      ]),

      padding: EdgeInsets.fromLTRB(10.w, 10.w, 10.w, 0),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),


          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: 16.w,
                      left: 16.w,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Image.network(
                        widget.imageURL,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return SkeletonLoading(width: 107.w, height: 144.w);
                        },
                        width: 107.w,
                        height: 144.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Column(
                      children: [
                        Container(
                          // width: 169.w,
                          padding: EdgeInsets.only(
                              top: 16.w, right: 29.w, left: 10.w, bottom: 16.w),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              widget.judulMajalah,
                              maxLines: 3,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.only(left: 12, right: 10),
                            child: Row(
                              children: <Widget>[
                                Container(
                                    padding:
                                        EdgeInsets.only(left: 12, right: 10),
                                    child: Column(children: [
                                      Container(
                                        child: Text(
                                          "Penilaian",
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontFamily: 'Plus Jakarta Sans',
                                              fontWeight: FontWeight.w400,
                                              color: Color.fromRGBO(
                                                  128, 128, 128, 1)),
                                        ),
                                      ),
                                      Container(
                                          child: Row(
                                        children: [
                                          Container(
                                            width: 15.w,
                                            height: 14.8.h,
                                            child: Image.asset(
                                                'assets/gmagz/star_sign.png'),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(left: 5),
                                            child: Text(
                                              widget.penilaian.toString(),
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily:
                                                      "Plus Jakarta Sans",
                                                  color: Color.fromRGBO(
                                                      58, 53, 78, 1)),
                                            ),
                                          ),
                                        ],
                                      ))
                                    ])),
                                Container(
                                  height: 50.h,
                                  padding: EdgeInsets.only(top: 12),
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                      'assets/gmagz/vector_line.png'),
                                ),
                                Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Column(children: [
                                      Container(
                                        child: Text("Review",
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontFamily: 'Plus Jakarta Sans',
                                                fontWeight: FontWeight.w400,
                                                color: Color.fromRGBO(
                                                    128, 128, 128, 1))),
                                      ),
                                      Container(
                                        child: Text(
                                          _review.toString(),
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "Plus Jakarta Sans",
                                              color: Color.fromRGBO(
                                                  58, 53, 78, 1)),
                                        ),
                                      )
                                    ])),
                              ],
                            ))
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(16.w),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    removeHtmlTags(widget.description),
                    maxLines: 3,
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 14.sp,
                        fontFamily: 'Plus Jakarta Sans',
                        fontWeight: FontWeight.w400),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
