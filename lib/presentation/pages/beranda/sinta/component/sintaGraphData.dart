import 'package:flutter/material.dart';

class SintaGraphData {
  final int id;
  final double barWidth;
  final Color barColor;
  final double barY;

  SintaGraphData({
    required this.id,
    required this.barColor,
    required this.barY,
    this.barWidth = 20.0,
  });
}