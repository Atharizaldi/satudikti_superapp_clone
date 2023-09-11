import 'package:app/common/dateFormat.dart';
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/pages/beranda/beritaDanPengumumanDetail/beritaDetail.dart';
import 'package:app/presentation/pages/beranda/beritaDanPengumumanDetail/bloc/berita_dan_pengumuman_bloc.dart';
import 'package:app/presentation/pages/beranda/beritaDanPengumumanDetail/pengumumanDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BeritaDanPengumumanSubPage extends StatefulWidget {
  final String? category;
  final int? id;

  const BeritaDanPengumumanSubPage(
      {Key? key, required this.category, required this.id})
      : super(key: key);

  @override
  _BeritaDanPengumumanSubPageState createState() =>
      _BeritaDanPengumumanSubPageState();
}

class _BeritaDanPengumumanSubPageState
    extends State<BeritaDanPengumumanSubPage> {
  FormatDate formatDate = new FormatDate();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        if (widget.category == "") {
          return di.locator<BeritaDanPengumumanBloc>()
            ..add(GetNewsDetailEvent(id: widget.id.toString()));
        } else {
          return di.locator<BeritaDanPengumumanBloc>()
            ..add(GetPengumumanDetailEvent(id: widget.id.toString()));
        }
      },
      child: BlocBuilder<BeritaDanPengumumanBloc, BeritaDanPengumumanState>(
          builder: (context, state) {
        if (state is BeritaDanPengumumanNoInternetState) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                widget.category == "" ? "Berita" : "Pengumuman",
                style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 1),
              ),
              centerTitle: true,
              flexibleSpace: Container(
                decoration: BoxDecoration(gradient: appBarGradient),
              ),
            ),
            body: NoInternet(
                onPressed: () {
                  if (widget.category == "") {
                    return BlocProvider.of<BeritaDanPengumumanBloc>(context)
                        .add(GetNewsDetailEvent(id: widget.id.toString()));
                  } else {
                    return BlocProvider.of<BeritaDanPengumumanBloc>(context)
                        .add(
                            GetPengumumanDetailEvent(id: widget.id.toString()));
                  }
                },
                buttonHide: false),
          );
        } else if (state is BeritaLoadedState) {
          return beritaDetail(
              context, state.newsDetail, formatDate, state.newsDetail.newsId);
        } else if (state is PengumumanLoadedState) {
          return PengumumanDetailPage(
            pengumumanDetail: state.pengumumanDetail,
            formatDate: formatDate,
            category: widget.category,
            pengumumanId: state.pengumumanDetail.id,
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: appBarGradient,
                ),
              ),
            ),
            body: Center(
              child: CircularProgressIndicator(
                color: blueLinear1,
              ),
            ),
          );
        }
      }),
    );
  }
}
