import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiktiNotFound extends StatelessWidget {
  final String data;
  const DiktiNotFound({ Key? key, required this.data }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/search/search_not_found.png',
              width: 322.w,
            ),
            SizedBox(
              height: screenHeight(context)*(1/10),
            ),
            Text(
              'Data ${this.data} Tidak Ditemukan',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16.sp
              ),
            ),
          ],
        ),
      ),
    );
  }
}