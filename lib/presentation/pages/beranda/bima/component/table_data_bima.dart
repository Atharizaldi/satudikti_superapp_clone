import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TableDataBima extends StatelessWidget {
  const TableDataBima({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5.r)),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 22.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                child: Table(
                  columnWidths: const <int, TableColumnWidth>{
                    0: FlexColumnWidth(),
                    1: FixedColumnWidth(30),
                    2: FlexColumnWidth(),
                    3: FlexColumnWidth(),
                    4: FlexColumnWidth(),
                    // 5: IntrinsicColumnWidth(),
                    // 0: FixedColumnWidth(90),
                    // 1: FixedColumnWidth(30),
                    // 2: FixedColumnWidth(80),
                    // 3: FixedColumnWidth(80),
                    // 4: FixedColumnWidth(40),
                    // 0: FlexColumnWidth(),
                    // 1: FlexColumnWidth(),
                    // 2: FlexColumnWidth(),
                    // 3: FlexColumnWidth(),
                    // 4: FlexColumnWidth(),

                    // 2: IntrinsicColumnWidth(),
                    // 3: IntrinsicColumnWidth(),
                    // 4: IntrinsicColumnWidth(),

                    // 2: FixedColumnWidth(50),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(children: [
                      TableCell(
                        child: Text(""),
                      ),
                      TableCell(
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 15.w))),
                      TableCell(
                        child: Text(
                          "Scopus",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Inter",
                              color: Color.fromRGBO(247, 148, 0, 1)),
                        ),
                      ),
                      TableCell(
                        child: Text(
                          "Gscholar",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Inter",
                              color: Color.fromRGBO(63, 190, 43, 1)),
                        ),
                      ),
                      TableCell(
                        child: Text(
                          "WOS",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Inter",
                              color: Color.fromRGBO(14, 122, 197, 1)),
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      TableCell(
                        child: Text(
                          "Article",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Inter",
                              color: Color.fromRGBO(77, 77, 77, 1)),
                        ),
                      ),
                      TableCell(
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 15.w))),
                      TableCell(
                        child: Text(
                          "12121",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Inter",
                              color: Color.fromRGBO(247, 148, 0, 1)),
                        ),
                      ),
                      TableCell(
                        child: Text(
                          "12121",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Inter",
                              color: Color.fromRGBO(247, 148, 0, 1)),
                        ),
                      ),
                      TableCell(
                        child: Text(
                          "12121",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Inter",
                              color: Color.fromRGBO(247, 148, 0, 1)),
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      TableCell(
                        child: Text(
                          "Citation",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Inter",
                              color: Color.fromRGBO(77, 77, 77, 1)),
                        ),
                      ),
                      TableCell(
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 15.w))),
                      TableCell(
                        child: Text(
                          "12121",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Inter",
                              color: Color.fromRGBO(247, 148, 0, 1)),
                        ),
                      ),
                      TableCell(
                        child: Text(
                          "1212",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Inter",
                              color: Color.fromRGBO(247, 148, 0, 1)),
                        ),
                      ),
                      TableCell(
                        child: Text(
                          "1212",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Inter",
                              color: Color.fromRGBO(247, 148, 0, 1)),
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      TableCell(
                        child: Text(
                          "Cited Document",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Inter",
                              color: Color.fromRGBO(77, 77, 77, 1)),
                        ),
                      ),
                      TableCell(
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 15.w))),
                      TableCell(
                        child: Text(
                          "12121",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Inter",
                              color: Color.fromRGBO(247, 148, 0, 1)),
                        ),
                      ),
                      TableCell(
                        child: Text(
                          "1212121",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Inter",
                              color: Color.fromRGBO(247, 148, 0, 1)),
                        ),
                      ),
                      TableCell(
                        child: Text(
                          "1212",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Inter",
                              color: Color.fromRGBO(247, 148, 0, 1)),
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      TableCell(
                        child: Text(
                          "H-Index",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Inter",
                              color: Color.fromRGBO(77, 77, 77, 1)),
                        ),
                      ),
                      TableCell(
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 15.w))),
                      TableCell(
                        child: Text(
                          "1212",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Inter",
                              color: Color.fromRGBO(247, 148, 0, 1)),
                        ),
                      ),
                      TableCell(
                        child: Text(
                          "1212",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Inter",
                              color: Color.fromRGBO(247, 148, 0, 1)),
                        ),
                      ),
                      TableCell(
                        child: Text(
                          "1212",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Inter",
                              color: Color.fromRGBO(247, 148, 0, 1)),
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      TableCell(
                        child: Text(
                          "I10-Index",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Inter",
                              color: Color.fromRGBO(77, 77, 77, 1)),
                        ),
                      ),
                      TableCell(
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 15.w))),
                      TableCell(
                        child: Text(
                          "1212",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Inter",
                              color: Color.fromRGBO(247, 148, 0, 1)),
                        ),
                      ),
                      TableCell(
                        child: Text(
                          "12121",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Inter",
                              color: Color.fromRGBO(247, 148, 0, 1)),
                        ),
                      ),
                      TableCell(
                        child: Text(
                          "12121",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Inter",
                              color: Color.fromRGBO(247, 148, 0, 1)),
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      TableCell(
                        child: Text(
                          "G-Index",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Inter",
                              color: Color.fromRGBO(77, 77, 77, 1)),
                        ),
                      ),
                      TableCell(
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 15.w))),
                      TableCell(
                        child: Text(
                          "12121",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Inter",
                              color: Color.fromRGBO(247, 148, 0, 1)),
                        ),
                      ),
                      TableCell(
                        child: Text(
                          "12121",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Inter",
                              color: Color.fromRGBO(247, 148, 0, 1)),
                        ),
                      ),
                      TableCell(
                        child: Text(
                          "123456789123456",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Inter",
                              color: Color.fromRGBO(247, 148, 0, 1)),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
