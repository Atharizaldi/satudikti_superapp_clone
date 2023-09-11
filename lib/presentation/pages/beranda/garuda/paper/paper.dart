import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/search/searchBar.dart';
import 'package:app/presentation/pages/beranda/garuda/bloc/garuda_paper/garuda_paper_bloc.dart';
import 'package:app/presentation/pages/beranda/garuda/components/detailSearchBarGarudaPaper.dart';
import 'package:app/presentation/pages/beranda/garuda/components/newListStyleCardGaruda.dart';
import 'package:app/presentation/pages/beranda/garuda/components/skeletonLoadingGarudaPaper.dart';
import 'package:app/presentation/pages/beranda/garuda/paper/detailpaper.dart';
import 'package:app/presentation/pages/beranda/garuda/widgetSlidingUpGaruda.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/reusableWidgets/reusableWidgetsCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaperGaruda extends StatefulWidget {
  const PaperGaruda({Key? key}) : super(key: key);

  @override
  State<PaperGaruda> createState() => _PaperGarudaState();
}

class _PaperGarudaState extends State<PaperGaruda> {
  late GarudaPaperBloc garudaPaperBloc;
  ScrollController scrollController = ScrollController();

  void onScroll(BuildContext context) {
    double maxScroll = scrollController.position.maxScrollExtent;
    double currentScroll = scrollController.position.pixels;

    if (currentScroll == maxScroll) {
      garudaPaperBloc.add(GarudaPaperSearchEvent(keyword: "computer"));
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
          backgroundColor: whiteBgPage,
          appBar: CustomAppBar(title: 'Paper'),
          body: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 16.w),
                    child: _searchBar(context),
                  ),
                  SizedBox(
                    height: 20.w,
                  ),
                  BlocBuilder<GarudaPaperBloc, GarudaPaperState>(
                    builder: (context, state) {
                      if (state is GarudaPaperLoaded) {
                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 17.w),
                                child: RichText(
                                  text: TextSpan(children: <TextSpan>[
                                    TextSpan(
                                        text: 'Ada ',
                                        style: TextStyle(
                                            color: neutral50,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.sp)),
                                    TextSpan(
                                        text: state
                                            .garudaPaperObject.data!.total
                                            .toString(),
                                        style: TextStyle(
                                            color: neutral100,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.sp)),
                                    TextSpan(
                                        text: ' paper yang tersedia',
                                        style: TextStyle(
                                            color: neutral50,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.sp))
                                  ]),
                                ),
                              ),
                              SizedBox(
                                height: 20.w,
                              ),
                              ListView.builder(
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
                                                        journalEissn: state
                                                            .garudaPaper[index]
                                                            .journalPaper
                                                            .journalEissn,
                                                        journalDescription: state
                                                            .garudaPaper[index]
                                                            .journalPaper
                                                            .journalDescription,
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
                                                                    .garudaPaper[
                                                                        index]
                                                                    .journalPaper
                                                                    .journalIssn ==
                                                                ""
                                                            ? " - "
                                                            : state
                                                                .garudaPaper[
                                                                    index]
                                                                .journalPaper
                                                                .journalIssn,
                                                        abstract: state
                                                                    .garudaPaper[
                                                                        index]
                                                                    .abstract ==
                                                                ""
                                                            ? " - "
                                                            : state
                                                                .garudaPaper[
                                                                    index]
                                                                .abstract,
                                                        journalName: state
                                                                    .garudaPaper[
                                                                        index]
                                                                    .journalPaper
                                                                    .journalName
                                                                    .toString() ==
                                                                ""
                                                            ? " - "
                                                            : state
                                                                .garudaPaper[
                                                                    index]
                                                                .journalPaper
                                                                .journalName
                                                                .toString(),
                                                        publisher: state
                                                                    .garudaPaper[
                                                                        index]
                                                                    .publisher ==
                                                                ""
                                                            ? " - "
                                                            : state
                                                                .garudaPaper[
                                                                    index]
                                                                .publisher,
                                                        sourceIssue: state
                                                                    .garudaPaper[
                                                                        index]
                                                                    .sourceIssue ==
                                                                ""
                                                            ? " - "
                                                            : state
                                                                .garudaPaper[
                                                                    index]
                                                                .sourceIssue,
                                                        sourceName: state
                                                                    .garudaPaper[
                                                                        index]
                                                                    .sourceName ==
                                                                ""
                                                            ? " - "
                                                            : state
                                                                .garudaPaper[
                                                                    index]
                                                                .sourceName,
                                                        title: state
                                                            .garudaPaper[index]
                                                            .title,
                                                      )));
                                        },
                                        title: state.garudaPaper[index].title,
                                        subTitle: state.garudaPaper[index]
                                                    .sourceName ==
                                                ""
                                            ? " - "
                                            : state
                                                .garudaPaper[index].sourceName,
                                        judulJurnal: state.garudaPaper[index]
                                                    .journalPaper.journalName ==
                                                ""
                                            ? " - "
                                            : state.garudaPaper[index]
                                                .journalPaper.journalName,
                                        univ: state.garudaPaper[index]
                                                    .publisher ==
                                                ""
                                            ? " - "
                                            : state
                                                .garudaPaper[index].publisher,
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
                      } else if (state is GarudaPaperServerProblem) {
                        return serverProblem();
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
                        return SkeletonLoadingGarudaPaper();
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
                ],
              )));
    });
  }

  Widget _searchBar(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (builder) => DetailSearchBarGarudaPaper()));
      },
      child: Container(
        color: Colors.transparent,
        child: IgnorePointer(
          child: SearchBar(
            openKeyboard: false,
            hintText: 'Cari paper disini',
            searchType: TypeSearchBar.regular,
          ),
        ),
      ),
    );
  }
}
