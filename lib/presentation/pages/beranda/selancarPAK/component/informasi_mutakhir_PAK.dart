import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/inkEffect.dart';
import 'package:app/presentation/pages/showWebsite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget informasiMutakhir(BuildContext context) {
  return Container(
    padding: EdgeInsets.only(left: 18.w, right: 18.w),
    width: double.infinity,
    child: InkEffect(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowWebsite(
              title: "Selancar PAK",
              link: 'https://pak.kemdikbud.go.id/portalv2/informasi/',
            ),
          ),
        );
      },
      boxDecoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.r),
            bottomRight: Radius.circular(10.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 0.25,
            blurRadius: 0.6,
            offset: Offset(0, 0.5), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 135.h,
            decoration: BoxDecoration(
              gradient: kedairekaInformasiBgGradient,
              color: neutral100,
              boxShadow: shadow1,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.r),
                topRight: Radius.circular(10.r),
              ),
            ),
            child: Image.asset("assets/kedaireka/btnkedaireka.png"),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 18,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Lihat Informasi Mutakhir",
                  style: TextStyle(
                      color: neutral80,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(height: 8.h),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Informasi Terkini",
                      style: TextStyle(
                        color: Color(0xFF1A689E),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Icon(
                      Icons.navigate_next,
                      color: Color(0xFF1A689E),
                      size: 17.sp,
                    )
                  ],
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ],
      ),
    ),
  );
}
