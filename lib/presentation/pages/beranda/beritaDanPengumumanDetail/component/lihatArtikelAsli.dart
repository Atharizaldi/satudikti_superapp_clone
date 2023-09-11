import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/showWebsite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget lihatArtikelAsli(BuildContext context, String link) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowWebsite(
              link: link,
            ),
          ));
    },
    child: Container(
      padding: EdgeInsets.only(left: screenWidth(context) * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image.asset(
          //   'assets/icons/directNew.png',
          // ),
          SvgPicture.asset('assets/icons/directNew.svg'),
          SizedBox(
            width: 10,
          ),
          Text(
            'Lihat artikel asli',
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 16, color: blue4),
          )
        ],
      ),
    ),
  );
}
