import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';

class BarisTabelProdi extends StatelessWidget {
  final String no, nama, pendidikan;
  const BarisTabelProdi({
    Key? key,
    required this.no,
    required this.nama,
    required this.pendidikan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // color: white,
      height: screenHeight(context) * (1 / 20),
      margin: EdgeInsets.only(top: screenHeight(context) * (1 / 60)),
      child: Row(
        children: [
          Container(
            height: double.infinity,
            width: screenWidth(context) * (1 / 8),
            child: Text(
              this.no,
              textAlign: TextAlign.center,
              style: tableTextStyle,
            ),
          ),
          Container(
            height: double.infinity,
            width: screenWidth(context) * (1 / 2.6),
            child: Text(
              this.nama,
              textAlign: TextAlign.left,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: tableTextStyle,
            ),
          ),
          Container(
            height: double.infinity,
            width: screenWidth(context) * (1 / 3),
            child: Text(
              this.pendidikan,
              textAlign: TextAlign.right,
              style: tableTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
