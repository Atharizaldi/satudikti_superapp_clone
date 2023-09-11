import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/inkEffect.dart';
import 'package:app/presentation/pages/showWebsite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget bannerInformasi(BuildContext context, idx) {
  return InkEffect(
    boxDecoration: BoxDecoration(
        gradient: appBarGradient,
        color: white,
        borderRadius: BorderRadius.circular(10.r)),
    onTap: () {
      if (idx == 1) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShowWebsite(
                title: "Kedaireka",
                link: 'https://kedaireka.id/landing-innovator',
              ),
            ));
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShowWebsite(
                title: "Kedaireka",
                link: 'https://kedaireka.id/landing',
              ),
            ));
      }
    },
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 17.0, left: 16, bottom: 19.5),
          child: Image(
            width: 66.w,
            height: 66.h,
            image: AssetImage("assets/kedaireka/icon_banner_info_kedaireka.png")
            )
        ),
        SizedBox(
          width: 16.sp,
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(
              right: 20.0,
            ),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Ingin mencari Informasi menarik lainnya?",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        color: white,
                        fontSize: 14.sp,
                        height: 1.5,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    "Pelajari Selengkapnya >",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        color: white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget bannerInformasiTerkait (BuildContext context){
  return Container(
    padding: EdgeInsets.only(left: 18.w, right: 18.w),
    width: double.infinity,
    child: InkEffect(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShowWebsite(
                title: "Kedaireka",
                link: 'https://kedaireka.id/matchingfund',
              ),
            ));
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
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.r),
                  topRight: Radius.circular(10.r)),
            ),
            child: Image.asset("assets/kedaireka/kedaireka2.png"),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 18,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Informasi Kolaborasi Kedaireka",
                  style: TextStyle(
                      color: neutral80,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(height: 8.h),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Lihat informasi kedaireka",
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

Widget bannerInformasiGaruda(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
    child: InkEffect(
      boxDecoration: BoxDecoration(
        color: white,
        gradient: berandaHubungiButtonGradient,
        borderRadius: BorderRadius.circular(10.r),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShowWebsite(
                title: "Statistik",
                link: 'https://garuda.kemdikbud.go.id/home/graphic',
              ),
            ));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Container(
          width: double.infinity,
          height: 96.w,
          child: Row(
            children: [
              Image.asset(
                'assets/km/icons/statistik_icon.png',
                height: 64.w,
                width: 64.w,
              ),
              SizedBox(width: 12.w),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Lihat mengenai statistik Garuda',
                      style: TextStyle(
                        color: white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        height: 1.5.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
