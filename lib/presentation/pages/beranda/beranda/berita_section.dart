import 'package:app/common/dateFormat.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/sub_title_with_arrow_lainnya.dart';
import 'package:app/presentation/pages/beranda/beranda/bloc/beranda_bloc.dart';
import 'package:app/presentation/pages/beranda/beranda/component/beranda_loading.dart';
import 'package:app/presentation/pages/beranda/beranda/component/cardBerita.dart';
import 'package:app/presentation/pages/beranda/berita/beritaPage.dart';
import 'package:app/presentation/pages/beranda/beritaDanPengumumanDetail/beritaDanPengumumanSubPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget beritaSection(BuildContext context, BerandaState state) {
  if (state is BerandaLoadedState) {
    BerandaBloc bloc = BlocProvider.of<BerandaBloc>(context);
    if (bloc.isNewsListEmpty(state.popularBeritaList) &&
        bloc.isNewsListEmpty(state.recentBeritaList)) {
      return beritaLoading();
    } else {
      return Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              child: SubTitleWithArrowLainnya(
                subJudul: 'Berita Dikti',
                function: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BeritaPage(
                          recentNewsList: state.recentBeritaList,
                          popularNewsList: state.popularBeritaList,
                        ),
                      ));
                },
              ),
            ),
            SizedBox(height: 8.w),
            Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: Text(
                "Temukan berbagai berita Dikti disini",
                style: styleSubJudul2,
              ),
            ),
            SizedBox(height: 20.w),
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
                  if (state.recentBeritaList.data.isNotEmpty) {
                    return CardBerita(
                      image: state.recentBeritaList.data[index]
                                  .thumbnailImage ==
                              ''
                          ? 'assets/default-con/berita.png'
                          : state.recentBeritaList.data[index].thumbnailImage,
                      leftMargin: 0,
                      rightMargin: 0,
                      tanggalBerita: FormatDate().formatDate(
                          state.recentBeritaList.data[index].publisherDate),
                      judulBerita: state.recentBeritaList.data[index].title,
                      function: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BeritaDanPengumumanSubPage(
                              category: '',
                              id: state.recentBeritaList.data[index].newsId,
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
          ],
        ),
      );
    }
  } else {
    return beritaLoading();
  }
}
