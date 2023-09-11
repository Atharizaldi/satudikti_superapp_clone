import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/pages/beranda/garuda/bloc/garuda_paper/garuda_paper_bloc.dart';
import 'package:app/presentation/pages/beranda/garuda/components/newListStyleCardGaruda.dart';
import 'package:app/presentation/pages/beranda/garuda/components/skeletonLoadingGarudaPaper.dart';
import 'package:app/presentation/pages/beranda/garuda/paper/detailpaper.dart';
import 'package:app/presentation/pages/beranda/garuda/widgetSlidingUpGaruda.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GarudaPaperUmum extends StatefulWidget {
  final String keyword;
  const GarudaPaperUmum({Key? key, required this.keyword}) : super(key: key);

  @override
  State<GarudaPaperUmum> createState() => _GarudaPaperUmumState();
}

class _GarudaPaperUmumState extends State<GarudaPaperUmum> {
  late GarudaPaperBloc garudaPaperBloc;
  ScrollController scrollController = ScrollController();

  void onScroll(BuildContext context) {
    double maxScroll = scrollController.position.maxScrollExtent;
    double currentScroll = scrollController.position.pixels;

    if (currentScroll == maxScroll) {
      garudaPaperBloc.add(GarudaPaperSearchEvent(keyword: widget.keyword));
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      garudaPaperBloc = BlocProvider.of<GarudaPaperBloc>(context);
      scrollController.addListener(() {
        onScroll(context);
      });
      return Scaffold(
        appBar: CustomAppBar(title: "Paper"),
        body: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              BlocBuilder<GarudaPaperBloc, GarudaPaperState>(
                builder: (context, state) {
                  if (state is GarudaPaperLoaded) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20.w,
                          ),
                          ListView.builder(
                            // controller: scrollController,
                            padding: EdgeInsets.zero,
                            itemCount: (state.hasReachedMax)
                                ? state.garudaPaper.length
                                : state.garudaPaper.length + 1,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              if (index < state.garudaPaper.length) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 20.0.h),
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
                                                    issn: state
                                                        .garudaPaper[index]
                                                        .journalPaper
                                                        .journalIssn,
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
                                                        .garudaPaper[index]
                                                        .title,
                                                  )));
                                    },
                                    title: state.garudaPaper[index].title,
                                    subTitle:
                                        state.garudaPaper[index].sourceName,
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
                            height: 68.h,
                          ),
                        ],
                      ),
                    );
                  } else if (state is GarudaPaperNotFound) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 10.w,
                        ),
                        Center(
                          child: Image.asset(
                            'assets/km/tutup.png',
                            width: 190.w,
                            height: 122.w,
                          ),
                        ),
                        SizedBox(
                          height: 30.w,
                        ),
                        Center(
                          child: Text(
                            "Data yang ditampilkan tidak ditemukan",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 10.sp,
                                color: neutral50),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    );
                  } else if (state is GarudaPaperLoading) {
                    return SkeletonLoadingGarudaPaperLihatLainnya();
                  } else if (state is GarudaPaperNoInternet) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 125.h,
                        ),
                        WidgetNoInternetGaruda()
                      ],
                    );
                  }
                  return Container();
                },
              ),
              // ListView.separated(
              //     shrinkWrap: true,
              //     physics: NeverScrollableScrollPhysics(),
              //     itemBuilder: (context, index) {
              //       return NewListStyleGarudaPaperSearch(
              //         function: () {
              //           // Navigator.push(
              //           //     context,
              //           //     MaterialPageRoute(
              //           //         builder: (context) => DetailPaperGaruda(
              //           //               downloadRis:
              //           //                   res[index].downloadRis,
              //           //               downloadBibtex:
              //           //                   res[index].downloadBibtex,
              //           //               downloadOriginal:
              //           //                   res[index].downloadOriginal,
              //           //               issn: res[index]
              //           //                   .journalPaper
              //           //                   .journalIssn,
              //           //               abstract: res[index].abstract,
              //           //               journalName: res[index]
              //           //                   .journalPaper
              //           //                   .journalName
              //           //                   .toString(),
              //           //               publisher: res[index].publisher,
              //           //               sourceIssue:
              //           //                   res[index].sourceIssue,
              //           //               sourceName: res[index].sourceName,
              //           //               title: res[index].title,
              //           //             )));
              //         },
              //         heightSpace: 0,
              //         title: widget.res[index].title,
              //         subTitle: widget.res[index].sourceName,
              //         judulJurnal: widget.res[index].journalPaper.journalName,
              //         univ: widget.res[index].publisher,
              //       );
              //     },
              //     separatorBuilder: (BuildContext context, int index) {
              //       return SizedBox(
              //         height: 20.w,
              //       );
              //     },
              //     itemCount: widget.res.length),
            ],
          ),
        ),
      );
    });
  }
}
