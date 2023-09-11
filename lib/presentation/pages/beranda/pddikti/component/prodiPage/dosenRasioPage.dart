import 'package:app/data/source/remote/model/pddikti/prodi/getRasioMhsDosen.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabDosenRasioPage extends StatelessWidget {
  final GetRasioMhsDosen? getRasioMhsDosen;
  const TabDosenRasioPage({Key? key, required this.getRasioMhsDosen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        color: whiteBgPage,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: (getRasioMhsDosen != null)
            ? tableHasilPT(getRasioMhsDosen!)
            : _dataTidakDitemukan());
  }

  Widget tableHasilPT(GetRasioMhsDosen getRasioMhsDosen) {
    return Column(
      children: [
        SizedBox(
          height: 36.h,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 20.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r), color: white),
          child: DataTable(
              columnSpacing: 6.w,
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
                    width: 180.w,
                    child: Text(
                      "Tahun",
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
                      "Rasio",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 10.w,
                          color: neutral60,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
              rows: listDataRow(getRasioMhsDosen)
              // DataRow(cells: [DataCell(Text("Helo")), DataCell(Text("helo2"))]),
              // DataRow(cells: [DataCell(Text("Helo"))])
              ),
        )
      ],
    );
  }

  List<DataRow> listDataRow(GetRasioMhsDosen getRasioMhsDosen) {
    List<DataRow> list = [];
    for (int index = 0; index < getRasioMhsDosen.data.rasio.length; index++) {
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
          width: 180.w,
          child: Text(
            getRasioMhsDosen.data.rasio[index].tahun,
            style: TextStyle(fontSize: 10.sp, color: blue4),
          ),
        )),
        DataCell(
          Container(
            width: 70.w,
            alignment: Alignment.center,
            child: Text(
              getRasioMhsDosen.data.rasio[index].rasio,
              style: TextStyle(fontSize: 10.sp, color: neutral60),
            ),
          ),
        )
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
