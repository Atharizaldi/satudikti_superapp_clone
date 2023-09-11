import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/pages/beranda/pengumuman/component/buildList.dart';
import 'package:app/presentation/pages/beranda/pengumuman/component/noData.dart';
import 'package:app/presentation/pages/beranda/pengumuman/kelembagaan/bloc/pengumuman_kelembagaan_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class PengumumanKelembagaanListPage extends StatefulWidget {
  @override
  _PengumumanKelembagaanListPageState createState() =>
      _PengumumanKelembagaanListPageState();
}

class _PengumumanKelembagaanListPageState
    extends State<PengumumanKelembagaanListPage> {
  ScrollController _scrollController = new ScrollController();
  late PengumumanKelembagaanBloc _pengumumanKelembagaanBloc;
  Logger log = Logger();

  void onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;

    if (currentScroll == maxScroll) {
      _pengumumanKelembagaanBloc.add(GetPengumumanKelembagaanEvent());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _pengumumanKelembagaanBloc =
        BlocProvider.of<PengumumanKelembagaanBloc>(context);
    _scrollController.addListener(onScroll);
    return BlocBuilder<PengumumanKelembagaanBloc, PengumumanKelembagaanState>(
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
            _pengumumanKelembagaanBloc.add(GetPengumumanKelembagaanEvent());
          },
          buttonHide: false,
        );
      } else if (state is PengumumanErrorState) {
        return noData(context);
      } else if (state is PengumumanLoadedState) {
        if (state.pengumumanList.length == 0) {
          return noData(context);
        } else {
          return buildPengumumanList('20', state.pengumumanList,
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
