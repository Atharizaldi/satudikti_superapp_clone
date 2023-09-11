import 'package:app/common/dateFormat.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/sub_title_with_arrow_lainnya.dart';
import 'package:app/presentation/pages/beranda/beranda/bloc/beranda_bloc.dart';
import 'package:app/presentation/pages/beranda/beranda/component/beranda_loading.dart';
import 'package:app/presentation/pages/beranda/beranda/component/cardPengumuman.dart';
import 'package:app/presentation/pages/beranda/beritaDanPengumumanDetail/beritaDanPengumumanSubPage.dart';
import 'package:app/presentation/pages/beranda/pddikti/cubit/tab_bar/tab_bar_cubit.dart';
import 'package:app/presentation/pages/beranda/pengumuman/pengumumanPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget pengumumanSection(BuildContext context, BerandaState state) {
  if (state is BerandaLoadedState) {
    BerandaBloc bloc = BlocProvider.of<BerandaBloc>(context);
    if (bloc.isPengumumanListEmpty(state.pengumumanList)) {
      return pengumumanLoading();
    } else {
      return Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              child: SubTitleWithArrowLainnya(
                subJudul: 'Pengumuman',
                function: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BlocProvider(
                              create: (context) => TabBarCubit(),
                              child: PengumumanPage(),
                            ),
                      ));
                },
              ),
            ),
            SizedBox(
              height: 8.w,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: Text(
                "Berbagai update pengumuman disini",
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
                  if (state.pengumumanList.data.isNotEmpty) {
                    return CardPengumuman(
                      judulPengumuman: state.pengumumanList.data[index].title,
                      tanggalPengumuman: FormatDate().formatDate(
                        state.pengumumanList.data[index].publisherDate,
                      ),
                      kategori:
                      state.pengumumanList.data[index].categories.isEmpty
                          ? 'Umum'
                          : state.pengumumanList.data[index].categories[0]
                          .categoryId ==
                          4
                          ? 'Umum\n'
                          : state.pengumumanList.data[index]
                          .categories[0].categoryName,
                      image: state.pengumumanList.data[index].thumbnailImage ==
                          ""
                          ? AssetImage('assets/default-con/pengumuman.png')
                          : NetworkImage(
                        state.pengumumanList.data[index].thumbnailImage,
                      ),
                      leftMargin: 0,
                      rightMargin: 0,
                      pengumuman: state.pengumumanList.data[index],
                      function: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                BeritaDanPengumumanSubPage(
                                  category: state.pengumumanList.data[index]
                                      .categories[0].categoryId ==
                                      4
                                      ? 'Umum'
                                      : state.pengumumanList.data[index]
                                      .categories[0].categoryName,
                                  id: state.pengumumanList.data[index].id,
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
    return pengumumanLoading();
  }
}
