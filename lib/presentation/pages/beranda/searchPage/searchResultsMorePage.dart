import 'package:app/data/source/remote/model/berita/newsList.dart';
import 'package:app/data/source/remote/model/pengumuman/pengumumanList.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/search/searchBar.dart';
import 'package:app/presentation/pages/beranda/searchPage/bloc/searchpagemoreresults_bloc.dart';
import 'package:app/presentation/pages/beranda/searchPage/component/searchMoreBeritaBody.dart';
import 'package:app/presentation/pages/beranda/searchPage/component/searchMorePengumumanBody.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchResultMorePage extends StatefulWidget {
  final String type;
  final NewsList? newsList;
  final PengumumanList? pengumumanList;
  final TextEditingController textEditingController;

  const SearchResultMorePage({
    Key? key,
    required this.type,
    this.newsList,
    this.pengumumanList,
    required this.textEditingController,
  }) : super(key: key);

  @override
  _SearchResultMorePageState createState() => _SearchResultMorePageState();
}

class _SearchResultMorePageState extends State<SearchResultMorePage> {
  int page = 1;
  bool scrollLoading = false;
  late SearchpagemoreresultsBloc _searchpagemoreresultsBloc;

  @override
  Widget build(BuildContext context) {
    _searchpagemoreresultsBloc =
        BlocProvider.of<SearchpagemoreresultsBloc>(context);
    return Scaffold(
      backgroundColor: whiteBgPage,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 80.h,
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
              widget.pengumumanList?.data.clear();
              widget.newsList?.data.clear();
              Navigator.pop(context);
            },
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(left: 10.w, right: 20.w),
          child: SearchBar(
            iconColor: abu8,
            controller: widget.textEditingController,
            openKeyboard: false,
            hintText: 'Cari informasi layanan',
            isSubmitted: (String field) {
              if (widget.type == 'pengumuman') {
                _searchpagemoreresultsBloc
                  ..add(GetMorePengumumanResultsEvent(
                      keyword: widget.textEditingController.text));
              } else {
                _searchpagemoreresultsBloc
                  ..add(GetMoreNewsResultsEvent(
                      keyword: widget.textEditingController.text));
              }
            },
            searchType: TypeSearchBar.withClear,
          ),
        ),
      ),
      body: widget.type == 'pengumuman'
          ? SearchMorePengumumanBody(
              searchKeyword: widget.textEditingController.text,
            )
          : SearchMoreBeritaBody(
              searchKeyword: widget.textEditingController.text,
            ),
    );
  }
}
