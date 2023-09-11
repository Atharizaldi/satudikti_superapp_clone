import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardProfileBIMA extends StatelessWidget {
  CardProfileBIMA(
      {Key? key,
      required this.namaUser,
      required this.namaKampus,
      required this.nidn,
      required this.imageURL,
      this.sintaID = ''})
      : super(key: key);

  final String namaUser;
  final String namaKampus;
  final int nidn;
  final String imageURL;
  String sintaID;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A5C5E61),
            spreadRadius: -4,
            blurRadius: 16,
            offset: Offset(0, 12), // changes position of shadow
          ),
          BoxShadow(
            color: Color(0x0D5C5E61),
            spreadRadius: -2,
            blurRadius: 6,
            offset: Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 30.r,
              backgroundImage: NetworkImage(imageURL),
            ),
            SizedBox(
              width: 20.w,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  sintaID == ''
                      ? Container()
                      : Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 2.h, horizontal: 8.w),
                          decoration: BoxDecoration(
                              color: Color(0xFFF2F4F7),
                              borderRadius: BorderRadius.circular(16.r)),
                          child: Text('Sinta ID : $sintaID')),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    namaUser,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: biruMuda2,
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    namaKampus,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    'NIDN /NIP /NIDK : $nidn',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: teksAbuCerah4,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
