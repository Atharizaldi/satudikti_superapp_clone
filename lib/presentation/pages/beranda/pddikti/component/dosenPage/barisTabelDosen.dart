import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';

class BarisTabelDosen extends StatelessWidget {
  final String no, pt, gelar, tanggal, jenjang;
  const BarisTabelDosen(
      {Key? key,
      required this.no,
      required this.pt,
      required this.gelar,
      required this.tanggal,
      required this.jenjang})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: screenHeight(context) * (1 / 60)),
      padding: EdgeInsets.only(bottom: screenHeight(context) * (1 / 60)),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: neutral100, width: 1))),
      child: Row(
        children: [
          Container(
            width: screenWidth(context) * (1 / 8),
            child: Text(
              this.no,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: screenWidth(context) * (1 / 30)),
            ),
          ),
          Container(
            width: screenWidth(context) * (1 / 4.3),
            child: Text(
              this.pt,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: screenWidth(context) * (1 / 30)),
            ),
          ),
          Container(
            width: screenWidth(context) * (1 / 4.3),
            child: Text(
              this.gelar,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: screenWidth(context) * (1 / 30)),
            ),
          ),
          Container(
            width: screenWidth(context) * (1 / 5.9),
            child: Text(
              this.tanggal,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: screenWidth(context) * (1 / 30)),
            ),
          ),
          Container(
            width: screenWidth(context) * (1 / 5.9),
            child: Text(
              this.jenjang,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: screenWidth(context) * (1 / 30)),
            ),
          )
        ],
      ),
    );
  }
}
