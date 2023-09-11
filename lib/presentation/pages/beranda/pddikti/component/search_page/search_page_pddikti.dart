import 'package:app/data/source/remote/model/berita/newsList.dart' as news;
import 'package:app/data/source/remote/model/modul.dart' as modul;
import 'package:app/data/source/remote/model/pengumuman/pengumumanList.dart'
    as pengumuman;
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/component/search/searchBar.dart';
import 'package:app/presentation/component/server_problem.dart';
import 'package:app/presentation/pages/beranda/searchPage/bloc/searchpage_bloc.dart';
import 'package:app/presentation/pages/beranda/searchPage/component/searchNotFound.dart';
import 'package:app/presentation/pages/beranda/searchPage/searchResults.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchPagePddikti extends StatefulWidget {
  final bool isPengumuman, isBerita, isBeranda, isFAQ;
  final String hintText;

  const SearchPagePddikti({
    Key? key,
    this.isPengumuman = false,
    this.isBerita = false,
    this.isBeranda = false,
    required this.hintText,
    this.isFAQ = false,
  }) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPagePddikti> {
  final TextEditingController textEditingController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.locator<SearchpageBloc>(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: whiteBgPage,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              toolbarHeight: 80.w,
              backgroundColor: Colors.transparent,
              elevation: 0,
              titleSpacing: 0,
              leading: Padding(
                padding: EdgeInsets.only(left: 7.8.w),
                child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: abu7,
                      size: 24.sp,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
              title: Padding(
                padding: EdgeInsets.only(left: 10.w, right: 20.w),
                child: SearchBar(
                    controller: textEditingController,
                    openKeyboard: true,
                    hintText: widget.hintText,
                    isSubmitted: (String keyword) {
                      isLoading = true;
                      search(context, keyword);
                    },
                    searchType: TypeSearchBar.withClear),
              ),
            ),
            body: BlocBuilder<SearchpageBloc, SearchpageState>(
              builder: (context, state) {
                if (state is SearchpageInitialState ||
                    textEditingController.text.isEmpty) {
                  return SizedBox();
                } else if (isLoading) {
                  Future.delayed(Duration(milliseconds: 1500), () {
                    setState(() {
                      isLoading = false;
                    });
                  });
                  return Center(
                    child: CircularProgressIndicator(
                      color: blueLinear1,
                    ),
                  );
                } else if (state is SearchpageFAQLoadedState) {
                  return Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: ListView(
                      children: [resultFAQ(context, state.listFAQ)],
                    ),
                  );
                } else if (state is SearchpageBeritaLoadedState) {
                  return Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: resultBerita(
                      context,
                      textEditingController,
                      state.newsList,
                      widget.isBerita,
                    ),
                  );
                } else if (state is SearchpagePengumumanLoadedState) {
                  return Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: resultPengumuman(
                      context,
                      textEditingController,
                      state.pengumumanList,
                      widget.isPengumuman,
                    ),
                  );
                } else if (state is SearchpageBerandaLoadedState) {
                  var listModul = state.listModul ??
                      modul.AutoGenerate(
                          data: modul.Data(modul: []), message: '');

                  var pengumumanList = state.pengumumanList ??
                      pengumuman.PengumumanList(
                        currentPage: 0,
                        data: [],
                        lastPage: 0,
                        totalItem: 0,
                        totalItemPerPage: 0,
                      );

                  var newsList = state.newsList ??
                      news.NewsList(
                        currentPage: 0,
                        data: [],
                        lastPage: 0,
                        totalItem: 0,
                        totalItemPerPage: 0,
                      );

                  return Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: state.flagBerita |
                            state.flagPengumuman |
                            state.flagLayanan
                        ? ListView(
                            children: [
                              //
                              //Layanan
                              state.flagLayanan
                                  ? listModul.data.modul.isNotEmpty
                                      ? resultLayanan(context, listModul)
                                      : SizedBox()
                                  : SizedBox(),

                              //
                              //Pengumuman
                              state.flagPengumuman
                                  ? pengumumanList.data.isNotEmpty
                                      ? resultPengumuman(
                                          context,
                                          textEditingController,
                                          pengumumanList,
                                          widget.isPengumuman,
                                        )
                                      : SizedBox()
                                  : SizedBox(),

                              //
                              //Berita
                              state.flagBerita
                                  ? newsList.data.isNotEmpty
                                      ? resultBerita(
                                          context,
                                          textEditingController,
                                          newsList,
                                          widget.isBerita,
                                        )
                                      : SizedBox()
                                  : SizedBox(),
                            ],
                          )
                        : searchNotFound('Pencarian'),
                  );
                } else if (state is SearchpageNoInternetState) {
                  return NoInternet(
                    onPressed: () {
                      setState(() {
                        isLoading = true;
                      });
                      search(context, textEditingController.text);
                    },
                    buttonHide: isLoading == false ? false : true,
                  );
                } else if (state is SearchpageNotFoundState) {
                  return searchNotFound('Pencarian');
                } else {
                  return ServerProblem(onPressed: () {}, buttonHide: true);
                }
              },
            ),
          );
        },
      ),
    );
  }

  void search(BuildContext context, String keyword) {
    if (mounted) {
      if (widget.isFAQ == true) {
        print('masuk isFAQ');
        context.read<SearchpageBloc>().add(GetFAQSearchEvent(keyword: keyword));
      }
      if (widget.isBerita == true) {
        print('masuk isBerita');
        context
            .read<SearchpageBloc>()
            .add(GetNewsSearchEvent(keyword: keyword));
      }
      if (widget.isPengumuman == true) {
        print('masuk isPengumuman');
        context
            .read<SearchpageBloc>()
            .add(GetPengumumanSearchEvent(keyword: keyword));
      }
      if (widget.isBeranda == true) {
        print('masuk isTiga');
        context
            .read<SearchpageBloc>()
            .add(GetBerandaSearchEvent(keyword: keyword));
      }
    }
  }
}
