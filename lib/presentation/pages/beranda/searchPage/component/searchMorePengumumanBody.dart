import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/pages/beranda/beritaDanPengumumanDetail/beritaDanPengumumanSubPage.dart';
import 'package:app/presentation/pages/beranda/searchPage/bloc/searchpagemoreresults_bloc.dart';
import 'package:app/presentation/pages/beranda/searchPage/component/newListStyleCardSearch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchMorePengumumanBody extends StatefulWidget {
  final String searchKeyword;

  const SearchMorePengumumanBody({
    Key? key,
    required this.searchKeyword,
  }) : super(key: key);

  @override
  State<SearchMorePengumumanBody> createState() =>
      _SearchMorePengumumanBodyState();
}

class _SearchMorePengumumanBodyState extends State<SearchMorePengumumanBody> {
  ScrollController _scrollController = new ScrollController();
  late SearchpagemoreresultsBloc _searchpagemoreresultsBloc;

  void onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;

    if (currentScroll == maxScroll) {
      _searchpagemoreresultsBloc
          .add(GetMorePengumumanResultsEvent(keyword: widget.searchKeyword));
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _searchpagemoreresultsBloc =
        BlocProvider.of<SearchpagemoreresultsBloc>(context)
          ..add(GetMorePengumumanResultsEvent(keyword: widget.searchKeyword));
    _scrollController.addListener(onScroll);
    return BlocBuilder<SearchpagemoreresultsBloc, SearchpagemoreresultsState>(
      builder: (context, state) {
        if (state is SearchpagemoreresultsLoadingState) {
          return Center(
            child: CircularProgressIndicator(color: blueLinear1),
          );
        } else if (state is SearchpagemoreresultsPengumumanLoadedState) {
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 24.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    "Pengumuman",
                    style: TextStyle(
                      color: blue3,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.hasReachedMax
                        ? state.pengumumanList.length
                        : state.pengumumanList.length + 1,
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      if (index < state.pengumumanList.length) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: NewListStyleCardSearch(
                            function: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        BeritaDanPengumumanSubPage(
                                      category: state.pengumumanList[index]
                                          .categories[0].categoryName,
                                      id: state.pengumumanList[index].id,
                                    ),
                                  ));
                            },
                            image: state.pengumumanList[index].thumbnailImage ==
                                    ""
                                ? 'assets/default-con/pengumuman.png'
                                : state.pengumumanList[index].thumbnailImage,
                            judul: state.pengumumanList[index].title,
                            tanggal: state.pengumumanList[index].publisherDate,
                            kategori: state.pengumumanList[index].categories[0]
                                .categoryName,
                          ),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(color: blueLinear1),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        } else if (state is SearchpagemoreresultsNoInternetState) {
          return NoInternet(
            onPressed: () {
              _searchpagemoreresultsBloc.add(
                  GetMorePengumumanResultsEvent(keyword: widget.searchKeyword));
            },
            buttonHide: false,
          );
        } else {
          print('unimplemented, $state');
          return SizedBox();
        }
      },
    );
  }
}
