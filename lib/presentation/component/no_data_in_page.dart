import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoDataInPage extends StatelessWidget {
  final String text;
  const NoDataInPage({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 26.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        gradient: LinearGradient(
          colors: [Color(0xffFFFAFA), Color(0xffE6E6E6).withOpacity(0.2)],
        ),
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/km/tutup.png",
            width: 87.w,
            height: 56.w,
          ),
          SizedBox(
            width: 20.w,
          ),
          Flexible(
            child: Text(
              text,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }
}
