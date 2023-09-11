import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../sister/component/tabbarviewsister.dart';
import 'component/status_usulan.dart';

class DetailUsulanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text('Detail Usulan Penelitian'),
          ),
          body: SingleChildScrollView(
            child: Column(
            children: [
              SizedBox(height: 20.h),
            TabBarViewSister(data: [
              {
              'nama': 'Skema',
              'info': '-',
              },
              {
                'nama': 'Judul',
                'info': '-',
              },
              {
                'nama': 'Tahun Pelaksanaan',
                'info': '-',
              },
              {
                'nama': 'Makro Riset',
                'info': '-',
              },
              {
                'nama': 'Peran',
                'info': '-',
              },
              {
                'nama': 'Status Usulan',
                'info': '-',
              },
              ],),
              SizedBox(height: 16),
              Container(
                alignment: AlignmentDirectional.topStart,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Text("Status Usulan",
                      style: TextStyle( fontSize: 20, fontWeight: FontWeight.w700, fontFamily: 'Plus Jakarta Sans'),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Text("Progress yang diajukan",
                      style: TextStyle(fontFamily: 'Plus Jakarta Sans', fontWeight: FontWeight.w400, fontSize: 14),),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Container(
                width: 358.w,
                height: 551.h,
                padding: EdgeInsets.only(left: 16, right: 16),

                child: StatusUsulan(statususulan: "Ditolak",
                  tanggaltahappertama: "21 Juni 2023",
                  jamtahappertama: "21.30",
                  deskripsitahappertama: "Lanjut ke tahap berikutnya",
                  statustahappertama:"Dilanjutkan",
                  tanggaltahapkedua: "21 Juni 2023",
                  jamtahapkedua: "21.30",
                  deskripsitahapkedua: "Lanjut ke tahap berikutnya",
                  statustahapkedua: "Dilanjutkan",
                  tanggaltahapketiga: "21 Juni 2023",
                  jamtahapketiga: "21.30",
                  deskripsitahapketiga:"Lanjut ke tahap berikutnya",
                  statustahaketiga: "Dilanjutkan",
                  tanggaltahapkeempat: "21 Juni 2023",
                  jamtahapkeempat: "21.30",
                  deskripsitahapkeempat: "Lanjut ke tahap berikutnya",
                  statustahapkeempat: "Dilanjutkan",
              ),
              ),
            ],
          ),
        ),
    )
    );
  }

}