import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customSliverBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../component/pop_up_alert/show_pop_up_alert.dart';
import 'bima_scrolled_content.dart';
import 'component/header_bima.dart';

class BimaPage extends StatefulWidget {
  const BimaPage({Key? key}) : super(key: key);

  @override
  State<BimaPage> createState() => _BimaPageState();
}

class _BimaPageState extends State<BimaPage> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(
        Duration(microseconds: 500), () => showPopUpAlert(context, 'BIMA'));
    return Container(
      color: blueLinear2,
      // decoration: BoxDecoration(gradient: sliverBgGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomSliverBar(
          appBarTitle: 'BIMA',
          header: FlexibleSpaceBar(
            background: headerBima(context),
          ),
          expandedHeight: 250.h,
          child: Column(
            children: [
              ScrolledContent(),
            ],
          ),
        ),
      ),
    );
  }
}
