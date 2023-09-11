import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/pages/beranda/pengumuman/component/buildList.dart';
import 'package:app/presentation/pages/beranda/pengumuman/component/noData.dart';
import 'package:app/presentation/pages/beranda/pengumuman/pembelajaranDanMahasiswa/bloc/pengumuman_pembelajaran_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class PengumumanPembelajaranListPage extends StatefulWidget {
  @override
  _PengumumanPembelajaranListPageState createState() =>
      _PengumumanPembelajaranListPageState();
}

class _PengumumanPembelajaranListPageState
    extends State<PengumumanPembelajaranListPage> {
  ScrollController _scrollController = new ScrollController();
  late PengumumanPembelajaranBloc _pengumumanPembelajaranBloc;
  Logger log = Logger();

  void onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;

    if (currentScroll == maxScroll) {
      _pengumumanPembelajaranBloc.add(GetPengumumanPembelajaranEvent());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _pengumumanPembelajaranBloc =
        BlocProvider.of<PengumumanPembelajaranBloc>(context);
    _scrollController.addListener(onScroll);
    return BlocBuilder<PengumumanPembelajaranBloc, PengumumanPembelajaranState>(
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
            _pengumumanPembelajaranBloc.add(GetPengumumanPembelajaranEvent());
          },
          buttonHide: false,
        );
      } else if (state is PengumumanErrorState) {
        return noData(context);
      } else if (state is PengumumanLoadedState) {
        if (state.pengumumanList.length == 0) {
          return noData(context);
        } else {
          return buildPengumumanList('5', state.pengumumanList,
              state.hasReachedMax, _scrollController, context);
        }
      } else {
        return Center(
          child: CircularProgressIndicator(
            color: blueLinear1,
          ),
        );
      }
    });
  }
}
