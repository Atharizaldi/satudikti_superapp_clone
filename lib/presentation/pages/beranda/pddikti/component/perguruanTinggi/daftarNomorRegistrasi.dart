import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/getAgregatPT.dart';
import 'package:app/presentation/component/bannerSubJudul.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabDaftarNomorRegistrasi extends StatelessWidget {
  final GetAgregatPT? getAgregatPT;
  final bool haveAgregat;
  const TabDaftarNomorRegistrasi(
      {Key? key, this.getAgregatPT, required this.haveAgregat})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();
    return Container(
      color: whiteBgPage,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      child: RawScrollbar(
        thickness: 0,
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              SizedBox(
                height: 36.h,
              ),
              Container(
                width: double.infinity,
                child: Column(
                  children: [
                    BannerSubJudul(
                      subJudul: 'Dosen Tetap',
                      warna: blue3,
                      edgeInsets: EdgeInsets.zero,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          haveAgregat
                              ? this
                                          .getAgregatPT!
                                          .data
                                          .agregatDosen
                                          .dosenTetap
                                          .registrasi
                                          .length ==
                                      0
                                  ? _dataTidakDitemukan()
                                  : tableHasilPT(
                                      listDataRow(this
                                          .getAgregatPT!
                                          .data
                                          .agregatDosen
                                          .dosenTetap),
                                    )
                              : Center(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Text(
                                        'Tidak ada data yang terdaftar',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ],
                                  ),
                                )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                // color: Colors.amber,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.w,
                    ),
                    BannerSubJudul(
                        subJudul: "Dosen Tidak Tetap",
                        warna: blue3,
                        edgeInsets: EdgeInsets.zero),
                    SizedBox(
                      height: 20.h,
                    ),
                    haveAgregat
                        ? this
                                    .getAgregatPT!
                                    .data
                                    .agregatDosen
                                    .dosenTidakTetap
                                    .registrasi
                                    .length ==
                                0
                            ? _dataTidakDitemukan()
                            : tableHasilPT(listDataRow(this
                                .getAgregatPT!
                                .data
                                .agregatDosen
                                .dosenTidakTetap))
                        : Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 8.h,
                                ),
                                Text(
                                  'Tidak ada data yang terdaftar',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          )
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
            ],
          ),
        ),
      ),
    );
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
                  "Nomor Registrasi",
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

    for (int index = 0; index < dosen.registrasi.length; index++) {
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
            dosen.registrasi[index].nama,
            style: TextStyle(fontSize: 10.sp, color: blue4),
          ),
        )),
        DataCell(
          Container(
            width: 70.w,
            alignment: Alignment.center,
            child: Text(
              dosen.registrasi[index].jumlahDosen.toString(),
              style: TextStyle(fontSize: 10.sp, color: neutral60),
            ),
          ),
        )
      ]);
      list.add(dataRow);
    }
    return list;
  }
}
