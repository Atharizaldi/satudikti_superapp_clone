import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Usulandiprosescard extends StatefulWidget {
  const Usulandiprosescard(
      {Key? key,
      required this.statususulan,
      required this.deskripsiusulan,
      required this.gambarstatus})
      : super(key: key);

  final String statususulan;
  final String deskripsiusulan;
  final String gambarstatus;

  @override
  State<Usulandiprosescard> createState() => _UsulandiprosescardState();
}

class _UsulandiprosescardState extends State<Usulandiprosescard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330.w,
      height: 131.h,
      padding: EdgeInsets.only(top: 20, left: 14, right: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xffecfdf3),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Container(
              width: 290.w,
              height: 99.h,
              padding:
                  EdgeInsets.only(top: 16, left: 20, bottom: 16, right: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 99.h,
                    width: 160.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: Text(
                          widget.statususulan,
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff00be82),
                          ),
                        )),
                        Container(
                            child: Text(
                          widget.deskripsiusulan,
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff4d4d4d),
                          ),
                        )),
                      ],
                    ),
                  ),
                  Container(
                    child: Expanded(
                      child: Image.network(
                        widget.gambarstatus,
                        width: 96.w,
                        height: 96.h,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
