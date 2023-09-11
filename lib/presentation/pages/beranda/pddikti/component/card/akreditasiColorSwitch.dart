import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';

Color akreditasiColor(String akreditasi) {
  switch (akreditasi) {
    case 'A':
      return green3;
    case 'B':
      return Color(0xffFBD106);
    case 'C':
      return red;
    case 'Unggul':
      return green3;
    case 'Baik Sekali':
      return Color(0xffFBD106);
    case 'Baik':
      return red;
    default:
      return green3;
  }
}
