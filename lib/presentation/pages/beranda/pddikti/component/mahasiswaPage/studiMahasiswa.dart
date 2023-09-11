import 'package:app/data/source/remote/model/pddikti/mahasiswa/getRiwayatStudi.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/card/cardRiwayatStudi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabStudiMahasiswa extends StatelessWidget {
  final RiwayatStudiMahasiswa riwayatStudiMahasiswa;
  const TabStudiMahasiswa({Key? key, required this.riwayatStudiMahasiswa})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  fontWeight: FontWeight.w400,
                  fontSize: 10.sp,
                  color: neutral50),
            ),
          ),
          SizedBox(
            height: 20.w,
          ),
        ],
      );
    }

    if (riwayatStudiMahasiswa.data.mahasiswa[0].semester.id == 0) {
      return _dataTidakDitemukan();
    } else {
      return Container(
        width: double.infinity,
        color: whiteBgPage,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 17.h),
        child: ListView.separated(
          itemCount: riwayatStudiMahasiswa.data.mahasiswa.length,
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 20.h,
            );
          },
          itemBuilder: (context, index) {
            return CardRiwayatStudi(
              kodeMK: riwayatStudiMahasiswa.data.mahasiswa[index].kodeMk,
              namaMK: riwayatStudiMahasiswa.data.mahasiswa[index].namaMk,
              namaPT: riwayatStudiMahasiswa.data.mahasiswa[index].pt.nama,
              smt: riwayatStudiMahasiswa.data.mahasiswa[index].semester.id
                  .toString(),
              sks: riwayatStudiMahasiswa.data.mahasiswa[index].sks == ""
                  ? riwayatStudiMahasiswa.data.mahasiswa[index].sks
                  : riwayatStudiMahasiswa.data.mahasiswa[index].sks
                      .substring(0, 1),
            );
          },
        ),
      );
    }
  }
}
