import 'dart:typed_data';

import 'package:app/data/source/remote/model/profil/user_detail_information.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/profile_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hex/hex.dart';

class LoggedInCard extends StatelessWidget {
  final UserInformationDetail userInformationDetail;
  final String avatar;
  const LoggedInCard({Key? key, required this.avatar,required this.userInformationDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.w),
      padding: EdgeInsets.symmetric(horizontal: 30.sp, vertical: 20.w),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(151, 151, 151, 0.06),
            offset: Offset(0, 4),
            blurRadius: 15,
            spreadRadius: 10,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [ // card avatar
          avatar == ""
          ? Container(
              alignment: Alignment.center,
              child : CircleAvatar(
                        backgroundImage: AssetImage(
                          defaultProfilePhoto(role: userInformationDetail.role!, gender: userInformationDetail.jenisKelamin!),
                        ),
                        radius: 32.w,
                      )
            )
          : Container(
            alignment : Alignment.center,
            child : CircleAvatar(
                      backgroundImage: MemoryImage(
                        Uint8List.fromList(HEX.decode(avatar)),
                      ),
                      radius: 32.w,
                    )
          ),
          SizedBox(
            width: 20.w,
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userInformationDetail.nama!,
                  style: TextStyle(
                    color: blue4,
                    fontWeight: FontWeight.w700,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  userInformationDetail.namaPT!,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  'NIDN/NIP/NIDK: ${userInformationDetail.nidn!}',
                  style: TextStyle(
                    color: teksAbuCerah4,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
