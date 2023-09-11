import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCircularProgress extends StatelessWidget {
  const CustomCircularProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 50.w,
        height: 50.w,
        child: CircularProgressIndicator(
          color: Colors.black,
        ));
  }
}
