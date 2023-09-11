import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/getAgregatPT.dart';
import 'package:app/presentation/component/bannerSubJudul.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabDaftarJabatanFungsional extends StatelessWidget {
  final GetAgregatPT? getAgregatPT;
  final bool haveAgregat;
  const TabDaftarJabatanFungsional(
      {Key? key, this.getAgregatPT, required this.haveAgregat})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();
    return Container(
      width: double.infinity,
      color: whiteBgPage,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth(context) * (1 / 30),
        // vertical: screenHeight(context) * (1 / 50)
      ),
      child: RawScrollbar(
        thickness: 0,
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                // height: screenHeight(context) * 0.37,
                // color: Colors.amber,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 36.h,
                    ),
                    BannerSubJudul(
                      subJudul: 'Dosen Tetap',
                      warna: blue3,
                      edgeInsets: EdgeInsets.zero,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    haveAgregat
                        ? this
                                    .getAgregatPT!
                                    .data
                                    .agregatDosen
                                    .dosenTetap
                                    .jabatan
                                    .length ==
                                0
                            ? _dataTidakDitemukan()
                            : tableHasilPT(listDataRow(this
                                .getAgregatPT!
                                .data
                                .agregatDosen
                                .dosenTetap))
                        : _dataTidakDitemukan()
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight(context) * (1 / 30),
              ),
              Container(
                width: double.infinity,
                // height: screenHeight(context) * 0.37,
                // color: Colors.amber,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BannerSubJudul(
                      subJudul: 'Dosen Tidak Tetap',
                      warna: blue3,
                      edgeInsets: EdgeInsets.zero,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    haveAgregat
                        ? this
                                    .getAgregatPT!
                                    .data
                                    .agregatDosen
                                    .dosenTidakTetap
                                    .jabatan
                                    .length ==
                                0
                            ? _dataTidakDitemukan()
                            : tableHasilPT(listDataRow(this
                                .getAgregatPT!
                                .data
                                .agregatDosen
                                .dosenTidakTetap))
                        : _dataTidakDitemukan(),
                    SizedBox(
                      height: 100.h,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget tableHasilPT(List<DataRow> listRows) {
    return Container(
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
                  "Jabatan Fungsional",
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
                  "Jumlah",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 10.w,
                      color: neutral60,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
          rows: listRows
          // DataRow(cells: [DataCell(Text("Helo")), DataCell(Text("helo2"))]),
          // DataRow(cells: [DataCell(Text("Helo"))])
          ),
    );
  }

  List<DataRow> listDataRow(dynamic dosen) {
    List<DataRow> list = [];
    for (int index = 0; index < dosen.jabatan.length; index++) {
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
            dosen.jabatan[index].nama,
            style: TextStyle(fontSize: 10.sp, color: blue4),
          ),
        )),
        DataCell(
          Container(
            width: 70.w,
            alignment: Alignment.center,
            child: Text(
              dosen.jabatan[index].jumlahDosen.toString(),
              style: TextStyle(fontSize: 10.sp, color: neutral60),
            ),
          ),
        )
      ]);
      list.add(dataRow);
    }
    return list;
  }

  Padding _dataTidakDitemukan() {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 17.w),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: dataTidakDitemukanPDDikti,
            borderRadius: BorderRadius.circular(10.r)),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 17.w, top: 17.w, bottom: 17.w),
              child: Container(
                child: Image.asset(
                  'assets/km/tutup.png',
                  height: 67.w,
                  width: 104.w,
                ),
              ),
            ),
            SizedBox(
              width: 26.w,
            ),
            Flexible(
              child: Text(
                "Tidak ada data untuk ditampilkan",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    color: neutral40),
              ),
            )
          ],
        ),
      ),
    );
  }
}
