import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/pages/beranda/berita/bloc/berita_bloc.dart';
import 'package:app/presentation/pages/beranda/berita/component/buildList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BeritaListView extends StatefulWidget {
  final String kategori;

  const BeritaListView({Key? key, required this.kategori}) : super(key: key);

  @override
  _BeritaListViewState createState() => _BeritaListViewState();
}

class _BeritaListViewState extends State<BeritaListView> {
  ScrollController _scrollController = new ScrollController();
  late BeritaBloc _beritaBloc;

  void onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;

    if (currentScroll == maxScroll) {
      _beritaBloc.add(GetBeritaEvent(category: widget.kategori));
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _beritaBloc = BlocProvider.of<BeritaBloc>(context);
    _scrollController.addListener(onScroll);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            (widget.kategori == "1") ? "Berita Terbaru" : "Berita Populer",
            style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 1),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: appBarGradient,
            ),
          ),
          backgroundColor: blueLinear1,
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          child:
              BlocBuilder<BeritaBloc, BeritaState>(builder: (context, state) {
            if (state is BeritaLoadingState) {
              return Center(
                child: CircularProgressIndicator(
                  color: blueLinear1,
                ),
              );
            } else if (state is BeritaNoInternetState) {
              return NoInternet(
                onPressed: () {
                  _beritaBloc.add(GetBeritaEvent(category: widget.kategori));
                },
                buttonHide: false,
              );
            } else if (state is BeritaErrorState) {
              return SizedBox();
            } else if (state is BeritaLoadedState) {
              if (state.newsList.length == 0) {
                return SizedBox();
              } else {
                return Padding(
                  padding: const EdgeInsets.only(top: 28.0),
                  child: buildNewsList(
                      state.newsList, state.hasReachedMax, _scrollController),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: blueLinear1,
                ),
              );
            }
          }),
        ));
  }
}
