import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../component/constant.dart';
import 'daftar_usulan_bima/daftar_usulan_bima.dart';

class LihatDetail extends StatelessWidget {
  const LihatDetail({Key? key, required this.function}) : super(key: key);

  final VoidCallback function;

  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: IntrinsicHeight(
        child: GestureDetector(
          onTap: this.function,
          child: Container(
            margin: EdgeInsets.only(top: 4.h),
            height: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DaftarUsulanBima(),
                      ),
                    );
                  },
                  child: Text(
                    'Lihat Detail',
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: biruMuda2,
                        fontFamily: 'Plus Jakarta Sans'),
                  ),
                ),
                SizedBox(
                  width: 6.w,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: biruMuda2,
                  size: 12.sp,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
