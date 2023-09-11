import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CircularPersentase extends StatelessWidget {
  final double persen;

  Widget? info;
  CircularPersentase({Key? key, required this.persen, this.info }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double doublePersen = 0.0 + (persen / 100);
    String stringPersen = persen.toString().replaceAll('.0', ' ') + "%";
    return Container(
      child: Stack(
        children: [
          CircularPercentIndicator(
            lineWidth: 4,
            radius: 43.w,
            percent: doublePersen,
            startAngle: 270,
            // fillColor: Colors.black,
            backgroundColor: Colors.transparent,
            progressColor: Color.fromRGBO(0, 190, 130, 1),
            center: Container(
              width: 72.w,
              height: 72.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 190, 130, 1),
                  borderRadius: BorderRadius.circular(72.w / 2)),
              child: info != null? info :  Container(
                  child: Text(
                stringPersen,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontFamily: "Plus Jakarta Sans"),
              )),
            ),
          )
        ],
      ),
    );
  }
}
