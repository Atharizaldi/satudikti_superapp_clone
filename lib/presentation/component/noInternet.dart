import 'dart:async';

import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoInternet extends StatefulWidget {
  final bool buttonHide;
  final VoidCallback onPressed;
  final Color? bgColor;
  final ScrollPhysics? physics;
  const NoInternet({
    Key? key,
    required this.onPressed,
    required this.buttonHide,
    this.bgColor,
    this.physics,
  }) : super(key: key);

  @override
  State<NoInternet> createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    isLoading = false;
  }

  void startLoading() {
    setState(() {
      isLoading = true;
    });

    Timer(Duration(seconds: 5), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.bgColor ?? white,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            physics: widget.physics,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/ilus_connectionLost.png',
                  width: 248.w,
                  height: 191.w,
                ),
                SizedBox(height: 20.h),
                Text(
                  'Ups, Koneksi Internet Terputus',
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  'Silahkan periksa koneksi internet anda',
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: neutral80),
                ),
                SizedBox(
                  height: 36.h,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      startLoading();
                    });
                    widget.onPressed();
                  },
                  child: widget.buttonHide
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
                              'Coba lagi',
                              style: TextStyle(
                                color: white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ),
                ),
                if (isLoading)
                  Column(
                    children: [
                      SizedBox(
                        height: 20.w,
                      ),
                      CircularProgressIndicator(),
                    ],
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
