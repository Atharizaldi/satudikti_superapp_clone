import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/pages/beranda/beritaDanPengumumanDetail/beritaDanPengumumanSubPage.dart';
import 'package:app/presentation/pages/beranda/searchPage/bloc/searchpagemoreresults_bloc.dart';
import 'package:app/presentation/pages/beranda/searchPage/component/newListStyleCardSearch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchMoreBeritaBody extends StatefulWidget {
  final String searchKeyword;
  const SearchMoreBeritaBody({
    Key? key,
    required this.searchKeyword,
  }) : super(key: key);

  @override
  State<SearchMoreBeritaBody> createState() => _SearchMoreBeritaBodyState();
}

class _SearchMoreBeritaBodyState extends State<SearchMoreBeritaBody> {
  ScrollController _scrollController = new ScrollController();
  late SearchpagemoreresultsBloc _searchpagemoreresultsBloc;

  void onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;

    if (currentScroll == maxScroll) {
      _searchpagemoreresultsBloc
          .add(GetMoreNewsResultsEvent(keyword: widget.searchKeyword));
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
          ..add(GetMoreNewsResultsEvent(keyword: widget.searchKeyword));
    _scrollController.addListener(onScroll);
    return BlocBuilder<SearchpagemoreresultsBloc, SearchpagemoreresultsState>(
      builder: (context, state) {
        if (state is SearchpagemoreresultsLoadingState) {
          return Center(
            child: CircularProgressIndicator(color: blueLinear1),
          );
        } else if (state is SearchpagemoreresultsBeritaLoadedState) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 24.h,
                ),
                Text(
                  "Berita",
                  style: TextStyle(
                    color: blue3,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.hasReachedMax
                        ? state.newsList.length
                        : state.newsList.length + 1,
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      if (index < state.newsList.length) {
                        return NewListStyleCardSearch(
                          function: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      BeritaDanPengumumanSubPage(
                                          category: '',
                                          id: state.newsList[index].newsId),
                                ));
                          },
                          image: state.newsList[index].thumbnailImage == ''
                              ? 'assets/default-con/berita.png'
                              : state.newsList[index].thumbnailImage,
                          judul: state.newsList[index].title,
                          tanggal: state.newsList[index].publisherDate,
                          kategori: "",
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
              _searchpagemoreresultsBloc
                  .add(GetMoreNewsResultsEvent(keyword: widget.searchKeyword));
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
