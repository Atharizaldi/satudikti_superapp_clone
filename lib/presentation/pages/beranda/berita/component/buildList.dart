import 'package:app/data/source/remote/model/berita/newsList.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/berita/component/newBeritaListStyleCard.dart';
import 'package:app/presentation/pages/beranda/beritaDanPengumumanDetail/beritaDanPengumumanSubPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildNewsList(List<Data> newsList, bool hasReachedMax,
    ScrollController scrollController) {
  return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      itemCount: (hasReachedMax) ? newsList.length : newsList.length + 1,
      controller: scrollController,
      separatorBuilder: (context, index) {
        return SizedBox(height: 20.h,);
      },
      itemBuilder: (context, index) {
        if (index < newsList.length) {
          return NewBeritaListStyleCard(
            function: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BeritaDanPengumumanSubPage(category: '', id: newsList[index].newsId),
                  ));
            },
            image: (newsList[index].thumbnailImage == "" || newsList[index].thumbnailImage == 'null')
                ? 'assets/default-con/berita.png'
                : newsList[index].thumbnailImage,
            judul: newsList[index].title,
            tanggal: newsList[index].publisherDate,
            kategori: '',
          );
        } else {
          return Center(
            child: CircularProgressIndicator(color: blueLinear1),
          );
        }
      });
}
