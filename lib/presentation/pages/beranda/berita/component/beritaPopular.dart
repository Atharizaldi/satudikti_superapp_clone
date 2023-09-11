import 'package:app/common/dateFormat.dart';
import 'package:app/data/source/remote/model/berita/newsList.dart';
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/sub_title_with_arrow_lainnya.dart';
import 'package:app/presentation/pages/beranda/beranda/component/cardBerita.dart';
import 'package:app/presentation/pages/beranda/berita/beritaListView.dart';
import 'package:app/presentation/pages/beranda/berita/bloc/berita_bloc.dart';
import 'package:app/presentation/pages/beranda/beritaDanPengumumanDetail/beritaDanPengumumanSubPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget beritaPopular(BuildContext context, NewsList popularNewsList) {
  return Container(
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SubTitleWithArrowLainnya(
            subJudul: 'Berita Populer',
            function: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BlocProvider(
                            create: (context) => di.locator<BeritaBloc>()
                              ..add(GetBeritaEvent(category: "3")),
                            child: BeritaListView(kategori: "3"),
                          )));
            },
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Text(
            "Berbagai berita Dikti terpopular",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: Color(0xff858585)),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Container(
          width: double.infinity,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20.w,
              mainAxisSpacing: 20.w,
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 4,
            itemBuilder: (context, index) {
              if (popularNewsList.data.isNotEmpty) {
                return CardBerita(
                  image: popularNewsList.data[index].thumbnailImage == ''
                      ? 'assets/default-con/berita.png'
                      : popularNewsList.data[index].thumbnailImage,
                  leftMargin: 0,
                  rightMargin: 0,
                  tanggalBerita: FormatDate()
                      .formatDate(popularNewsList.data[index].publisherDate),
                  judulBerita: popularNewsList.data[index].title,
                  function: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BeritaDanPengumumanSubPage(
                          category: '',
                          id: popularNewsList.data[index].newsId,
                        ),
                      ),
                    );
                  },
                );
              }
              return Container();
            },
          ),
        ),
        SizedBox(
          height: 60.h,
        )
      ],
    ),
  );
}
