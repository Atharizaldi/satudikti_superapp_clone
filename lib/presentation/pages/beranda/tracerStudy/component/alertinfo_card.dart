import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlertInfoCard extends StatelessWidget {
  final String textinfo;
  final String textdescription;
  const AlertInfoCard(
      {Key? key, required this.textinfo, required this.textdescription})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          width: double.infinity,
          child: Card(
            color: Color(0xFFD0E9FB),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 15.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info, size: 20.w, color: Color(0xFF1C5CAD)),
                  SizedBox(
                    width: 15.w,
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            textinfo,
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              color: Color(0xFF1C5CAD),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            textdescription,
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              color: Color(0xFF1C5CAD),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
