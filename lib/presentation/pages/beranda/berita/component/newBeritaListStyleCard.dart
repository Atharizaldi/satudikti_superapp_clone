import 'package:app/common/dateFormat.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewBeritaListStyleCard extends StatelessWidget {
  final VoidCallback? function;
  final String? kategori;
  final String? image, judul, tanggal;
  const NewBeritaListStyleCard({
    Key? key,
    required this.function,
    required this.kategori,
    required this.image,
    required this.judul,
    required this.tanggal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FormatDate formatDate = new FormatDate();
    return GestureDetector(
      onTap: function,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 85.6.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 128.w,
                      height: 85.6.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        image: DecorationImage(
                          image: this.image == 'assets/default-con/berita.png'
                              ? AssetImage('assets/default-con/berita.png')
                                  as ImageProvider
                              : NetworkImage(this.image.toString()),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$judul',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: blue2,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              height: 1.65,
                            ),
                            maxLines: 2,
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Text(
                            "${tanggal == null ? "-" : formatDate.formatDate(tanggal.toString())}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: neutral50,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
