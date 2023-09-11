import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';

Widget categoryTag(BuildContext context, String? kategori) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: screenWidth(context) * 0.04,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: yellow3),
          padding: EdgeInsets.all(10),
          child: Text(
            kategori == 'Pengumuman' ? 'Umum' : '$kategori',
            textAlign: TextAlign.center,
            maxLines: 1,
            style: TextStyle(
                color: blue3,
                fontSize: screenHeight(context) * (1 / 55),
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    ),
  );
}
