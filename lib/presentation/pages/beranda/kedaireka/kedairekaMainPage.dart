import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customSliverBar.dart';
import 'package:app/presentation/pages/beranda/kedaireka/tujuankedaireka.dart';
import 'package:app/presentation/pages/beranda/kedaireka/widgetlistdraggable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KedairekaMainPage extends StatefulWidget {
  @override
  State<KedairekaMainPage> createState() => _KedairekaMainPageState();
}

class _KedairekaMainPageState extends State<KedairekaMainPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: sliverBgGradient),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: CustomSliverBar(
              expandedHeight: 260.h,
              header: FlexibleSpaceBar(
                background: _header(),
              ),
              child: SingleChildScrollView(
                child: listDraggableHome(context),
              ),
              appBarTitle: "Kedaireka")),
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(gradient: sliverBgGradient),
      child: Stack(
        children: [
          Positioned(
            top: 60.h,
            left: 164.w,
            right: 0.w,
            bottom: -50.h,
            child: Opacity(
              opacity: 0.75,
              child: Image.asset(
                'assets/kedaireka/ilustrasi_header.png',
                width: 259.w,
                height: 259.h,
              ),
            ),
          ),
          Positioned(
            bottom: 45.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 30.w),
                  child: Container(
                    height: 31.w,
                    width: 100.w,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/kedaireka/icon_fix_kedaireka.png")),
                        borderRadius: BorderRadius.circular(10.r),
                        color: white),
                  ),
                ),
                SizedBox(
                  height: 12.w,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30.w),
                  child: Container(
                    width: 199.w,
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                'Raih Matching Fund dari\npemerintah Indonesia\nsebesar total Rp',
                            style: TextStyle(
                                color: white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp),
                          ),
                          TextSpan(
                            text: ' 1 Triliyun',
                            style: TextStyle(
                                color: Color(0xffFBD106),
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp),
                          ),
                          TextSpan(
                            text: '!',
                            style: TextStyle(
                              color: white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 14.w),
                Padding(
                  padding: EdgeInsets.only(left: 30.w),
                  child: Container(
                    width: 199.w,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TujuanKedaireka(),
                          ),
                        );
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              width: 189.w,
                              height: 40.h,
                              padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.r),
                                  color: bgPelajariSelengkapnya
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Pelajari Selengkapnya",
                                    style: stylePelajariSelengkapnya,
                                    textAlign: TextAlign.center,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                    size: 14.h,
                                  )

                                ],)
                          ),
                          SizedBox(width: 8.w),
                        ],
                      ),
                    ),
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
