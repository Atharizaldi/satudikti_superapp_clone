import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/pages/beranda/pengumuman/component/buildList.dart';
import 'package:app/presentation/pages/beranda/pengumuman/component/noData.dart';
import 'package:app/presentation/pages/beranda/pengumuman/umum/bloc/pengumuman_umum_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PengumumanUmumListPage extends StatefulWidget {
  @override
  _PengumumanUmumListPageState createState() => _PengumumanUmumListPageState();
}

class _PengumumanUmumListPageState extends State<PengumumanUmumListPage> {
  ScrollController _scrollController = new ScrollController();
  late PengumumanUmumBloc _pengumumanUmumBloc;

  void onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;

    if (currentScroll == maxScroll) {
      _pengumumanUmumBloc.add(GetPengumumanEvent());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _pengumumanUmumBloc = BlocProvider.of<PengumumanUmumBloc>(context);
    _scrollController.addListener(onScroll);
    return BlocBuilder<PengumumanUmumBloc, PengumumanUmumState>(
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
            _pengumumanUmumBloc.add(GetPengumumanEvent());
          },
          buttonHide: false,
        );
      } else if (state is PengumumanErrorState) {
        return noData(context);
      } else if (state is PengumumanLoadedState) {
        if (state.pengumumanList.length == 0) {
          return noData(context);
        } else {
          return buildPengumumanList('4', state.pengumumanList,
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
