import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customSliverBar.dart';
import 'package:app/presentation/component/pop_up_alert/show_pop_up_alert.dart';
import 'package:app/presentation/pages/beranda/sister/ScrolledContent.dart';
import 'package:app/presentation/pages/beranda/sister/component/header_sister.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SisterPage extends StatefulWidget {
  bool init;
  SisterPage({
    Key? key,
    this.init = false,
  }) : super(key: key);

  @override
  State<SisterPage> createState() => _SisterPageState();
}

class _SisterPageState extends State<SisterPage> {
  @override
  void initState() {
    super.initState();
    widget.init = true;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.init)
      Future.delayed(
        Duration(milliseconds: 500),
            () => showPopUpAlert(context, 'SISTER'),
      );

    return Container(
        decoration: BoxDecoration(gradient: sliverBgGradient),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: CustomSliverBar(
              appBarTitle: 'SISTER',
              header: headerSister(context),
              expandedHeight: 250.h,
              child: Column(
                children: [
                  ScrolledContent(),
                ],
              ),
            )));
  }
}
