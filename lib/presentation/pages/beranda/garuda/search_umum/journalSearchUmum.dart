import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/pages/beranda/garuda/bloc/garuda_journal/searching_journal/garuda_searching_journal_bloc.dart';
import 'package:app/presentation/pages/beranda/garuda/components/newListStyleCardGaruda.dart';
import 'package:app/presentation/pages/beranda/garuda/components/skeletonLoadingGarudaJournal.dart';
import 'package:app/presentation/pages/beranda/garuda/journal/detailjournal.dart';
import 'package:app/presentation/pages/beranda/garuda/widgetSlidingUpGaruda.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GarudaSearchJournalUmum extends StatefulWidget {
  final String keyword;
  const GarudaSearchJournalUmum({Key? key, required this.keyword})
      : super(key: key);

  @override
  State<GarudaSearchJournalUmum> createState() =>
      _GarudaSearchJournalUmumState();
}

class _GarudaSearchJournalUmumState extends State<GarudaSearchJournalUmum> {
  ScrollController scrollController = ScrollController();
  late GarudaSearchingJournalBloc garudaBloc;
  void onScroll(BuildContext context) {
    double maxScroll = scrollController.position.maxScrollExtent;
    double currentScroll = scrollController.position.pixels;

    if (currentScroll == maxScroll) {
      garudaBloc.add(GarudaSearchingEvent(keyword: widget.keyword));
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
      garudaBloc = BlocProvider.of<GarudaSearchingJournalBloc>(context);
      scrollController.addListener(() {
        onScroll(context);
      });
      return Scaffold(
        appBar: CustomAppBar(
          title: "Journal",
        ),
        body: SingleChildScrollView(
            controller: scrollController,
            child: BlocBuilder<GarudaSearchingJournalBloc,
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
                            // image
                          ],
                        ),
                      ),
                    ],
                  );
                } else if (state is GarudaSearchingJournalLoaded) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20.w,
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
                  return SkeletonLoadingGarudaJournalLihatLainnya();
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
            )),
      );
    });
  }
}
