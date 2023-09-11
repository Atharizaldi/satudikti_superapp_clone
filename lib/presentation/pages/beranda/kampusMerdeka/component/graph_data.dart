import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';

class GraphData {
  final int id;
  final double barWidth;
  final Color barColor;
  final double barY;

  GraphData({
    required this.id,
    required this.barColor,
    required this.barY,
    this.barWidth = 18.0,
  });
}

List<GraphData> firstGraphData = [
  GraphData(id: 0, barColor: blue2, barY: 12839),
  GraphData(id: 1, barColor: yellow, barY: 11464),
  GraphData(id: 2, barColor: red, barY: 14622),
  GraphData(id: 3, barColor: green3, barY: 21710),
  GraphData(id: 4, barColor: blue5, barY: 957),
];

List<GraphData> secondGraphData = [
  GraphData(id: 0, barColor: blue2, barY: 2304),
  GraphData(id: 1, barColor: yellow, barY: 2070),
  GraphData(id: 2, barColor: red, barY: 3630),
];

List<GraphData> thirdGraphData = [
  GraphData(id: 0, barColor: blue2, barY: 365),
  GraphData(id: 1, barColor: yellow, barY: 251),
  GraphData(id: 2, barColor: red, barY: 355),
  GraphData(id: 3, barColor: green3, barY: 371),
  GraphData(id: 4, barColor: blue5, barY: 99),
];
