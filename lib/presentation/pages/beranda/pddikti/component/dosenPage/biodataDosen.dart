import 'package:app/data/source/remote/model/pddikti/dosen/getDetailDosen.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/card/cardDeskripsiTabView.dart';
import 'package:flutter/material.dart';

class TabBiodataDosen extends StatelessWidget {
  final GetDetailDosen detailDosen;
  const TabBiodataDosen({Key? key, required this.detailDosen})
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
                heading2: switchKelamin(detailDosen.data.dosen[0].jenisKelamin),
              ),
              SizedBox(
                width: screenWidth(context) * (1 / 30),
              ),
              CardDeskripsiTabView(
                heading1: 'Pendidikan Tertinggi',
                heading2: detailDosen.data.dosen[0].pendidikanTerakhir == ""
                    ? ' - '
                    : detailDosen.data.dosen[0].pendidikanTerakhir,
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
                heading1: 'Jabatan Fungsional',
                heading2: detailDosen.data.dosen[0].jabatanFungsional.nama == ""
                    ? " - "
                    : detailDosen.data.dosen[0].jabatanFungsional.nama,
              ),
              SizedBox(
                width: screenWidth(context) * (1 / 30),
              ),
              CardDeskripsiTabView(
                heading1: 'Status Ikatan Kerja',
                heading2: detailDosen.data.dosen[0].ikatanKerja.nama == ""
                    ? ' - '
                    : detailDosen.data.dosen[0].ikatanKerja.nama,
              ),
            ],
          ),
          SizedBox(
            height: screenWidth(context) * (1 / 30),
          ),
          CardDeskripsiTabView(
            heading1: 'Status Aktivitas',
            heading2: detailDosen.data.dosen[0].statusKeaktifan.nama == ""
                ? ' - '
                : detailDosen.data.dosen[0].statusKeaktifan.nama,
          ),
        ],
      ),
    );
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
