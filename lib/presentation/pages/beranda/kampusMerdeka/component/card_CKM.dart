import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/inkEffect.dart';
import 'package:app/presentation/pages/beranda/kampusMerdeka/detail_cerita_ckm/komentar_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CardCKM extends StatelessWidget {
  const CardCKM(
      {Key? key,
      required this.judulCerita,
      required this.author,
      required this.date,
      required this.like,
      required this.comment,
      required this.imageURL,
      required this.category,
      required this.fun})
      : super(key: key);

  final VoidCallback fun;
  final String judulCerita;
  final String author;
  final String date;
  final int like;
  final int comment;
  final String imageURL;
  final String category;

  @override
  Widget build(BuildContext context) {
    final String typeCategory;
    final TextStyle fontCategoryStyle;
    var _like = NumberFormat.compact().format(like);
    var _comment = NumberFormat.compact().format(comment);
    if (category == '7') {
      fontCategoryStyle = TextStyle(
        color: Color(0xff118EEA),
        fontWeight: FontWeight.w600,
        fontSize: 12.sp,
      );
      typeCategory = 'MSIB';
    } else if (category == '8') {
      fontCategoryStyle = TextStyle(
        color: Color(0xff118EEA),
        fontWeight: FontWeight.w600,
        fontSize: 12.sp,
      );
      typeCategory = 'Pertukaran Mahasiswa';
    } else if (category == '9') {
      fontCategoryStyle = TextStyle(
        color: Color(0xff118EEA),
        fontWeight: FontWeight.w600,
        fontSize: 12.sp,
      );
      typeCategory = 'Kampus Mengajar';
    } else if (category == '10') {
      fontCategoryStyle = TextStyle(
        color: Color(0xff118EEA),
        fontWeight: FontWeight.w600,
        fontSize: 12.sp,
      );
      typeCategory = 'IISMA';
    } else if (category == '11') {
      fontCategoryStyle = TextStyle(
        color: Color(0xff118EEA),
        fontWeight: FontWeight.w600,
        fontSize: 12.sp,
      );
      typeCategory = 'Wirausaha';
    } else if (category == '12') {
      fontCategoryStyle = TextStyle(
        color: Color(0xff118EEA),
        fontWeight: FontWeight.w600,
        fontSize: 12.sp,
      );
      typeCategory = 'Praktisi Mengajar';
    } else if (category == '13') {
      fontCategoryStyle = TextStyle(
        color: Color(0xff118EEA),
        fontWeight: FontWeight.w600,
        fontSize: 12.sp,
      );
      typeCategory = 'Festival Kampus Merdeka';
    } else {
      fontCategoryStyle = TextStyle(
        color: Color(0xff118EEA),
        fontWeight: FontWeight.w600,
        fontSize: 12.sp,
      );
      typeCategory = 'No Category';
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      width: double.infinity,
      child: InkEffect(
        onTap: fun,
        boxDecoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.r),
              bottomRight: Radius.circular(10.r)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 0.25,
              blurRadius: 0.6,
              offset: Offset(0, 0.5), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 135.h,
                  decoration: BoxDecoration(
                    gradient: kedairekaInformasiBgGradient,
                    color: neutral100,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.r),
                      topRight: Radius.circular(12.r),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.r),
                        topRight: Radius.circular(12.r)),
                    child: Image.network(
                      imageURL,
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stacktrace) {
                        return Image.asset(
                          'assets/km/ckm_placeholder.png',
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: Container(
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(16.sp),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.02),
                          offset: Offset(0, 4),
                          blurRadius: 8,
                        )
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(12, 5.5, 12, 5.5),
                      child: Row(
                        children: [
                          Text(typeCategory, style: fontCategoryStyle),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    judulCerita,
                    style: TextStyle(
                      color: neutral80,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/km/icons/icon_author.png',
                        height: 24.h,
                        width: 24.w,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        author,
                        style: TextStyle(
                          color: neutral60,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ImageIcon(
                        AssetImage('assets/km/icons/calendar_icon.png'),
                        size: 16.sp,
                        color: neutral60,
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      Text(
                        // '${FormatDate.formatDateStatic(this.date)}',
                        date,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                          color: neutral60,
                        ),
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      ImageIcon(
                        AssetImage('assets/km/icons/icon_like.png'),
                        size: 16.sp,
                        color: neutral60,
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      Text(
                        _like.toString(),
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: neutral60,
                        ),
                      ),
                      SizedBox(
                        width: 18.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => KomentarPage(),
                            ),
                          );
                        },
                        child: ImageIcon(
                          AssetImage('assets/km/icons/icon_comment.png'),
                          size: 16.sp,
                          color: neutral60,
                        ),
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      Text(
                        _comment.toString(),
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: neutral60,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

