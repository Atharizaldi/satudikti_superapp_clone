import 'package:app/common/dateFormat.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewListStyleCardSearch extends StatelessWidget {
  final VoidCallback? function;
  final String? kategori;
  final String? image, judul, tanggal;

  const NewListStyleCardSearch(
      {Key? key,
      required this.function,
      required this.kategori,
      required this.image,
      required this.judul,
      required this.tanggal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    FormatDate formatDate = new FormatDate();
    return GestureDetector(
      onTap: function,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 20.h),
            child: Container(
              width: double.infinity,
              height: 83.h,
              decoration: BoxDecoration(
                color: whiteBgPage,
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 130.w,
                        height: 83.h,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: this.image ==
                                    'assets/default-con/pengumuman.png'
                                ? AssetImage(
                                        "assets/default-con/pengumuman.png")
                                    as ImageProvider
                                : NetworkImage(this.image.toString()),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      Flexible(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$judul',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: blue2,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold),
                                maxLines: 2,
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Text(
                                "${formatDate.formatDate(tanggal.toString())} | ${this.kategori == "" ? "" : this.kategori == 'Pengumuman' ? 'Umum' : this.kategori.toString()}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: neutral50,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
