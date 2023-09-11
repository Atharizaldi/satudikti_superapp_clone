import 'package:app/data/source/remote/model/garuda/garuda.dart';
import 'package:app/data/source/remote/model/garuda/garudaPaper.dart';
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/search/searchBar.dart';
import 'package:app/presentation/component/sub_title_with_arrow_lainnya.dart';
import 'package:app/presentation/pages/beranda/garuda/bloc/garuda_journal/searching_journal/garuda_searching_journal_bloc.dart';
import 'package:app/presentation/pages/beranda/garuda/bloc/garuda_paper/garuda_paper_bloc.dart';
import 'package:app/presentation/pages/beranda/garuda/bloc/garuda_umum_search/garuda_umum_search_bloc.dart';
import 'package:app/presentation/pages/beranda/garuda/components/newListStyleCardGaruda.dart';
import 'package:app/presentation/pages/beranda/garuda/components/skeletonLoadingSearchUmumGaruda.dart';
import 'package:app/presentation/pages/beranda/garuda/journal/detailjournal.dart';
import 'package:app/presentation/pages/beranda/garuda/paper/detailpaper.dart';
import 'package:app/presentation/pages/beranda/garuda/search_umum/journalSearchUmum.dart';
import 'package:app/presentation/pages/beranda/garuda/search_umum/paperUmum.dart';
import 'package:app/presentation/pages/beranda/garuda/widgetSlidingUpGaruda.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailSearchingUmumGaruda extends StatefulWidget {
  const DetailSearchingUmumGaruda({Key? key}) : super(key: key);

  @override
  State<DetailSearchingUmumGaruda> createState() =>
      _DetailSearchingUmumGarudaState();
}

class _DetailSearchingUmumGarudaState extends State<DetailSearchingUmumGaruda> {
  TextEditingController textEditingController = TextEditingController();
  List<OptionFilter> listOptions = [
    OptionFilter(name: "Paper"),
    OptionFilter(name: "Jurnal"),
    OptionFilter(name: "Conference"),
    OptionFilter(name: "Subject")
  ];
  String? searchKey;
  @override
  Widget build(BuildContext context) {
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
                  searchKey = keyword;
                  _onSearch(context, keyword);
                });
              },
              searchType: TypeSearchBar.withClear,
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<GarudaUmumSearchBloc, GarudaUmumSearchState>(
              builder: (context, state) {
                if (state is GarudaUmumSearchLoading) {
                  return SkeletonLoadingSearchUmumGaruda();
                } else if (state is GarudaUmumSearchNoInternet) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 125.h,
                      ),
                      WidgetNoInternetGaruda(),
                    ],
                  );
                } else if (state is GarudaUmumSearchLoaded) {
                  if (state.garudaPaperObject!.data!.listPaperGaruda.length !=
                          0 &&
                      state.dataGaruda!.data!.resultGaruda.journalGaruda
                              .length !=
                          0) {
                    return Column(
                      children: [
                        resultCardPaper(
                            state.garudaPaperObject!.data!.listPaperGaruda),
                        resultCardJournal(
                            state.dataGaruda!.data!.resultGaruda.journalGaruda)
                      ],
                    );
                  } else if (state.garudaPaperObject!.data!.listPaperGaruda
                              .length ==
                          0 &&
                      state.dataGaruda!.data!.resultGaruda.journalGaruda
                              .length !=
                          0) {
                    return Column(
                      children: [
                        // _dataTidakDitemukan(title: 'Paper'),
                        SizedBox(),
                        resultCardJournal(
                            state.dataGaruda!.data!.resultGaruda.journalGaruda)
                      ],
                    );
                  } else if (state.garudaPaperObject!.data!.listPaperGaruda
                              .length !=
                          0 &&
                      state.dataGaruda!.data!.resultGaruda.journalGaruda
                              .length ==
                          0) {
                    return Column(
                      children: [
                        resultCardPaper(
                            state.garudaPaperObject!.data!.listPaperGaruda),
                        // _dataTidakDitemukan(title: 'Jurnal'),
                        SizedBox()
                      ],
                    );
                  } else if (state.garudaPaperObject!.data!.listPaperGaruda
                              .length ==
                          0 &&
                      state.dataGaruda!.data!.resultGaruda.journalGaruda
                              .length ==
                          0) {
                    return _dataTidakDitemukan();
                  }
                } else if (state is GarudaUmumSearchFailed) {
                  return _dataTidakDitemukan();
                }
                return Container();
              },
            )
          ],
        )));
  }

  Container resultCardPaper(List<ListPaperGaruda> res) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.w, right: 16.w),
            child: SubTitleWithArrowLainnya(
              subJudul: 'Paper',
              function: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => BlocProvider(
                              create: (context) => di.locator<GarudaPaperBloc>()
                                ..add(GarudaPaperSearchEvent(
                                    keyword: searchKey.toString())),
                              child: GarudaPaperUmum(
                                  keyword: searchKey.toString()),
                            )));
              },
            ),
          ),
          SizedBox(
            height: 20.w,
          ),
          ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return NewListStyleGarudaPaperSearch(
                  function: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailPaperGaruda(
                                  journalDescription: res[index]
                                      .journalPaper
                                      .journalDescription,
                                  journalEissn:
                                      res[index].journalPaper.journalEissn,
                                  downloadRis: res[index].downloadRis,
                                  downloadBibtex: res[index].downloadBibtex,
                                  downloadOriginal: res[index].downloadOriginal,
                                  issn: res[index].journalPaper.journalIssn,
                                  abstract: res[index].abstract,
                                  journalName: res[index]
                                      .journalPaper
                                      .journalName
                                      .toString(),
                                  publisher: res[index].publisher,
                                  sourceIssue: res[index].sourceIssue,
                                  sourceName: res[index].sourceName,
                                  title: res[index].title,
                                )));
                  },
                  heightSpace: 0,
                  title: res[index].title,
                  subTitle: res[index].sourceName,
                  judulJurnal: res[index].journalPaper.journalName,
                  univ: res[index].publisher,
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 20.w);
              },
              itemCount: res.length == 1 ? 1 : 2),
        ],
      ),
    );
  }

  Container resultCardJournal(List<JournalGaruda> res) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.w, right: 16.w),
            child: SubTitleWithArrowLainnya(
              subJudul: 'Jurnal',
              function: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => BlocProvider(
                              create: (context) => di
                                  .locator<GarudaSearchingJournalBloc>()
                                ..add(GarudaSearchingEvent(keyword: searchKey)),
                              child: GarudaSearchJournalUmum(
                                keyword: searchKey.toString(),
                              ),
                            )));
              },
            ),
          ),
          SizedBox(
            height: 20.w,
          ),
          ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return NewListStyleGarudaJurnalSearch(
                    heightSpace: 0,
                    function: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailJournalGaruda(
                                    title: res[index].journalName,
                                    published: res[index].publisherGaruda.name,
                                    litTags: res[index]
                                        .subjectGaruda
                                        .map((e) => e.areaName)
                                        .toList(),
                                    description: res[index].journalDescription,
                                    issn: res[index].journalIssn == ""
                                        ? " - "
                                        : res[index].journalIssn,
                                    essn: res[index].journalEissn == ""
                                        ? " - "
                                        : res[index].journalEissn,
                                  )));
                    },
                    image: "assets/garuda/iconjurnal.png",
                    title: res[index].journalName,
                    subTitle: res[index].publisherGaruda.name,
                    ssn: res[index].journalIssn == ""
                        ? " - "
                        : res[index].journalIssn,
                    listTagName: res[index]
                        .subjectGaruda
                        .map((e) => e.areaName)
                        .toList());
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 20.w);
              },
              itemCount: res.length == 1 ? 1 : 2),
        ],
      ),
    );
  }

  Column _dataTidakDitemukan() {
    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Padding(
    //       padding: EdgeInsets.only(left: 16.w, right: 17.w),
    //       child: Text(
    //         title,
    //         style: styleSubJudul,
    //       ),
    //     ),
    //     SizedBox(
    //       height: 20.w,
    //     ),
    //     Center(
    //       child: Image.asset(
    //         'assets/km/tutup.png',
    //         width: 190.w,
    //         height: 122.w,
    //       ),
    //     ),
    //     SizedBox(
    //       height: 30.w,
    //     ),
    //     Center(
    //       child: Text(
    //         "Data yang ditampilkan tidak ditemukan",
    //         textAlign: TextAlign.center,
    //         style: TextStyle(
    //             fontWeight: FontWeight.w400, fontSize: 10.sp, color: neutral50),
    //       ),
    //     ),
    //     SizedBox(
    //       height: 20.w,
    //     ),
    //   ],
    // );
    return Column(
      children: [
        Padding(padding: EdgeInsets.symmetric(vertical: 50.h)),
        Center(
            child: Column(
          children: [
            SizedBox(
              height: 50.h,
            ),
            Image.asset(
              'assets/data_not_found.png',
              width: 198.w,
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "Ups, Paper dan Jurnal Tidak Ditemukan",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              "Silahkan cek kembali ejaan kata atau\ncoba kata kunci lain.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
            )
          ],
        ))
      ],
    );
  }

  void _onSearch(BuildContext context, String keyword) async {
    context
        .read<GarudaUmumSearchBloc>()
        .add(GarudaUmumSearchMainEvent(keyword: keyword));
  }
}
