import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/component/accordion_keselarasan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CekTracerKeselarasan extends StatefulWidget {
  const CekTracerKeselarasan({
    Key? key,
  }) : super(key: key);

  @override
  State<CekTracerKeselarasan> createState() => _CekTracerKeselarasanState();
}

class _CekTracerKeselarasanState extends State<CekTracerKeselarasan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteBgPage,
        appBar: AppBar(
          title: Text("Statistik"),
        ),
        body: Container(
            margin: EdgeInsets.symmetric(vertical: 16.h),
            child: AccordionKeselarasan(
                title: "Apa itu Keselarasan Horizontal?",
                content:
                    "Keselarasan Horizontal merupakan tingkat kesesuaian hubungan antara bidang pekerjaan alumni dengan bidang ilmu/program studi yang bersangkutan. \n\nGrafik di bawah ini menampilkan jumlah keselarasan data alumni dari seluruh program studi pada Universitas Indonesia")));
  }
}
