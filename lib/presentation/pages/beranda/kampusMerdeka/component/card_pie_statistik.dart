import 'dart:io';

import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class CardStatistikPie extends StatefulWidget {
  final String judul;
  final Widget jenisStatistik;
  CardStatistikPie(
      {Key? key, required this.judul, required this.jenisStatistik})
      : super(key: key);

  @override
  _CardStatistikPieState createState() => _CardStatistikPieState();
}

class _CardStatistikPieState extends State<CardStatistikPie> {
  InAppWebViewController? inAppWebViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      android: AndroidInAppWebViewOptions(
    builtInZoomControls: true,
  ));

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    if (Platform.isAndroid) {
      AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // double statisticH = double.infinity;

    return Container(
        width: screenWidth(context) * 0.94,
        // height: 900,
        margin: EdgeInsets.only(bottom: screenHeight(context) * (1 / 30)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: white,
            boxShadow: [
              BoxShadow(
                  offset: Offset.zero,
                  color: neutralCaption.withOpacity(0.05),
                  blurRadius: 5,
                  spreadRadius: 8)
            ]),
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth(context) * (1 / 30),
            vertical: screenHeight(context) * (1 / 50)),
        child: widget.jenisStatistik);
  }
}
