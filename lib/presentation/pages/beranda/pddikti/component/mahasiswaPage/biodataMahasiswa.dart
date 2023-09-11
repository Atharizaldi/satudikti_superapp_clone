import 'package:app/common/semesterParser.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/card/cardDeskripsiTabView.dart';
import 'package:flutter/material.dart';

class TabBiodataMahasiswa extends StatelessWidget {
  final String jKelamin, jenjang, smtAwal, statusAwal, statusSaatIni;
  const TabBiodataMahasiswa(
      {Key? key,
      required this.jKelamin,
      required this.jenjang,
      required this.smtAwal,
      required this.statusAwal,
      required this.statusSaatIni})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: screenHeight(context) * (1 / 40)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CardDeskripsiTabView(
                heading1: 'Jenis Kelamin',
                heading2: switchKelamin(this.jKelamin),
              ),
              SizedBox(
                width: screenWidth(context) * (1 / 30),
              ),
              CardDeskripsiTabView(
                heading1: 'Jenjang',
                heading2: this.jenjang,
              ),
            ],
          ),
          SizedBox(
            height: screenWidth(context) * (1 / 30),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CardDeskripsiTabView(
                heading1: 'Semester Awal',
                heading2: switchSemester(this.smtAwal),
              ),
              SizedBox(
                width: screenWidth(context) * (1 / 30),
              ),
              CardDeskripsiTabView(
                heading1: 'Status Awal\nMahasiswa',
                heading2: this.statusAwal,
              ),
            ],
          ),
          SizedBox(
            height: screenWidth(context) * (1 / 30),
          ),
          CardDeskripsiTabView(
            heading1: 'Status Mahasiswa\nSaat Ini',
            heading2: this.statusSaatIni,
            colorHeading2: switchStatusColor(this.statusSaatIni),
          ),
        ],
      ),
    );
  }

  Color switchStatusColor(String status) {
    if (status == "Aktif")
      return green3;
    else if (status == "Belum Lulus")
      return yellow;
    else if (status == "Mengundurkan Diri")
      return red;
    else
      return blue4;
  }

  dynamic switchKelamin(String jKelamin) {
    switch (jKelamin) {
      case 'L':
        return 'Laki-laki';
      case 'P':
        return 'Perempuan';
      default:
    }
  }
}
