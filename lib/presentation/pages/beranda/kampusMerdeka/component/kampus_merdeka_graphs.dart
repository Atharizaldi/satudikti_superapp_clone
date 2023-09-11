import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/kampusMerdeka/component/graph_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget firstGraph() {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 16.w),
    decoration: BoxDecoration(
      color: white,
      borderRadius: BorderRadius.circular(8.r),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Grafik mahasiswa yang terlibat pada program Kampus Merdeka di 2021',
          style: styleGraphSubHeader,
        ),
        SizedBox(height: 32.w),
        Container(
          height: 323.w,
          child: BarChart(
            BarChartData(
              backgroundColor: Colors.transparent,
              maxY: 25000,
              groupsSpace: 12.w,
              borderData: _borderData(),
              barTouchData: _barTouchData(),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    getTitlesWidget: _getFirstLeftTitles,
                    showTitles: true,
                    reservedSize: 48.w,
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    getTitlesWidget: _getFirstBottomTitles,
                    showTitles: true,
                  ),
                ),
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              barGroups: firstGraphData
                  .map(
                    (data) => BarChartGroupData(
                      x: data.id,
                      showingTooltipIndicators: [0],
                      barRods: [
                        BarChartRodData(
                          borderRadius: BorderRadius.zero,
                          toY: data.barY,
                          width: data.barWidth.w,
                          color: data.barColor,
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget secondGraph() {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 16.w),
    decoration: BoxDecoration(
      color: white,
      borderRadius: BorderRadius.circular(8.r),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Grafik jumlah dosen yang terlibat pada program Kampus Merdeka di 2021',
          style: styleGraphSubHeader,
        ),
        SizedBox(height: 32.w),
        Container(
          height: 323.w,
          child: BarChart(
            BarChartData(
              backgroundColor: Colors.transparent,
              maxY: 5000,
              groupsSpace: 12.w,
              borderData: _borderData(),
              barTouchData: _barTouchData(),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    getTitlesWidget: _getSecondLeftTitles,
                    showTitles: true,
                    reservedSize: 48.w,
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    getTitlesWidget: _getSecondBottomTitles,
                    showTitles: true,
                  ),
                ),
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              barGroups: secondGraphData
                  .map(
                    (data) => BarChartGroupData(
                      x: data.id,
                      showingTooltipIndicators: [0],
                      barRods: [
                        BarChartRodData(
                          borderRadius: BorderRadius.zero,
                          toY: data.barY,
                          width: data.barWidth.w,
                          color: data.barColor,
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget thirdGraph() {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 16.w),
    decoration: BoxDecoration(
      color: white,
      borderRadius: BorderRadius.circular(8.r),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Grafik jumlah Perguruan Tinggi yang berpartisipasi pada program Kampus Merdeka di 2021',
          style: styleGraphSubHeader,
        ),
        SizedBox(height: 32.w),
        Container(
          height: 323.w,
          child: BarChart(
            BarChartData(
              backgroundColor: Colors.transparent,
              maxY: 500,
              groupsSpace: 12.w,
              borderData: _borderData(),
              barTouchData: _barTouchData(),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    getTitlesWidget: _getThirdLeftTitles,
                    showTitles: true,
                    reservedSize: 48.w,
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    getTitlesWidget: _getThirdBottomTitles,
                    showTitles: true,
                  ),
                ),
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              barGroups: thirdGraphData
                  .map(
                    (data) => BarChartGroupData(
                      x: data.id,
                      showingTooltipIndicators: [0],
                      barRods: [
                        BarChartRodData(
                          borderRadius: BorderRadius.zero,
                          toY: data.barY,
                          width: data.barWidth.w,
                          color: data.barColor,
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    ),
  );
}

FlBorderData _borderData() {
  return FlBorderData(
    border: Border(
      bottom: BorderSide(color: neutral100),
      left: BorderSide(color: neutral100),
      top: BorderSide.none,
      right: BorderSide.none,
    ),
  );
}

BarTouchData _barTouchData() {
  return BarTouchData(
    enabled: false,
    touchTooltipData: BarTouchTooltipData(
      tooltipBgColor: Colors.transparent,
      tooltipPadding: EdgeInsets.zero,
      tooltipMargin: 4.w,
      getTooltipItem: (group, groupIndex, rod, rodIndex) {
        return BarTooltipItem(
          rod.toY.toInt().toString(),
          styleGraphKM.copyWith(fontSize: 10.sp),
        );
      },
    ),
  );
}

Widget _getFirstLeftTitles(double value, TitleMeta meta) {
  String text;
  if (value == 0) {
    text = '0';
  } else if (value == 5000) {
    text = '5.000';
  } else if (value == 10000) {
    text = '10.000';
  } else if (value == 15000) {
    text = '15.000';
  } else if (value == 20000) {
    text = '20.000';
  } else if (value == 25000) {
    text = '25.000';
  } else {
    text = '';
  }
  return Padding(
    padding: EdgeInsets.only(right: 12.w),
    child: Text(
      text,
      textAlign: TextAlign.right,
      style: styleGraphKM,
    ),
  );
}

Widget _getFirstBottomTitles(double value, TitleMeta meta) {
  String text;

  if (value == 0) {
    text = 'MSIB';
  } else if (value == 1) {
    text = 'PMM';
  } else if (value == 2) {
    text = 'KM Angkatan I';
  } else if (value == 3) {
    text = 'KM Angkatan II';
  } else if (value == 4) {
    text = 'IISMA';
  } else {
    text = '';
  }

  return Padding(
    padding: EdgeInsets.only(top: 8.w),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: styleGraphKM.copyWith(fontSize: 6.5.sp),
    ),
  );
}

Widget _getSecondLeftTitles(double value, TitleMeta meta) {
  String text;
  if (value == 0) {
    text = '0';
  } else if (value == 1000) {
    text = '1.000';
  } else if (value == 2000) {
    text = '2.000';
  } else if (value == 3000) {
    text = '3.000';
  } else if (value == 4000) {
    text = '4.000';
  } else if (value == 5000) {
    text = '5.000';
  } else {
    text = '';
  }
  return Padding(
    padding: EdgeInsets.only(right: 12.w),
    child: Text(
      text,
      textAlign: TextAlign.right,
      style: styleGraphKM,
    ),
  );
}

Widget _getSecondBottomTitles(double value, TitleMeta meta) {
  String text;

  if (value == 0) {
    text = 'PMM';
  } else if (value == 1) {
    text = 'KM Angkatan I';
  } else if (value == 2) {
    text = 'KM Angkatan II';
  } else {
    text = '';
  }

  return Padding(
    padding: EdgeInsets.only(top: 8.w),
    child: Text(text, textAlign: TextAlign.center, style: styleGraphKM),
  );
}

Widget _getThirdLeftTitles(double value, TitleMeta meta) {
  String text;

  if (value == 0) {
    text = '0';
  } else if (value == 100) {
    text = '100';
  } else if (value == 200) {
    text = '200';
  } else if (value == 300) {
    text = '300';
  } else if (value == 400) {
    text = '400';
  } else if (value == 500) {
    text = '500';
  } else {
    text = '';
  }
  return Padding(
    padding: EdgeInsets.only(right: 12.w),
    child: Text(
      text,
      textAlign: TextAlign.right,
      style: styleGraphKM,
    ),
  );
}

Widget _getThirdBottomTitles(double value, TitleMeta meta) {
  String text;

  if (value == 0) {
    text = 'MSIB';
  } else if (value == 1) {
    text = 'PMM';
  } else if (value == 2) {
    text = 'KM Angkatan I';
  } else if (value == 3) {
    text = 'KM Angkatan II';
  } else if (value == 4) {
    text = 'IISMA';
  } else {
    text = '';
  }

  return Padding(
    padding: EdgeInsets.only(top: 8.w),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: styleGraphKM.copyWith(fontSize: 6.5.sp),
    ),
  );
}
