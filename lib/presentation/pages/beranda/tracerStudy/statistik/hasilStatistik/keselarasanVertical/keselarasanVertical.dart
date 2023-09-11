import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/component/server_problem.dart';
import 'package:app/presentation/pages/beranda/sivil/component/bts_component.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/component/accordion_keselarasan.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/statistik/hasilStatistik/bloc/statistik_bloc.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/statistik/hasilStatistik/bloc/statistik_state.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/statistik/hasilStatistik/keselarasanHorizontal/keselarasanHorizontal.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KeselarasanVertical extends StatefulWidget {
  final String? kodePt, namaPt;

    const KeselarasanVertical({Key? key, this.kodePt, this.namaPt}) : super(key: key);

  @override
  State<KeselarasanVertical> createState() => _KeselarasanVerticalState();
}

class _KeselarasanVerticalState extends State<KeselarasanVertical> {
  late StatistikTracerBloc _statistikTracerBloc;

  @override
  Widget build(BuildContext context) {
    _statistikTracerBloc = BlocProvider.of<StatistikTracerBloc>(context);
    return BlocBuilder<StatistikTracerBloc, StatistikTracerState>(
        builder: (context, state) {
      if (state is StatistikTracerLoadingState) {
        return Center(
          child: CircularProgressIndicator(
            color: blueLinear1,
          ),
        );
      } else if (state is StatistikTracerLoadedState) {
        final List<PieData> data = [
          PieData(
              name: state.verticalPie.data.series[0].data![0][0],
              value: state.verticalPie.data.series[0].data![0][1],
              color: Color(0xff008FFB)),
          PieData(
              name: state.verticalPie.data.series[0].data![1][0],
              value: state.verticalPie.data.series[0].data![1][1],
              color: Color(0xff00E396)),
          PieData(
              name: state.verticalPie.data.series[0].data![2][0],
              value: state.verticalPie.data.series[0].data![2][1],
              color: Color(0xffff9800)),
        ];

        List<PieChartSectionData> sectionData = data
            .asMap()
            .map<int, PieChartSectionData>((index, data) {
              final value = PieChartSectionData(
                  radius: 110.h,
                  color: data.color,
                  value: data.value.toDouble(),
                  title: data.value.toString(),
                  titleStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 10.sp));
              return MapEntry(index, value);
            })
            .values
            .toList();
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 18.w, right: 18.w, bottom: 30.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 18.h,
                ),
                Text(
                  "Keselarasan Vertikal",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: neutral80,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                // Naro dragdown Penjelasan Keselarasan Vertical
                AccordionKeselarasan(
                  title: "Apa itu Keselarasan Vertikal?",
                  content:
                    "Keselarasan Vertikal merupakan tingkat kesesuaian hubungan antara jenjang pendidikan dengan jenjang pendidikan minimal yang menjadi persyaratan suatu pekerjaan. \n\nGrafik di bawah ini menampilkan jumlah keselarasan data alumni dari seluruh program studi pada ${widget.namaPt}"
                ),
                SizedBox(
                  height: 16.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                      boxShadow: shadow2),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 24.h,
                      ),
                      Text(
                        "Diagram",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: neutral80,
                            fontSize: 16.sp),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Container(
                        height: 250.h,
                        child: PieChart(PieChartData(
                            sectionsSpace: 3.0,
                            sections: sectionData,
                            centerSpaceRadius: 0)),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 12,
                                width: 12,
                                decoration: BoxDecoration(
                                    color: Color(0xff008FFB),
                                    shape: BoxShape.circle),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Text("Tinggi",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: neutral70,
                                    fontSize: 12.sp,
                                  ))
                            ],
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 12,
                                width: 12,
                                decoration: BoxDecoration(
                                    color: Color(0xff00E396),
                                    shape: BoxShape.circle),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Text("Sama",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: neutral70,
                                    fontSize: 12.sp,
                                  ))
                            ],
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 12,
                                width: 12,
                                decoration: BoxDecoration(
                                    color: Color(0xffff9800),
                                    shape: BoxShape.circle),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Text("Rendah",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: neutral70,
                                    fontSize: 12.sp,
                                  ))
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                      boxShadow: shadow2),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        DataTable(
                            dataRowHeight: 50.h,
                            //horizontalMargin: 0,
                            //columnSpacing: 0,
                            columns: [
                              DataColumn(
                                  label: Text(
                                "Nama\nProgram Studi",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700,
                                    color: neutral60),
                              )),
                            ],
                            rows: state.verticalTablePt
                                .map((e) => DataRow(cells: [
                                      DataCell(ConstrainedBox(
                                          constraints: BoxConstraints(
                                              maxHeight: 70.w,
                                              maxWidth: MediaQuery.of(context)
                                                          .size
                                                          .shortestSide <
                                                      600
                                                  ? 120.w
                                                  : 160.w),
                                          child: Text(
                                            e.toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                                color: neutral60),
                                          ))),
                                    ]))
                                .toList()),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                DataTable(
                                    dataRowHeight: 50.h,
                                    columns: [
                                      DataColumn(
                                          label: Center(
                                              child: Text.rich(
                                        TextSpan(
                                            text: 'Tinggi\nJumlah',
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w700,
                                                color: neutral60),
                                            children: <InlineSpan>[
                                              TextSpan(
                                                  text: " (%)",
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Color(0xff008FFB)))
                                            ]),
                                        textAlign: TextAlign.center,
                                      ))),
                                    ],
                                    rows: state.verticalTableTinggi
                                        .map((e) => DataRow(cells: [
                                              DataCell(Center(
                                                child: Text(e.toString(),
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: neutral60)),
                                              )),
                                            ]))
                                        .toList()),
                                DataTable(
                                    dataRowHeight: 50.h,
                                    columns: [
                                      DataColumn(
                                          label: Center(
                                              child: Text.rich(
                                        TextSpan(
                                            text: 'Sama\nJumlah',
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w700,
                                                color: neutral60),
                                            children: <InlineSpan>[
                                              TextSpan(
                                                  text: " (%)",
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Color(0xff00E396)))
                                            ]),
                                        textAlign: TextAlign.center,
                                      ))),
                                    ],
                                    rows: state.verticalTableSama
                                        .map((e) => DataRow(cells: [
                                              DataCell(Center(
                                                child: Text(e.toString(),
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: neutral60)),
                                              )),
                                            ]))
                                        .toList()),
                                DataTable(
                                    dataRowHeight: 50.h,
                                    columns: [
                                      DataColumn(
                                          label: Center(
                                              child: Text.rich(
                                        TextSpan(
                                            text: 'Rendah\nJumlah',
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w700,
                                                color: neutral60),
                                            children: <InlineSpan>[
                                              TextSpan(
                                                  text: " (%)",
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Color(0xffff9800)))
                                            ]),
                                        textAlign: TextAlign.center,
                                      ))),
                                    ],
                                    rows: state.verticalTableRendah
                                        .map((e) => DataRow(cells: [
                                              DataCell(Center(
                                                child: Text(e.toString(),
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: neutral60)),
                                              )),
                                            ]))
                                        .toList()),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      } else if (state is StatistikTracerNoInternetState) {
        return NoInternet(
          onPressed: () {
            // _statistikTracerBloc.add(GetStatistikTracerEvent(widget.kodePt));
          },
          buttonHide: true,
        );
      } else if (state is StatistikTracerErrorState) {
        return btsNotFound("Data Perguruan Tinggi Tidak Ditemukan");
      } else {
        return ServerProblem(
          onPressed: () {
            // _statistikTracerBloc.add(GetStatistikTracerEvent(widget.kodePt));
          },
          buttonHide: true,
        );
      }
    });
  }
}
