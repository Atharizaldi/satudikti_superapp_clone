import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServerProblem extends StatelessWidget {
  final bool buttonHide;
  final VoidCallback onPressed;
  final Color? bgColor;
  final ScrollPhysics? physics;

  const ServerProblem({
    Key? key,
    required this.onPressed,
    required this.buttonHide,
    this.bgColor,
    this.physics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor ?? white,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            physics: physics ?? ClampingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/ilus_serverProblem.png',
                  width: 248.w,
                  height: 191.w,
                ),
                SizedBox(height: 20.h),
                Text(
                  'Kesalahan Server',
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Terjadi kesalahan server, silahkan coba lagi\nsetelah beberapa saat',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: neutralCaption,
                  ),
                ),
                SizedBox(height: 24.h),
                GestureDetector(
                  onTap: this.onPressed,
                  child: buttonHide
                      ? Container()
                      : Container(
                          width: 94.w,
                          height: 44.h,
                          decoration: BoxDecoration(
                            color: blue4,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Center(
                            child: Text(
                              'Muat Ulang',
                              style: TextStyle(
                                color: white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
