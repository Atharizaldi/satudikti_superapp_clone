import 'package:app/data/source/remote/model/berita/newsList.dart';
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/sub_title_with_arrow_lainnya.dart';
import 'package:app/presentation/pages/beranda/berita/beritaListView.dart';
import 'package:app/presentation/pages/beranda/berita/bloc/berita_bloc.dart';
import 'package:app/presentation/pages/beranda/berita/component/newBeritaListStyleCard.dart';
import 'package:app/presentation/pages/beranda/beritaDanPengumumanDetail/beritaDanPengumumanSubPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget beritaTerbaru(BuildContext context, NewsList recentNewsList) {
  return Container(
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SubTitleWithArrowLainnya(
            subJudul: 'Berita Terbaru',
            function: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BlocProvider(
                            create: (context) => di.locator<BeritaBloc>()
                              ..add(GetBeritaEvent(category: "1")),
                            child: BeritaListView(kategori: "1"),
                          )));
            },
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Text(
            "Berbagai berita Dikti terbaru",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: Color(0xff858585)),
          ),
        ),
        SizedBox(
          height: 24.h,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              NewBeritaListStyleCard(
                image: recentNewsList.data[0].thumbnailImage == 'null'
                    ? 'assets/default-con/berita.png'
                    : recentNewsList.data[0].thumbnailImage,
                function: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BeritaDanPengumumanSubPage(
                                category: '',
                                id: recentNewsList.data[0].newsId,
                              )));
                },
                kategori: '',
                judul: recentNewsList.data[0].title,
                tanggal: recentNewsList.data[0].publisherDate,
              ),
              SizedBox(
                height: 20.h,
              ),
              NewBeritaListStyleCard(
                image: recentNewsList.data[1].thumbnailImage == 'null'
                    ? 'assets/default-con/berita.png'
                    : recentNewsList.data[1].thumbnailImage,
                function: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BeritaDanPengumumanSubPage(
                                category: '',
                                id: recentNewsList.data[1].newsId,
                              )));
                },
                kategori: '',
                judul: recentNewsList.data[1].title,
                tanggal: recentNewsList.data[1].publisherDate,
              ),
              SizedBox(
                height: 20.h,
              ),
              NewBeritaListStyleCard(
                image: recentNewsList.data[2].thumbnailImage == 'null'
                    ? 'assets/default-con/berita.png'
                    : recentNewsList.data[2].thumbnailImage,
                function: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BeritaDanPengumumanSubPage(
                                category: '',
                                id: recentNewsList.data[2].newsId,
                              )));
                },
                kategori: '',
                judul: recentNewsList.data[2].title,
                tanggal: recentNewsList.data[2].publisherDate,
              ),
              SizedBox(
                height: 20.h,
              ),
              NewBeritaListStyleCard(
                image: recentNewsList.data[3].thumbnailImage == 'null'
                    ? 'assets/default-con/berita.png'
                    : recentNewsList.data[3].thumbnailImage,
                function: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BeritaDanPengumumanSubPage(
                                category: '',
                                id: recentNewsList.data[3].newsId,
                              )));
                },
                kategori: '',
                judul: recentNewsList.data[3].title,
                tanggal: recentNewsList.data[3].publisherDate,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
