import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/hubungiKamiPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FooterFAQ extends StatelessWidget {
  final double? topPadding;
  final double? bottomPadding;
  const FooterFAQ({Key? key, this.topPadding, this.bottomPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: 160.w,
      // color: Colors.indigo,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: topPadding ?? 30.w,
          ),
          Text(
            'Tidak menemukan informasi yang dibutuhkan?',
            style: TextStyle(color: neutralCaption, fontSize: 12.sp),
          ),
          SizedBox(
            height: 16.w,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HubungiKamiPage(),
                  ));
            },
            child: Text('Hubungi kami',
                style: TextStyle(
                    color: blueLinear1,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: bottomPadding ?? 60.w,
          ),
        ],
      ),
    );
  }
}
