import 'package:app/data/source/remote/model/garuda/garuda.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/search/searchBarV2.dart';
import 'package:app/presentation/pages/beranda/garuda/bloc/garuda_journal/searching_journal/garuda_searching_journal_bloc.dart';
import 'package:app/presentation/pages/beranda/garuda/components/newListStyleCardGaruda.dart';
import 'package:app/presentation/pages/beranda/garuda/components/skeletonLoadingGarudaJournal.dart';
import 'package:app/presentation/pages/beranda/garuda/journal/detailjournal.dart';
import 'package:app/presentation/pages/beranda/garuda/widgetSlidingUpGaruda.dart';
import 'package:app/presentation/pages/beranda/searchPage/component/searchNotFound.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/injection.dart' as di;

class DetailSearchBarGarudaJournal extends StatefulWidget {
  const DetailSearchBarGarudaJournal({Key? key}) : super(key: key);

  @override
  State<DetailSearchBarGarudaJournal> createState() =>
      _DetailSearchBarGarudaJournalState();
}

String? searchKeyword;
String searchKeywordtemp = "";
int? filterTemp;

bool tappedGaruda = false;

class _DetailSearchBarGarudaJournalState
    extends State<DetailSearchBarGarudaJournal> {
  TextEditingController textEditingController = TextEditingController();

  bool checkFilter = false;

  ScrollController scrollController = ScrollController();
  late GarudaSearchingJournalBloc garudaBloc;
  void onScroll(BuildContext context) {
    double maxScroll = scrollController.position.maxScrollExtent;
    double currentScroll = scrollController.position.pixels;

    if (currentScroll == maxScroll) {
      // print("o $filterTemp");
      if (idFilter == 1) {
        garudaBloc.add(GarudaSearchingEvent(keyword: searchKeyword));
      } else {
        garudaBloc.add(GarudaSearchingBySubjectEvent(
            id: idFilter.toString(), keyword: searchKeyword));
      }
      // filterTemp = idFilter;
      // print("id Filter TEMP $filterTemp");
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(fontSize: 14.sp, color: neutral50);
    return BlocProvider(
      create: (context) => di.locator<GarudaSearchingJournalBloc>(),
      child: Builder(builder: (context) {
        garudaBloc = BlocProvider.of<GarudaSearchingJournalBloc>(context);
        scrollController.addListener(() {
          onScroll(context);
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
                      setState(() {
                        searchKeyword = "";
                        tappedGaruda = false;
                        idFilter = 1;
                        filterTemp = 1;
                      });
                    }),
              ),
              title: Padding(
                padding: EdgeInsets.only(left: 10.w, right: 20.w),
                child: SearchBarGarudaJournal(
                  controller: textEditingController,
                  openKeyboard: true,
                  hintText: 'Pencarian Layanan',
                  isSubmitted: (String keyword) {
                    tappedGaruda = true;
                    searchKeyword = keyword;
                    _onSearch(context, keyword);
                  },
                  searchType: TypeSearchBarGarudaJournal.withFilter,
                  // customHeight: 87.5.w,
                ),
              ),
            ),
            body: BlocBuilder<GarudaSearchingJournalBloc,
                GarudaSearchingJournalState>(
              builder: (context, state) {
                if (state is GarudaSearchingJournalNotFound) {
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
                      Flexible(child: searchNotFound('Jurnal'))
                    ],
                  );
                } else if (state is GarudaSearchingJournalLoaded) {
                  final data = state.dataGaruda.data!.resultGaruda;
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
                              ? state.journalGaruda.length
                              : state.journalGaruda.length + 1,
                          itemBuilder: (context, index) {
                            if (index < state.journalGaruda.length) {
                              return Padding(
                                  padding: EdgeInsets.only(bottom: 28.h),
                                  child: NewListStyleGarudaJurnalSearch(
                                      heightSpace: 0,
                                      function: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailJournalGaruda(
                                                      title: state
                                                          .journalGaruda[index]
                                                          .journalName,
                                                      published: state
                                                          .journalGaruda[index]
                                                          .publisherGaruda
                                                          .name,
                                                      litTags: state
                                                          .journalGaruda[index]
                                                          .subjectGaruda
                                                          .map(
                                                              (e) => e.areaName)
                                                          .toList(),
                                                      description: state
                                                          .journalGaruda[index]
                                                          .journalDescription,
                                                      issn: state
                                                                  .journalGaruda[
                                                                      index]
                                                                  .journalIssn ==
                                                              ""
                                                          ? " - "
                                                          : state
                                                              .journalGaruda[
                                                                  index]
                                                              .journalIssn,
                                                      essn: state
                                                                  .journalGaruda[
                                                                      index]
                                                                  .journalEissn ==
                                                              ""
                                                          ? " - "
                                                          : state
                                                              .journalGaruda[
                                                                  index]
                                                              .journalEissn,
                                                    )));
                                      },
                                      image: "assets/garuda/iconjurnal.png",
                                      title: state
                                          .journalGaruda[index].journalName,
                                      subTitle: state.journalGaruda[index]
                                          .publisherGaruda.name,
                                      ssn: state
                                          .journalGaruda[index].journalIssn,
                                      listTagName: state
                                          .journalGaruda[index].subjectGaruda
                                          .map((e) => e.areaName)
                                          .toList()));
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
                } else if (state is GarudaSearchingJournalLoading) {
                  return SkeletonLoadingGarudaJournal();
                } else if (state is GarudaSearchingJournalNoInternet) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 150.h,
                      ),
                      WidgetNoInternetGaruda()
                    ],
                  );
                }
                return Container();
              },
            ));
      }),
    );
  }

  Widget _jumlahPencarian(TextStyle textStyle, ResultGaruda res) {
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
                  text: "${res.total} ",
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
      if (idFilter == 1) {
        context
            .read<GarudaSearchingJournalBloc>()
            .add(GarudaSearchingEvent(keyword: keyword));
      } else {
        context.read<GarudaSearchingJournalBloc>().add(
            GarudaSearchingBySubjectEvent(
                id: idFilter.toString(), keyword: keyword));
      }
    }
  }
}
