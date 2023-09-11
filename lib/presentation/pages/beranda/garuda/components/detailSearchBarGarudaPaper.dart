import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/search/searchBar.dart';
import 'package:app/presentation/pages/beranda/garuda/bloc/garuda_paper/garuda_paper_bloc.dart';
import 'package:app/presentation/pages/beranda/garuda/components/newListStyleCardGaruda.dart';
import 'package:app/presentation/pages/beranda/garuda/components/skeletonLoadingGarudaPaper.dart';
import 'package:app/presentation/pages/beranda/garuda/paper/detailpaper.dart';
import 'package:app/presentation/pages/beranda/garuda/widgetSlidingUpGaruda.dart';
import 'package:app/presentation/pages/beranda/searchPage/component/searchNotFound.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailSearchBarGarudaPaper extends StatefulWidget {
  const DetailSearchBarGarudaPaper({Key? key}) : super(key: key);

  @override
  State<DetailSearchBarGarudaPaper> createState() =>
      _DetailSearchBarGarudaPaperState();
}

class _DetailSearchBarGarudaPaperState
    extends State<DetailSearchBarGarudaPaper> {
  TextEditingController textEditingController = TextEditingController();

  List<OptionFilter> listOptions = [
    OptionFilter(name: "Paper"),
    OptionFilter(name: "Jurnal"),
    OptionFilter(name: "Conference"),
    OptionFilter(name: "Subject")
  ];
  String? searchKeyword;

  late GarudaPaperBloc garudaPaperBloc;
  ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(fontSize: 14.sp, color: neutral50);
    return BlocProvider(
      create: (context) => di.locator<GarudaPaperBloc>(),
      child: Builder(builder: (context) {
        garudaPaperBloc = BlocProvider.of<GarudaPaperBloc>(context);
        scrollController.addListener(() {
          onScroll(context, searchKeyword.toString());
        });
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
                  hintText: 'Pencarian Layanan',
                  listOption: listOptions,
                  isSubmitted: (String keyword) {
                    setState(() {
                      searchKeyword = keyword;
                      _onSearch(context, keyword);
                    });
                  },
                  searchType: TypeSearchBar.withClear,
                  // customHeight: 87.5.w,
                ),
              ),
            ),
            body: BlocBuilder<GarudaPaperBloc, GarudaPaperState>(
              builder: (context, state) {
                if (state is GarudaPaperLoading) {
                  return SkeletonLoadingGarudaPaper();
                } else if (state is GarudaPaperLoaded) {
                  final data = state.garudaPaperObject.data!.total;
                  return SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15.sp,
                        ),
                        _jumlahPencarian(textStyle, data),
                        SizedBox(
                          height: 21.w,
                        ),
                        ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: (state.hasReachedMax)
                              ? state.garudaPaper.length
                              : state.garudaPaper.length + 1,
                          itemBuilder: (context, index) {
                            if (index < state.garudaPaper.length) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 28.h),
                                child: NewListStyleGarudaPaperSearch(
                                  heightSpace: 0,
                                  function: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DetailPaperGaruda(
                                                  journalDescription: state
                                                      .garudaPaper[index]
                                                      .journalPaper
                                                      .journalDescription,
                                                  journalEissn: state
                                                      .garudaPaper[index]
                                                      .journalPaper
                                                      .journalEissn,
                                                  downloadRis: state
                                                      .garudaPaper[index]
                                                      .downloadRis,
                                                  downloadBibtex: state
                                                      .garudaPaper[index]
                                                      .downloadBibtex,
                                                  downloadOriginal: state
                                                      .garudaPaper[index]
                                                      .downloadOriginal,
                                                  issn: state.garudaPaper[index]
                                                      .journalPaper.journalIssn,
                                                  abstract: state
                                                      .garudaPaper[index]
                                                      .abstract,
                                                  journalName: state
                                                      .garudaPaper[index]
                                                      .journalPaper
                                                      .journalName
                                                      .toString(),
                                                  publisher: state
                                                      .garudaPaper[index]
                                                      .publisher,
                                                  sourceIssue: state
                                                      .garudaPaper[index]
                                                      .sourceIssue,
                                                  sourceName: state
                                                      .garudaPaper[index]
                                                      .sourceName,
                                                  title: state
                                                      .garudaPaper[index].title,
                                                )));
                                  },
                                  title: state.garudaPaper[index].title,
                                  subTitle: state.garudaPaper[index].sourceName,
                                  judulJurnal: state.garudaPaper[index]
                                      .journalPaper.journalName,
                                  univ: state.garudaPaper[index].publisher,
                                ),
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
                        ),
                        SizedBox(
                          height: 30.w,
                        ),
                      ],
                    ),
                  );
                } else if (state is GarudaPaperNotFound) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 15.sp,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 2.w,
                            ),
                            Image.asset(
                              'assets/icons/search_active.png',
                              width: 18.67.sp,
                              height: 17.88.sp,
                              color: neutral10,
                            ),
                            SizedBox(
                              width: 16.33.sp,
                            ),
                            Flexible(
                              child: RichText(
                                  text: TextSpan(children: [
                                TextSpan(text: "Menemukan ", style: textStyle),
                                TextSpan(
                                    text: "0 ",
                                    style: textStyle.copyWith(
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: "dokumen Search ", style: textStyle),
                                TextSpan(
                                    text: "$searchKeyword ",
                                    style: textStyle.copyWith(
                                        fontWeight: FontWeight.bold))
                              ])),
                            )
                          ],
                        ),
                      ),
                      Flexible(child: searchNotFound('Paper'))
                    ],
                  );
                } else if (state is GarudaPaperNoInternet) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 150.h,
                      ),
                      WidgetNoInternetGaruda()
                    ],
                  );
                } else if (state is GarudaPaperServerProblem) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 15.sp,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 2.w,
                            ),
                            Image.asset(
                              'assets/icons/search_active.png',
                              width: 18.67.sp,
                              height: 17.88.sp,
                              color: neutral10,
                            ),
                            SizedBox(
                              width: 16.33.sp,
                            ),
                            Flexible(
                              child: RichText(
                                  text: TextSpan(children: [
                                TextSpan(text: "Menemukan ", style: textStyle),
                                TextSpan(
                                    text: "0 ",
                                    style: textStyle.copyWith(
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: "dokumen Search ", style: textStyle),
                                TextSpan(
                                    text: "$searchKeyword ",
                                    style: textStyle.copyWith(
                                        fontWeight: FontWeight.bold))
                              ])),
                            )
                          ],
                        ),
                      ),
                      Flexible(child: searchNotFound('Paper'))
                    ],
                  );
                }
                return Container();
              },
            ));
      }),
    );
  }

  Widget _jumlahPencarian(TextStyle textStyle, int jumlahPencarian) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          SizedBox(
            width: 2.w,
          ),
          Image.asset(
            'assets/icons/search_active.png',
            width: 18.67.sp,
            height: 17.88.sp,
            color: neutral10,
          ),
          SizedBox(
            width: 16.33.sp,
          ),
          Flexible(
            child: RichText(
                text: TextSpan(children: [
              TextSpan(text: "Menemukan ", style: textStyle),
              TextSpan(
                  text: "$jumlahPencarian ",
                  style: textStyle.copyWith(fontWeight: FontWeight.bold)),
              TextSpan(text: "dokumen Search ", style: textStyle),
              TextSpan(
                  text: "$searchKeyword ",
                  style: textStyle.copyWith(fontWeight: FontWeight.bold))
            ])),
          )
        ],
      ),
    );
  }

  void _onSearch(BuildContext context, String keyword) {
    if (mounted) {
      context
          .read<GarudaPaperBloc>()
          .add(GarudaPaperSearchEvent(keyword: keyword));
    }
  }

  void onScroll(BuildContext context, String keyword) {
    double maxScroll = scrollController.position.maxScrollExtent;
    double currentScroll = scrollController.position.pixels;

    if (currentScroll == maxScroll) {
      garudaPaperBloc.add(GarudaPaperSearchEvent(keyword: keyword));
    }
  }
}
