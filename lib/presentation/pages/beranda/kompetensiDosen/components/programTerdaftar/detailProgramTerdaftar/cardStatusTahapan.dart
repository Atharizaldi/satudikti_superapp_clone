import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

class CardStatusTahapan extends StatefulWidget {
  final String status;
  const CardStatusTahapan({Key? key, required this.status}) : super(key: key);

  @override
  State<CardStatusTahapan> createState() => _CardStatusTahapanState();
}

class _CardStatusTahapanState extends State<CardStatusTahapan> {
  Color _switchColor(String status) {
    status = status.toLowerCase();

    if (status == "lolos") {
      return green3;
    } else if (status == "tidak lolos") {
      return red;
    } else if (status == "kode tidak valid") {
      return lightRed;
    } else if (status == "sedang diproses") {
      return orange2;
    } else if (status == "belum ditentukan") {
      return biruMuda1;
    } else {
      return blue4;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.sp),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          color: _switchColor(widget.status)),
      child: Text(
        widget.status.capitalize(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w200,
            letterSpacing: 0.08.sp,
            color: white),
      ),
    );

    // return Container(
    //   width: 358.w,
    //   padding: EdgeInsets.symmetric(horizontal: 27.w, vertical: 33.5.sp),
    //   decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(10.r),
    //       color: _switchColor(widget.status)),
    //   child: AnimatedOpacity(
    //     opacity: _isAnimated ? 1.0 : 0.0,
    //     duration: const Duration(milliseconds: 500),
    //     child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
    //       Image.asset(
    //         _switchAsset(widget.status),
    //         width: 41.w,
    //         height: 41.w,
    //       ),
    //       SizedBox(
    //         width: 20.w,
    //       ),
    //       Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Text(
    //             "Status Tahapan",
    //             style: styleSubJudul2.copyWith(color: white),
    //           ),
    //           SizedBox(
    //             height: 8.w,
    //           ),
    //           Text(
    //             widget.status,
    //             style: styleGraphSubHeader.copyWith(color: white),
    //           ),
    //         ],
    //       )
    //     ]),
    //   ),
    // );
  }
}
