import 'package:app/data/source/remote/model/pddikti/dosen/getRiwayatMengajar.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/card/cardRiwayatStudi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabMengajarDosen extends StatelessWidget {
  final RiwayatMengajar? riwayatMengajar;
  const TabMengajarDosen({Key? key, required this.riwayatMengajar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: whiteBgPage,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 17.h),
      child: (riwayatMengajar != null) ? buildListView(riwayatMengajar!) :
      _dataTidakDitemukan(),
    );
  }
  Widget buildListView(RiwayatMengajar riwayatMengajar) {
    ScrollController _scrollController = ScrollController();
    return ListView.separated(
      controller: _scrollController,
      itemCount: riwayatMengajar.data.riwayat.length,
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 20.h,
        );
      },
      itemBuilder: (context, index) {
        return CardRiwayatStudi(
          kodeMK: riwayatMengajar.data.riwayat[index].kodeMk,
          namaMK: riwayatMengajar.data.riwayat[index].namaMk,
          namaPT: riwayatMengajar.data.riwayat[index].pt.nama,
          sks: riwayatMengajar.data.riwayat[index].sksAjar.substring(0, 1),
          smt: riwayatMengajar.data.riwayat[index].semester.toString(),
        );
      },
    );
  }
  Column _dataTidakDitemukan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30.w,
        ),
        Center(
          child: Image.asset(
            'assets/km/tutup.png',
            width: 190.w,
            height: 122.w,
          ),
        ),
        SizedBox(
          height: 30.w,
        ),
        Center(
          child: Text(
            "Data yang ditampilkan tidak ditemukan",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w400, fontSize: 10.sp, color: neutral50),
          ),
        ),
        SizedBox(
          height: 20.w,
        ),
      ],
    );
  }
}
