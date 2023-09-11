import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardKontak extends StatelessWidget {
  final String jalan, telepon, faks, email, website;
  const CardKontak({ 
    Key? key, 
    required this.jalan, 
    required this.telepon, 
    required this.faks, 
    required this.email, 
    required this.website }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 25.w,
        right: 25.w,
        top: 25.h,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 15.w
      ),
      decoration: BoxDecoration(
        color: abu5,
        borderRadius: BorderRadius.circular(5)
      ),
      child: Column(
        children: [
          //JALAN===========================
          this.jalan.length > 3 ?
          Container(
            margin: EdgeInsets.only(
              bottom: 25.h
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/pddikti/icon/Subtract.png'
                ),
                Container(
                  width: 253.w,
                  height: 34.h,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    this.jalan,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ) : Container(),
          //TELEPON===========================
          this.telepon.length > 3 ?
          Container(
            margin: EdgeInsets.only(
              bottom: 25.h
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/pddikti/icon/el_phone-alt.png'
                ),
                Container(
                  width: 253.w,
                  height: 34.h,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    this.telepon,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ) : Container(),
          //FAKS===========================
          this.faks.length > 3 ?
          Container(
            margin: EdgeInsets.only(
              bottom: 25.h
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/pddikti/icon/fa_fax.png'
                ),
                Container(
                  width: 253.w,
                  height: 34.h,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    this.faks,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ) : Container(),
          //EMAIL===========================
          this.email.length > 3 ?
          Container(
            margin: EdgeInsets.only(
              bottom: 25.h
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/pddikti/icon/Group 971.png'
                ),
                Container(
                  width: 253.w,
                  height: 34.h,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    this.email,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ) : Container(),
          //WEBSITE===========================
          this.jalan.length > 3 ?
          Container(
            margin: EdgeInsets.only(
              bottom: 25.h
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/pddikti/icon/Group 11.png'
                ),
                Container(
                  width: 253.w,
                  height: 34.h,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    this.website,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ) : Container(),
        ],
      ),
    );
  }
}