import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardStatusAjuanPDDIKTI extends StatelessWidget {
  const CardStatusAjuanPDDIKTI({
    Key? key,
    required this.categoriess,
    required this.date,
  }) : super(key: key);
  final String categoriess;
  final String date;
  // final List<Map<dynamic, dynamic>> data;

  @override
  Widget build(BuildContext context) {
    final Categoriess categoriessKey;
    final TextStyle statusCategoryStyle;
    final TextStyle typeCategoryStyle;
    final Color bgCategory;
    final Color iconColor;
    final String typeCategory;
    String statusTahapan = 'Status Tahapan';
    if (categoriess.trim() == 'Disetujui') {
      categoriessKey = Categoriess.accepted;
    } else if (categoriess.trim() == 'Ditolak') {
      categoriessKey = Categoriess.rejected;
    } else if (categoriess.trim() == 'Diusulkan') {
      categoriessKey = Categoriess.submitted;
    } else if (categoriess.trim() == 'Draft') {
      categoriessKey = Categoriess.draft;
    } else {
      categoriessKey = Categoriess.draft;
    }

    if (categoriessKey == Categoriess.draft) {
      statusCategoryStyle = TextStyle(
          color: Color.fromRGBO(71, 84, 103, 1),
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          fontFamily: 'Plus Jakarta Sans');
      bgCategory = Color.fromRGBO(208, 213, 221, 1);
      typeCategoryStyle = TextStyle(
          color: Color.fromRGBO(71, 84, 103, 1),
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter');
      typeCategory = 'Draft';
      iconColor = Color.fromRGBO(119, 122, 126, 1);
      statusTahapan;
    } else if (categoriessKey == Categoriess.submitted) {
      statusCategoryStyle = TextStyle(
          color: Colors.white,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          fontFamily: 'Plus Jakarta Sans');
      bgCategory = biruMuda2;
      typeCategoryStyle = TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter');
      typeCategory = 'Diajukan';
      iconColor = biruMuda2;
      statusTahapan;
    } else if (categoriessKey == Categoriess.accepted) {
      statusCategoryStyle = TextStyle(
          color: Color.fromRGBO(2, 122, 72, 1),
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          fontFamily: 'Plus Jakarta Sans');
      bgCategory = Color.fromRGBO(209, 250, 223, 1);
      typeCategoryStyle = TextStyle(
          color: Color.fromRGBO(2, 122, 72, 1),
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter');
      typeCategory = 'Disetujui';
      iconColor = Color.fromRGBO(26, 158, 74, 1);
      statusTahapan;
    } else if (categoriessKey == Categoriess.rejected) {
      statusCategoryStyle = TextStyle(
          color: Colors.white,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          fontFamily: 'Plus Jakarta Sans');
      bgCategory = Color.fromRGBO(228, 93, 84, 1);
      typeCategoryStyle = TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter');
      typeCategory = 'Ditolak';
      iconColor = Color.fromRGBO(227, 75, 49, 1);
      statusTahapan;
    } else {
      statusCategoryStyle = TextStyle(
          color: Colors.white,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          fontFamily: 'Plus Jakarta Sans');
      bgCategory = Color.fromRGBO(228, 93, 84, 1);
      typeCategoryStyle = TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter');
      typeCategory = 'Disetujui';
      iconColor = Color.fromRGBO(227, 75, 49, 1);
      statusTahapan;
    }
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: bgCategory, borderRadius: BorderRadius.circular(10.r)),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 50.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                      ),
                      ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (Rect bounds) => RadialGradient(
                          center: Alignment.topCenter,
                          stops: [.01, -8],
                          colors: [
                            Color.fromRGBO(255, 255, 255, 0),
                            iconColor,
                          ],
                        ).createShader(bounds),
                        child: ImageIcon(
                          AssetImage('assets/pddikti/ajuan_document.png'),
                          size: 25.sp,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          statusTahapan,
                          style: statusCategoryStyle,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          categoriessKey == Categoriess.draft
                              ? typeCategory
                              : '$typeCategory pada $date',
                          style: typeCategoryStyle,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }
}

enum Categoriess { draft, submitted, accepted, rejected }
