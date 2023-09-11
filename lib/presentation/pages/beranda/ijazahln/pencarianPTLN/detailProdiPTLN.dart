import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/pages/beranda/ijazahln/pencarianPTLN/bloc/detail_prodi_ptln_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../data/source/remote/model/IjazahLN/verifikasi/prodiPTLN.dart';

class DetailProdiPTLN extends StatelessWidget {
  final String namaPT;

  DetailProdiPTLN({Key? key, required this.namaPT}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBgPage,
      appBar: CustomAppBar(
        titleWidget: Text(
          "Pencarian Perguruan Tinggi LN",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<DetailProdiPtlnBloc, DetailProdiPtlnState>(
        builder: (context, state) {
          if (state is DetailProdiPtlnLoadedState) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 6.h,
                    ),
                    _resultInformation(
                        state.prodiPTLN.data?.prodi?.length ?? 0),
                    SizedBox(
                      height: 8.h,
                    ),
                    _tableHasilProdi(state.prodiPTLN.data?.prodi),
                  ],
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _resultInformation(int jumlahProdi) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText(
          "Program Studi di ‘$namaPT’",
          style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: blue3,
              height: 1.5.sp),
        ),
        SizedBox(
          height: 8.w,
        ),
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: "$jumlahProdi",
              style: TextStyle(fontWeight: FontWeight.bold, color: neutral70)),
          TextSpan(
              text: " Program studi ditemukan",
              style:
                  TextStyle(fontWeight: FontWeight.normal, color: neutral70)),
        ])),
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget _tableHasilProdi(List<Prodi>? listProdi) {
    List<Prodi> list = listProdi ?? [];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 23.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: white,
      ),
      child: DataTable(
          columnSpacing: 6.w,
          columns: [
            DataColumn(
              label: Container(
                width: 32.w,
                child: Text(
                  "No",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 10.w,
                      color: neutral50,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            DataColumn(
              label: Container(
                width: 280.w,
                child: Text(
                  "Nama Program Studi",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 10.w,
                      color: neutral50,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
          rows: list.asMap().entries.map((prodi) {
            return DataRow(cells: [
              DataCell(Container(
                width: 32.w,
                child: Text(
                  (prodi.key + 1).toString(),
                  style: TextStyle(
                      fontSize: 10.sp,
                      color: neutral50,
                      fontWeight: FontWeight.normal),
                ),
              )),
              DataCell(
                Container(
                  width: 280.w,
                  alignment: Alignment.centerLeft,
                  child: SelectableText(
                    prodi.value.namaProdi ?? "-",
                    style: TextStyle(
                        fontSize: 10.sp,
                        color: neutral50,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ]);
          }).toList()),
    );
  }
}
