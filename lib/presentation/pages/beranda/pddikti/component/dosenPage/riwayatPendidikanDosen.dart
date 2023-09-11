import 'package:app/data/source/remote/model/pddikti/dosen/getRiwayatPendidikan.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabPendidikanDosen extends StatelessWidget {
  final RiwayatPendidikan? riwayatPendidikan;
  const TabPendidikanDosen({Key? key, required this.riwayatPendidikan})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: whiteBgPage,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: (riwayatPendidikan != null) ? tableHasilPT(riwayatPendidikan!) :
      _dataTidakDitemukan()
    );
  }

  Widget tableHasilPT(RiwayatPendidikan riwayatPendidikan) {
    return Column(
      children: [
        SizedBox(
          height: 36.h,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 23.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r), color: white),
          child: DataTable(
              headingRowHeight: 40.w,
              columnSpacing: 3.w,
              dataRowHeight: 37.5.w,
              columns: [
                DataColumn(
                  label: Container(
                    width: 14.w,
                    child: Text(
                      "No",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 10.w,
                          color: neutral60,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                DataColumn(
                  label: Container(
                    width: 76.w,
                    child: Text(
                      "Perguruan\nTinggi",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 10.w,
                          color: neutral60,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                DataColumn(
                  label: Container(
                    width: 76.w,
                    child: Text(
                      "Gelar\nAkademik",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 10.w,
                          color: neutral60,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                DataColumn(
                  label: Container(
                    width: 65.w,
                    child: Text(
                      "Tanggal\nIjazah",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 10.w,
                          color: neutral60,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                DataColumn(
                  label: Container(
                    width: 42.w,
                    child: Text(
                      "Jenjang",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 10.w,
                          color: neutral60,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
              rows: listDataRow(riwayatPendidikan)
            // DataRow(cells: [DataCell(Text("Helo")), DataCell(Text("helo2"))]),
            // DataRow(cells: [DataCell(Text("Helo"))])
          ),
        )
      ],
    );
  }

  List<DataRow> listDataRow(RiwayatPendidikan riwayatPendidikan) {
    List<DataRow> list = [];
    for (int index = 0; index < riwayatPendidikan.data.riwayat.length;
    index++) {
      DataRow dataRow =
          DataRow(color: MaterialStateProperty.all(white), cells: [
        DataCell(Container(
          width: 14.w,
          child: Text(
            (index + 1).toString(),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10.sp, color: neutral60),
          ),
        )),
        DataCell(Container(
          width: 76.w,
          child: Text(
            riwayatPendidikan.data.riwayat[index].pt,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10.sp, color: blue4),
          ),
        )),
        DataCell(Container(
            width: 76.w,
            alignment: Alignment.center,
            child: Text(riwayatPendidikan.data.riwayat[index].gelar.singkatan,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: blue4,
                )))),
        DataCell(
          Container(
            width: 65.w,
            child: Text(
              riwayatPendidikan.data.riwayat[index].thnLulus.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10.sp, color: blue4),
            ),
          ),
        ),
        DataCell(
          Container(
            width: 42.w,
            child: Text(
              riwayatPendidikan.data.riwayat[index].jenjangDidik.nama,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10.sp, color: blue3),
            ),
          ),
        ),
      ]);
      list.add(dataRow);
    }
    return list;
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
