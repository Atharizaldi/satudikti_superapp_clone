import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardAjuanPerubahan extends StatelessWidget {
  const CardAjuanPerubahan(
      {Key? key,
      required this.categoriesKey,
      required this.date,
      required this.onTap,
      required this.descriptionData,
      required this.nama})
      : super(key: key);
  final String nama;
  final String categoriesKey;
  final String date;
  final VoidCallback onTap;
  final String descriptionData;

  @override
  Widget build(BuildContext context) {
    final Categories categories;
    if (categoriesKey.trim() == 'Disetujui') {
      categories = Categories.accepted;
    } else if (categoriesKey.trim() == 'Ditolak') {
      categories = Categories.rejected;
    } else if (categoriesKey.trim() == 'Draft') {
      categories = Categories.draft;
    } else if (categoriesKey.trim() == 'Diusulkan') {
      categories = Categories.submitted;
    } else {
      categories = Categories.draft;
    }
    final TextStyle fontCategoryStyle;
    final Color bgCategory;
    final String typeCategory;
    if (categories == Categories.draft) {
      fontCategoryStyle = TextStyle(
        color: Color.fromRGBO(52, 64, 84, 1),
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        fontFamily: "Inter",
      );
      bgCategory = Color.fromRGBO(242, 244, 247, 1);
      typeCategory = 'Draft';
    } else if (categories == Categories.accepted) {
      fontCategoryStyle = TextStyle(
        color: Color.fromRGBO(2, 122, 72, 1),
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        fontFamily: "Inter",
      );
      bgCategory = Color.fromRGBO(236, 253, 243, 1);
      typeCategory = 'Disetujui';
    } else if (categories == Categories.rejected) {
      fontCategoryStyle = TextStyle(
        color: Color.fromRGBO(180, 35, 24, 1),
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        fontFamily: "Inter",
      );
      bgCategory = Color.fromRGBO(254, 243, 242, 1);
      typeCategory = 'Ditolak';
    } else if (categories == Categories.submitted) {
      fontCategoryStyle = TextStyle(
        color: Color.fromRGBO(23, 92, 211, 1),
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        fontFamily: "Inter",
      );
      bgCategory = Color.fromRGBO(239, 248, 255, 1);
      typeCategory = 'Diusulkan';
    } else {
      fontCategoryStyle = TextStyle(
        color: Color.fromRGBO(23, 92, 211, 1),
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        fontFamily: "Inter",
      );
      bgCategory = Color.fromRGBO(239, 248, 255, 1);
      typeCategory = 'Apagek';
    }
    return GestureDetector(
      onTap: onTap,
      child:
      Wrap(

      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            boxShadow: [
              BoxShadow(
                color: Color(0x1A5C5E61),
                spreadRadius: -4,
                blurRadius: 16.r,
                offset: Offset(0, 12),
              ),
            ],
          ),
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 2.h,
                ),
                decoration: BoxDecoration(
                  color: bgCategory,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Text(
                  typeCategory,
                  style: fontCategoryStyle,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                nama,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(29, 30, 37, 1),
                  fontFamily: 'Plus Jakarta Sans',
                ),
              ),
              SizedBox(
                height: 6.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.date_range,
                    color: neutral50,
                    size: 12.sp,
                  ),
                  SizedBox(
                    width: 6.w,
                  ),
                  Text(
                    'Diajukan $date',
                    style: TextStyle(
                        color: neutral50,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Plus Jakarta Sans'),
                  ),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              if (descriptionData != '')
                Text(
                  'Keterangan Perubahan',
                  style: TextStyle(
                      color: neutral50,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Plus Jakarta Sans'),
                ),
              if (descriptionData != '')
                SizedBox(
                  height: 6.h,
                ),
              if (descriptionData != '')
                Text(
                  descriptionData.toString(),
                  style: TextStyle(
                      color: neutral80,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Plus Jakarta Sans'),
                ),
              if (descriptionData != '')
                SizedBox(
                  height: 18.h,
                ),
              GestureDetector(
                onTap: onTap,
                child: Row(
                  children: [
                    Text(
                      'Lihat Detail',
                      style: TextStyle(
                          color: biruMuda2,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: biruMuda2,
                      size: 18.sp,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    );
  }
}

enum Categories { draft, submitted, accepted, rejected }
