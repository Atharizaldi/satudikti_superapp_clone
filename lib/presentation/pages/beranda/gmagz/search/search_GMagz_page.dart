import 'dart:async';

import 'package:app/common/baseUrl.dart';
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/component/search/searchBar.dart';
import 'package:app/presentation/component/server_problem.dart';
import 'package:app/presentation/pages/beranda/gmagz/bloc/detailmajalah/majalah_detail_gmagz_bloc.dart';
import 'package:app/presentation/pages/beranda/gmagz/bloc/majalah/majalah_gmagz_bloc.dart';
import 'package:app/presentation/pages/beranda/gmagz/component/list_majalah.dart';
import 'package:app/presentation/pages/beranda/gmagz/component/majalah_not_found.dart';
import 'package:app/presentation/pages/beranda/gmagz/detailPage/detail_page.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/reusableWidgets/reusableWidgetsCard.dart';
import 'package:app/presentation/pages/beranda/searchPage/component/searchNotFound.dart';
import 'package:app/presentation/pages/beranda/sinta/sinta_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchGMagz extends StatefulWidget {
  const SearchGMagz({Key? key}) : super(key: key);

  @override
  State<SearchGMagz> createState() => _SearchGMagzState();
}

class _SearchGMagzState extends State<SearchGMagz> {
  TextEditingController textEditingController = TextEditingController();
  late MajalahGMagzBloc _majalahGMagzBloc;

  bool max = false;

  ScrollController _scrollController = ScrollController();
  @override
  void dispose() {
    textEditingController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void onScroll(BuildContext context) {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;

    if (currentScroll == maxScroll) {
      _majalahGMagzBloc.add(GetMajalahGMagzEvent(
          sort: "", judul: _majalahGMagzBloc.keywordSearch, displayby: ""));
    }
  }

  @override
  Widget build(BuildContext context) {
    final removeTag = RegExp(r'<[^>]*>');
    return Builder(builder: (context) {
      _majalahGMagzBloc = BlocProvider.of<MajalahGMagzBloc>(context);
      _scrollController.addListener(() {
        onScroll(context);
      });
      return Scaffold(
          backgroundColor: whiteBgPage,
          resizeToAvoidBottomInset: false,
          appBar: CustomAppBar(
            title: 'Hasil Pencarian',
            textStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
          ),
          body: BlocBuilder<MajalahGMagzBloc, MajalahGMagzState>(
            builder: (context, state) {
              if (state is MajalahGMagzinInitial) {
                return Container();
              } else if (state is MajalahGMagzNoInternetState) {
                return Container(
                  color: Colors.transparent,
                  height: screenHeight(context) * 0.5,
                  child: NoInternet(
                      onPressed: () {
                        _majalahGMagzBloc.add(GetMajalahGMagzEvent(
                            sort: "",
                            judul: _majalahGMagzBloc.keywordSearch,
                            displayby: ""));
                      },
                      buttonHide: false),
                );
              } else if (state is MajalahGMagzErrorState) {
                return Center(child: serverProblem());
              } else if (state is MajalahGMagzLoading) {
                return sintaSearchSkeleton();
              } else if (state is MajalahGMagzLoadedState) {
                if (state.listBook.isEmpty) {
                  return Center(child: searchNotFound("Pencarian"));
                } else {
                  return ListView(
                    controller: _scrollController,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 20.w),
                        child: SearchBar(
                          controller: textEditingController,
                          openKeyboard: true,
                          hintText: 'Cari majalah...',
                          searchType: TypeSearchBar.withClear,
                          isSubmitted: (value) {
                            _majalahGMagzBloc.add(GetMajalahGMagzEvent(
                                sort: "", judul: value, displayby: ""));
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          children: [
                            Text(
                              "Menemukan ",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromRGBO(128, 128, 128, 1),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Plus Jakarta Sans"),
                            ),
                            Text(
                              state.totalRowCount.toString(),
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromRGBO(51, 51, 51, 1),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Plus Jakarta Sans"),
                            ),
                            Text(
                              " majalah dengan kata kunci ",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromRGBO(128, 128, 128, 1),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Plus Jakarta Sans"),
                            ),
                            Text(
                              state.judul,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromRGBO(51, 51, 51, 1),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Plus Jakarta Sans"),
                            )
                          ],
                        ),
                      ),
                      ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: (state.hasReachedMax)
                            ? state.listBook.length
                            : state.listBook.length + 1,
                        itemBuilder: (context, index) {
                          if (index < state.listBook.length) {
                            return MajalahPopulerCard(
                              imageURL:
                                  "$urlAPI${state.listBook[index].uriCover.filePath}",
                              // imageURL:
                              //     "$urlAPI${state.listBook[index].uriCover.filePath}",
                              judulMajalah: state.listBook[index].judul,
                              penilaian: state.listBook[index].rating,
                              review: state.listBook[index].totalReview,
                              description: state.listBook[index].sinopsis != ''
                                  ? state.listBook[index].sinopsis
                                      .replaceAll(removeTag, '')
                                  : "-",
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BlocProvider(
                                              create: (context) => di.locator<
                                                  MajalahDetailGMagzBloc>()
                                                ..add(
                                                    GetMajalahDetailGMagzEvent(
                                                        id: state
                                                            .listBook[index]
                                                            .idBook)),
                                              child: DetailMagPage(),
                                            )));
                              },
                            );
                          } else {
                            return Center(
                              child: SizedBox(
                                width: 30,
                                height: 30,
                                child: CircularProgressIndicator(
                                    color: blueLinear1),
                              ),
                            );
                          }
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(height: 12.h);
                        },
                      )
                    ],
                  );
                }
              } else {
                if (state is MajalahGMagzNoInternetState) {
                  return Container(
                    color: Colors.transparent,
                    height: screenHeight(context) * 0.5,
                    child: NoInternet(
                        onPressed: () {
                          _majalahGMagzBloc.add(GetMajalahGMagzEvent(
                              sort: "",
                              judul: _majalahGMagzBloc.keywordSearch,
                              displayby: ""));
                        },
                        buttonHide: false),
                  );
                } else if (state is MajalahGMagzNotFoundState) {
                  return ListView(
                    shrinkWrap: true,
                    controller: _scrollController,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 20.w),
                        child: SearchBar(
                          controller: textEditingController,
                          openKeyboard: true,
                          hintText: 'Pencarian Layanan',
                          searchType: TypeSearchBar.withClear,
                          isSubmitted: (value) {
                            _majalahGMagzBloc.add(GetMajalahGMagzEvent(
                              sort: "",
                              judul: Uri.encodeComponent(value),
                              displayby: "",
                            ));
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          children: [
                            Text(
                              "Menemukan ",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color.fromRGBO(128, 128, 128, 1),
                                fontWeight: FontWeight.w500,
                                fontFamily: "Plus Jakarta Sans",
                              ),
                            ),
                            Text(
                              "0",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color.fromRGBO(51, 51, 51, 1),
                                fontWeight: FontWeight.w500,
                                fontFamily: "Plus Jakarta Sans",
                              ),
                            ),
                            Text(
                              " majalah dengan kata kunci ",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color.fromRGBO(128, 128, 128, 1),
                                fontWeight: FontWeight.w500,
                                fontFamily: "Plus Jakarta Sans",
                              ),
                            ),
                            Text(
                              _majalahGMagzBloc.keywordSearch,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color.fromRGBO(51, 51, 51, 1),
                                fontWeight: FontWeight.w500,
                                fontFamily: "Plus Jakarta Sans",
                              ),
                            ),
                          ],
                        ),
                      ),
                      majalahNotFound(),
                    ],
                  );
                } else if (state is MajalahGMagzErrorState) {
                  return Container(
                    color: Colors.transparent,
                    height: screenHeight(context) * 0.5,
                    child: ServerProblem(
                        onPressed: () {
                          Timer(Duration(seconds: 5), () {
                            CircularProgressIndicator();
                          });
                          _majalahGMagzBloc.add(GetMajalahGMagzEvent(
                              sort: "",
                              judul: _majalahGMagzBloc.keywordSearch,
                              displayby: ""));
                        },
                        buttonHide: false),
                  );
                } else {
                  return Container(
                    color: Colors.transparent,
                    height: screenHeight(context) * 0.5,
                    child: ServerProblem(
                        onPressed: () {
                          _majalahGMagzBloc.add(GetMajalahGMagzEvent(
                              sort: "",
                              judul: _majalahGMagzBloc.keywordSearch,
                              displayby: ""));
                        },
                        buttonHide: false),
                  );
                }
              }
            },
          ));
    });
  }
}
