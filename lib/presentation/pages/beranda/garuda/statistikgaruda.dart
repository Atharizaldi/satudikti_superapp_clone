import 'package:app/presentation/component/constant.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatistikGaruda extends StatelessWidget {
  const StatistikGaruda({Key? key}) : super(key: key);

  //statis data
  static final List<DiagramChartGaruda> populationData = [
    DiagramChartGaruda('2010', 40, Color(0xff0263ff)),
    DiagramChartGaruda('2011', 88, Color(0xffff7723)),
    DiagramChartGaruda('2012', 60, Color(0xff8e30ff)),
    DiagramChartGaruda('2013', 59, Color(0xffb90de5)),
    DiagramChartGaruda('2014', 6, Color(0xffbd27ce)),
    DiagramChartGaruda('2015', 0, Colors.green)
  ];

  @override
  Widget build(BuildContext context) {
    List<charts.Series<DiagramChartGaruda, String>> series = [
      charts.Series(
        data: populationData,
        id: "Diagram Garuda",
        domainFn: (DiagramChartGaruda pops, _) => pops.year,
        measureFn: (DiagramChartGaruda pops, _) => pops.population,
        colorFn: (DiagramChartGaruda pops, _) =>
            charts.ColorUtil.fromDartColor(pops.barColor),
        labelAccessorFn: (DiagramChartGaruda pops, _) =>
            '${pops.population.toString()}',
      )
    ];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Statistik',
          style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 1),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: appBarGradient,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 17.w),
              child: Text(
                "Statistik Garuda",
                style: TextStyle(
                    color: blue3,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5),
              ),
            ),
            SizedBox(
              height: 11.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 17.w),
              child: Text(
                "Berikut adalah data statistik pada Garuda",
                style: TextStyle(
                    color: Color(0xff858585),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.5),
              ),
            ),
            SizedBox(
              height: 34.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              child: Container(
                height: 347.h,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Publikasi per Tahun",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: blue4,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      height: 268.h,
                      child: charts.BarChart(
                        series,
                        animate: true,
                        barRendererDecorator:
                            new charts.BarLabelDecorator<String>(
                                labelPosition: charts.BarLabelPosition.outside),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 22.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              child: Container(
                height: 347.h,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Index Publikasi pada garuda per tahun",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: blue4,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 7.w),
                      child: Container(
                        height: 268.h,
                        child: charts.BarChart(
                          series,
                          animate: true,
                          barRendererDecorator:
                              new charts.BarLabelDecorator<String>(
                                  labelPosition:
                                      charts.BarLabelPosition.outside),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 44.h,
            ),
          ],
        ),
      ),
    );
  }
}

class DiagramChartGaruda {
  final String year;
  final int population;
  final Color barColor;

  DiagramChartGaruda(this.year, this.population, this.barColor);
}
