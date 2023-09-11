import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DataTidakDitemukan extends StatelessWidget {
  final String message;
  const DataTidakDitemukan({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            'assets/km/tutup.png',
            width: 190.w,
            height: 122.w,
          ),
        ),
        SizedBox(
          height: 30.w,
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Tidak ada usulan yang berstatus",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 10.sp,
                    color: neutral50),
              ),
              Text(
                " $message",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10.sp,
                    color: neutral50),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20.w,
        ),
      ],
    );
  }
}
