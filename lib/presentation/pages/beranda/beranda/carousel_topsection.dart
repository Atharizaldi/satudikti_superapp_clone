import 'package:app/presentation/pages/beranda/beranda/bloc/beranda_bloc.dart';
import 'package:app/presentation/pages/beranda/beranda/component/bannerBeritaPengumuman.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../component/constant.dart';

Widget carouselTopSection(BuildContext context, BerandaState state) {
  if (state is BerandaLoadedState) {
    BerandaBloc bloc = BlocProvider.of<BerandaBloc>(context);
    if (bloc.isNewsListEmpty(state.popularBeritaList) &&
        bloc.isNewsListEmpty(state.recentBeritaList)) {
      return CircularProgressIndicator();
    } else {
      return Container(
        // color: whiteBgPage,
        //322 from blue bg + 26 = 348 from half size search bar
        height: 348.h,
        child: Stack(children: [
          //bg blue
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: double.infinity,
              height: 322.h,
              decoration: BoxDecoration(gradient: berandaBgGradient),
            ),
          ),
          Positioned(
            top: 42,
            left: 16,
            right: 16,
            child: Container(
                child: BannerBeritaPengumuman(
              recentNewsList: state.recentBeritaList,
              recentPengumumanList: state.pengumumanList,
            )),
          ),
        ]),
      );
    }
  } else {
    return CircularProgressIndicator();
  }
}
