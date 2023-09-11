import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';

class MenuBeranda extends StatelessWidget {
  final String logoMenu;
  final String namaMenu;
  final double scale;
  final VoidCallback function;
  const MenuBeranda(
      {Key? key,
      required this.namaMenu,
      required this.logoMenu,
      required this.function,
      required this.scale})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.function,
      child: Container(
        width: screenWidth(context) * (1 / 4.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: screenHeight(context) * (1 / 13),
              width: screenHeight(context) * (1 / 13),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: white,
                  image: DecorationImage(
                      image: AssetImage(
                        this.logoMenu,
                      ),
                      scale: this.scale),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.06),
                        offset: Offset(0, 0),
                        blurRadius: 5,
                        spreadRadius: 3)
                  ]),
            ),
            SizedBox(
              height: screenHeight(context) * (1 / 50),
            ),
            Text(
              this.namaMenu,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: neutral40,
                  fontWeight: FontWeight.w600,
                  fontSize: screenHeight(context) * (1 / 65)),
            ),
          ],
        ),
      ),
    );
  }
}
