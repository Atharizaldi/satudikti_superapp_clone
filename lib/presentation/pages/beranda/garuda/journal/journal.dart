import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/search/searchBar.dart';
import 'package:app/presentation/pages/beranda/garuda/bloc/garuda_journal/garuda_bloc.dart';
import 'package:app/presentation/pages/beranda/garuda/bloc/garuda_journal/searching_journal/garuda_searching_journal_bloc.dart';
import 'package:app/presentation/pages/beranda/garuda/components/detailSearchBarGarudaJournal.dart';
import 'package:app/presentation/pages/beranda/garuda/components/newListStyleCardGaruda.dart';
import 'package:app/presentation/pages/beranda/garuda/components/skeletonLoadingGarudaJournal.dart';
import 'package:app/presentation/pages/beranda/garuda/journal/detailjournal.dart';
import 'package:app/presentation/pages/beranda/garuda/widgetSlidingUpGaruda.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/reusableWidgets/reusableWidgetsCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JournalGaruda extends StatefulWidget {
  const JournalGaruda({Key? key}) : super(key: key);

  @override
  State<JournalGaruda> createState() => _JournalGarudaState();
}

class _JournalGarudaState extends State<JournalGaruda> {
  ScrollController scrollController = ScrollController();
  late GarudaBloc garudaBloc;
  void onScroll(BuildContext context) {
    double maxScroll = scrollController.position.maxScrollExtent;
    double currentScroll = scrollController.position.pixels;

    if (currentScroll == maxScroll) {
      garudaBloc.add(SearchGarudaJournalEvent());
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    garudaBloc = BlocProvider.of<GarudaBloc>(context);
    scrollController.addListener(() {
      onScroll(context);
    });
    return Container(
      child: Scaffold(
        backgroundColor: whiteBgPage,
        appBar: CustomAppBar(title: 'Jurnal'),
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
              BlocBuilder<GarudaBloc, GarudaState>(
                builder: (context, state) {
                  if (state is GarudaInitialState) {
                    return SkeletonLoadingGarudaJournal();
                  } else if (state is GarudaServerBermasalahState) {
                    return serverProblem();
                  } else if (state is GarudaLoadingState) {
                    return SkeletonLoadingGarudaJournal();
                  } else if (state is GarudaLoadedState) {
                    return Column(
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
                                      .dataGaruda.data!.resultGaruda.total
                                      .toString(),
                                  style: TextStyle(
                                      color: neutral100,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp)),
                              TextSpan(
                                  text: ' jurnal yang tersedia',
                                  style: TextStyle(
                                      color: neutral50,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp))
                            ]),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
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
                                padding: EdgeInsets.only(bottom: 20.h),
                                child: NewListStyleGarudaJurnalSearch(
                                    heightSpace: 0,
                                    function: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailJournalGaruda(
                                                    title: state
                                                                .journalGaruda[
                                                                    index]
                                                                .journalName ==
                                                            ""
                                                        ? " - "
                                                        : state
                                                            .journalGaruda[
                                                                index]
                                                            .journalName,
                                                    published: state
                                                                .journalGaruda[
                                                                    index]
                                                                .publisherGaruda
                                                                .name ==
                                                            ""
                                                        ? " - "
                                                        : state
                                                            .journalGaruda[
                                                                index]
                                                            .publisherGaruda
                                                            .name,
                                                    litTags: state
                                                                .journalGaruda[
                                                                    index]
                                                                .subjectGaruda
                                                                .map((e) =>
                                                                    e.areaName)
                                                                .toList() ==
                                                            []
                                                        ? ['-']
                                                        : state
                                                            .journalGaruda[
                                                                index]
                                                            .subjectGaruda
                                                            .map((e) =>
                                                                e.areaName)
                                                            .toList(),
                                                    description: state
                                                                .journalGaruda[
                                                                    index]
                                                                .journalDescription ==
                                                            ""
                                                        ? " - "
                                                        : state
                                                            .journalGaruda[
                                                                index]
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
                                    title: state.journalGaruda[index]
                                                .journalName ==
                                            ""
                                        ? " - "
                                        : state
                                            .journalGaruda[index].journalName,
                                    subTitle: state.journalGaruda[index]
                                                .publisherGaruda.name ==
                                            ""
                                        ? " - "
                                        : state.journalGaruda[index]
                                            .publisherGaruda.name,
                                    ssn: state.journalGaruda[index]
                                                .journalIssn ==
                                            ""
                                        ? " - "
                                        : state
                                            .journalGaruda[index].journalIssn,
                                    listTagName: state.journalGaruda[index]
                                                .subjectGaruda
                                                .map((e) => e.areaName)
                                                .toList() ==
                                            []
                                        ? ['-']
                                        : state
                                            .journalGaruda[index].subjectGaruda
                                            .map((e) => e.areaName)
                                            .toList()),
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
                      ],
                    );
                  } else if (state is GarudaNoInternetState) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 125.h,
                        ),
                        WidgetNoInternetGaruda()
                      ],
                    );
                  } else if (state is GarudaTidakAdaDataState) {
                    return Center(
                      child: Column(
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
                      ),
                    );
                  }
                  return Container();
                },
              ),
              SizedBox(
                height: 48.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchBar(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (builder) => BlocProvider(
                      create: (context) =>
                          di.locator<GarudaSearchingJournalBloc>(),
                      child: DetailSearchBarGarudaJournal(),
                    )));
      },
      child: Container(
        color: Colors.transparent,
        child: IgnorePointer(
          child: SearchBar(
            openKeyboard: false,
            hintText: 'Cari jurnal disini',
            searchType: TypeSearchBar.regular,
          ),
        ),
      ),
    );
  }
}
