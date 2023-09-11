import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customSliverBar.dart';
import 'package:app/presentation/pages/beranda/sinta/component/appBarWidgetSinta.dart';
import 'package:app/presentation/pages/beranda/sinta/scrolledContent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SintaPage extends StatelessWidget {
  const SintaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(gradient: sliverBgGradient),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: CustomSliverBar(
              expandedHeight: 260.w,
              appBarTitle: "Sinta",
              header: FlexibleSpaceBar(
                background: appBarWidgetSinta(context),
              ),
              child: ScrolledContent(),
            )),
      ),
    );
  }
}
