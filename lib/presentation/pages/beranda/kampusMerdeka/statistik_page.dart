import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/pages/beranda/kampusMerdeka/component/kampus_merdeka_graphs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatistikPage extends StatelessWidget {
  final String data;

  const StatistikPage({Key? key, required this.data }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBgPage,
      appBar: CustomAppBar(title: 'Statistik'),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(
            top: 28.w,
            left: 16.w,
            right: 16.w,
            bottom: 52.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Statistik Kampus Merdeka',
                style: styleSubJudul,
              ),
              SizedBox(height: 12.w),
              Text(
                'Berikut adalah data statistik pada Kampus Merdeka',
                style: styleSubJudul2,
              ),
              SizedBox(height: 20.w),
              displayGraph()
            ],
          ),
        ),
      ),
    );
  }

  Widget displayGraph(){
    if(data == "mahasiswa"){
      return firstGraph();
    }else if(data == "dosen"){
      return secondGraph();
    }else{
      return thirdGraph();
    }
  }
}
