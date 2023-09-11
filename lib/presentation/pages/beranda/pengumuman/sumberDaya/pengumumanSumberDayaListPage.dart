import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/pages/beranda/pengumuman/component/buildList.dart';
import 'package:app/presentation/pages/beranda/pengumuman/component/noData.dart';
import 'package:app/presentation/pages/beranda/pengumuman/sumberDaya/bloc/pengumuman_sumber_daya_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class PengumumanSumberDayaListPage extends StatefulWidget {
  @override
  _PengumumanSumberDayaListPageState createState() =>
      _PengumumanSumberDayaListPageState();
}

class _PengumumanSumberDayaListPageState
    extends State<PengumumanSumberDayaListPage> {
  ScrollController _scrollController = new ScrollController();
  late PengumumanSumberDayaBloc _pengumumanSumberDayaBloc;
  Logger log = Logger();

  void onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;

    if (currentScroll == maxScroll) {
      _pengumumanSumberDayaBloc.add(GetPengumumanSumberDayaEvent());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _pengumumanSumberDayaBloc =
        BlocProvider.of<PengumumanSumberDayaBloc>(context);
    _scrollController.addListener(onScroll);
    return BlocBuilder<PengumumanSumberDayaBloc, PengumumanSumberDayaState>(
      builder: (context, state) {
        if (state is PengumumanLoadingState) {
          return Center(
            child: CircularProgressIndicator(
              color: blueLinear1,
            ),
          );
        } else if (state is PengumumanNoInternetState) {
          return NoInternet(
            onPressed: () {
              _pengumumanSumberDayaBloc.add(GetPengumumanSumberDayaEvent());
            },
            buttonHide: false,
          );
        } else if (state is PengumumanErrorState) {
          return noData(context);
        } else if (state is PengumumanLoadedState) {
          if (state.pengumumanList.length == 0) {
            return noData(context);
          } else {
            return buildPengumumanList('23', state.pengumumanList,
                state.hasReachedMax, _scrollController, context);
          }
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: blueLinear1,
            ),
          );
        }
      },
    );
  }
}
