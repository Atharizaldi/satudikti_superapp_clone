import 'package:app/common/dateFormat.dart';
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/bloc/file_list/file_list_bloc.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/components/daftarUnduhan/detailDaftarUnduhan/detailDaftarUnduhan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final FormatDate formatDate = FormatDate();

class CardDaftarUnduhan extends StatelessWidget {
  final String id;
  final String name;
  final String createdAt;
  final String url;
  const CardDaftarUnduhan({
    Key? key,
    required this.id,
    required this.name,
    required this.createdAt,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (builder) => BlocProvider(
                      create: (context) => di.locator<FileListBloc>(),
                      child: DetailDaftarunduhan(
                        id: id,
                        name: name,
                        url: url,
                      ),
                    )));
      },
      child: Container(
        width: 358.w,

        // height: 178.sp,
        padding: EdgeInsets.symmetric(vertical: 20.sp, horizontal: 20.w),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(151, 151, 151, 0.06),
                offset: Offset(0, 4),
                blurRadius: 15,
                spreadRadius: 10)
          ],
        ),
        child: _cardInfo(context),
      ),
    );
  }

  Widget _cardInfo(context) {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          name,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: blue4, fontSize: 14.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.sp),
        Text(
          FormatDate.formatDateStatic(createdAt),
          style: textStyleSmallParagraph,
        ),
        SizedBox(height: 12.sp),
        Row(
          children: [
            Text(
              'Lihat',
              style: TextStyle(
                color: blue2,
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(width: 12.5.sp),
            Image.asset(
              'assets/right_arrow.png',
              width: 12.sp,
            )
          ],
        ),
        // Text(
        //   "Lihat",
        //   style: TextStyle(
        //       fontSize: 12.sp, fontWeight: FontWeight.bold, color: red),
        // )
      ]),
    );
  }
}
