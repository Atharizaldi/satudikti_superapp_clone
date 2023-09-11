import 'package:app/presentation/pages/showWebsite.dart';
import 'package:flutter/material.dart';

import 'constant.dart';

class HeaderModul extends StatelessWidget {
  final String link, image;
  const HeaderModul({Key? key, required this.link, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: screenWidth(context) * (1 / 2),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xffA7D5FF), Color(0xffC2DEFF)],
              ),
            ),
          ),
          Center(
            child: ClipRRect(
              child: Container(
                margin: EdgeInsets.only(top: screenWidth(context) * (1 / 100)),
                child: Image.asset(
                  image,
                  width: screenWidth(context) * (1 / 1.01),
                ),
              ),
            ),
          ),
          // button dan tulisan
          Positioned(
            left: screenWidth(context) * (1 / 1.68),
            top: screenWidth(context) * (1 / 3.5),
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShowWebsite(link: link),
                ),
              ),
              child: Container(
                height: screenHeight(context) * (1 / 17),
                width: screenWidth(context) * (1 / 3.2),
                decoration: BoxDecoration(
                    color: blue2, borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    'Lihat Website',
                    style: TextStyle(
                        fontSize: screenHeight(context) * (1 / 53),
                        color: white,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
