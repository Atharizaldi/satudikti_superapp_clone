import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';

Widget newBeritaDanPengumumanFooter() {
  return GestureDetector(
    onTap: () {},
    child: Container(
      height: 137,
      decoration: BoxDecoration(
        gradient: appBarGradient,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 24, bottom: 43),
            child: Container(
              height: 80,
              width: 64,
              child: Container(
                height: 56,
                width: 56,
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(248, 249, 253, 0.5),
                    borderRadius: BorderRadius.circular(5)),
                child: Image.asset(
                  'assets/silemkerma.png',
                ),
              ),
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(
                right: 24.0,
                top: 30.0,
              ),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Diterbitkan oleh : ",
                      style: TextStyle(
                          color: abu6,
                          fontSize: 11,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Humas Ditjen Diktiristek",
                      style: TextStyle(
                          color: white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      'No. Telp : +62 812-1222-6126',
                      style: TextStyle(
                          color: Color(0xffF0F0F0),
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Flexible(
                      child: Text(
                        'Email        : sekretariat.dikti@kemdikbud.go.id',
                        style: TextStyle(
                            color: Color(0xffF0F0F0),
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
