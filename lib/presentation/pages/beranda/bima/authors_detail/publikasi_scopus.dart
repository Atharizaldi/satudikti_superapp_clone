import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/pages/beranda/bima/component/card_scopus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PublikasiScopus extends StatelessWidget {
  PublikasiScopus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBgPage,
      appBar: CustomAppBar(
        title: "Publikasi Scopus",
      ),
      body: Container(
        color: whiteBgPage,
        margin: EdgeInsets.symmetric(vertical: 16.w, horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  // itemCount: listJenisProgram.length,
                  itemCount: 8,
                  itemBuilder: (buildContext, index) {
                    return Column(
                      children: [
                        CardScopus(
                            title:
                                'The role of pentoxifylline in preventing contrast-induced nephropathy in coronary angiography/intervention - systematic review, meta-analysis, and meta-regression of randomized controlled trials',
                            deskripsi:
                                'European Review for Medical and Pharmacological Sciences',
                            creator: 'Rahmadi A.R.',
                            quartiles: 'Q2',
                            cited: 0),
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
