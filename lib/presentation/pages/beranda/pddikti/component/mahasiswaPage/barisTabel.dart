import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';

class BarisTabel extends StatelessWidget {
  final String no, semester, status, sks;
  const BarisTabel(
      {Key? key,
      required this.no,
      required this.semester,
      required this.status,
      required this.sks})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
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
                  style: TextStyle(
                      fontSize: screenWidth(context) * (1 / 25),
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: double.infinity,
                width: screenWidth(context) * (1 / 2.6),
                child: Text(
                  this.semester,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: screenWidth(context) * (1 / 25)),
                ),
              ),
              Container(
                height: double.infinity,
                width: screenWidth(context) * (1 / 4),
                child: Text(
                  this.status,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: screenWidth(context) * (1 / 25)),
                ),
              ),
              Container(
                height: double.infinity,
                width: screenWidth(context) * (1 / 5.9),
                child: Text(
                  this.sks,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: screenWidth(context) * (1 / 25)),
                ),
              )
            ],
          ),
        ),
        Divider(
          color: neutral100,
          thickness: 1,
        )
      ],
    );
  }
}
