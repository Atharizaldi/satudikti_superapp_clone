import 'package:app/presentation/pages/beranda/bima/bima_profile_scrolled_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../component/constant.dart';
import '../../../component/customSliverBar.dart';
import 'component/header_bima.dart';

class BimaLoggedInProfilePage extends StatefulWidget {
  const BimaLoggedInProfilePage({Key? key}) : super(key: key);

  @override
  State<BimaLoggedInProfilePage> createState() => _BimaLoggedInProfilePageState();
}

class _BimaLoggedInProfilePageState extends State<BimaLoggedInProfilePage> {
  @override
  Widget build(BuildContext context) {
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
          expandedHeight: 280.w,
          child: Column(
            children: [
              ProfileScrolledContent(),
            ],
          ),
        ),
      ),
    );
  }
}
