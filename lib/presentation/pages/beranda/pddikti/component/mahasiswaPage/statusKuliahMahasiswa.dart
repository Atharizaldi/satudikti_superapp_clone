import 'package:app/common/semesterParser.dart';
import 'package:app/data/source/remote/model/pddikti/mahasiswa/getRiwayatStatusKuliah.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabStatusKuliahMahasiswa extends StatelessWidget {
  final RiwayatStatusKuliah? riwayatStatusKuliah;
  TabStatusKuliahMahasiswa({Key? key, required this.riwayatStatusKuliah})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: SingleChildScrollView(
          child: (riwayatStatusKuliah != null)
              ? tableHasilPT(riwayatStatusKuliah!)
              : _dataTidakDitemukan()),
    );
  }

  Widget tableHasilPT(RiwayatStatusKuliah riwayatStatusKuliah) {
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
              columnSpacing: 12.w,
              dataRowHeight: 37.5.w,
              columns: [
                DataColumn(
                  label: Container(
                    width: 24.w,
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
                    width: 110.w,
                    child: Text(
                      "Semester",
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
                    width: 70.w,
                    child: Text(
                      "Status",
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
                    width: 30.w,
                    child: Text(
                      "SKS",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 10.w,
                          color: neutral60,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
              rows: listDataRow()
              // DataRow(cells: [DataCell(Text("Helo")), DataCell(Text("helo2"))]),
              // DataRow(cells: [DataCell(Text("Helo"))])
              ),
        )
      ],
    );
  }

  List<DataRow> listDataRow() {
    List<DataRow> list = [];
    if (riwayatStatusKuliah != null) {
      for (int index = 0;
          index < riwayatStatusKuliah!.data.mahasiswa.length;
          index++) {
        DataRow dataRow =
            DataRow(color: MaterialStateProperty.all(white), cells: [
          DataCell(Container(
            width: 24.w,
            child: Text(
              (index + 1).toString(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10.sp, color: neutral60),
            ),
          )),
          DataCell(Container(
            width: 110.w,
            child: Text(
              switchSemester(riwayatStatusKuliah!
                  .data.mahasiswa[index].semester.id
                  .toString()),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10.sp, color: blue4),
            ),
          )),
          DataCell(Container(
              width: 70.w,
              alignment: Alignment.center,
              child: Text(
                  riwayatStatusKuliah!.data.mahasiswa[index].statusAktif.nama,
                  style: TextStyle(
                      fontSize: 10.sp,
                      color: switchColorStatus(riwayatStatusKuliah!
                          .data.mahasiswa[index].statusAktif.nama
                          .toString()))))),
          DataCell(Container(
              width: 30.w,
              child: Text(
                  riwayatStatusKuliah!.data.mahasiswa[index].sks.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10.sp, color: blue4))))
        ]);
        list.add(dataRow);
      }
    }

    return list;
  }

  Color switchColorStatus(String status) {
    if (status.trim() == "Aktif" || status.trim() == "Lulus")
      return green3;
    else
      return red;
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
