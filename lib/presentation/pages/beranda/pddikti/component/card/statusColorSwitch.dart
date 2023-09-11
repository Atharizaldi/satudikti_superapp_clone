import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';

Color statusColor(String status) {
  switch (status) {
    case 'Aktif':
      return green3;
    case 'Alih Bentuk':
      return Color(0xffFBD106);
    case 'Tutup':
      return red;
    case 'Alih Kelola':
      return Color(0xfffba806);
    case 'Pembinaan':
      return Color(0xfff18142);
    default:
      return green3;
  }
}
