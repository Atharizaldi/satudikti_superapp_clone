import 'package:app/data/source/remote/model/garuda/garuda.dart';
import 'package:app/data/source/remote/model/garuda/garudaPaper.dart';
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/search/searchBar.dart';
import 'package:app/presentation/component/sub_title_with_arrow_lainnya.dart';
import 'package:app/presentation/pages/beranda/garuda/bloc/garuda_journal/searching_journal/garuda_searching_journal_bloc.dart';
import 'package:app/presentation/pages/beranda/garuda/bloc/garuda_paper/garuda_paper_bloc.dart';
import 'package:app/presentation/pages/beranda/garuda/bloc/garuda_umum_search/garuda_umum_search_bloc.dart';
import 'package:app/presentation/pages/beranda/garuda/components/detailSearchBarGaruda.dart';
import 'package:app/presentation/pages/beranda/garuda/components/newListStyleCardGaruda.dart';
import 'package:app/presentation/pages/beranda/garuda/components/skeletonLoadingSearchUmumGaruda.dart';
import 'package:app/presentation/pages/beranda/garuda/journal/detailjournal.dart';
import 'package:app/presentation/pages/beranda/garuda/paper/detailpaper.dart';
import 'package:app/presentation/pages/beranda/garuda/search_umum/journalSearchUmum.dart';
import 'package:app/presentation/pages/beranda/garuda/search_umum/paperUmum.dart';
import 'package:app/presentation/pages/beranda/garuda/widgetSlidingUpGaruda.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/reusableWidgets/reusableWidgetsCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailSearchUmumGaruda extends StatefulWidget {
  const DetailSearchUmumGaruda({Key? key}) : super(key: key);

  @override
  State<DetailSearchUmumGaruda> createState() => _DetailSearchUmumGarudaState();
}

class _DetailSearchUmumGarudaState extends State<DetailSearchUmumGaruda> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
          backgroundColor: whiteBgPage,
          appBar: CustomAppBar(title: 'Jurnal / Artikel'),
          body: SingleChildScrollView(
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
                          SizedBox(height: 20.h),
                          resultCardJournal(state
                              .dataGaruda!.data!.resultGaruda.journalGaruda),
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
                          _dataTidakDitemukan(title: 'Paper'),
                          resultCardJournal(state
                              .dataGaruda!.data!.resultGaruda.journalGaruda)
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
                          _dataTidakDitemukan(title: 'Jurnal'),
                        ],
                      );
                    } else if (state.garudaPaperObject!.data!.listPaperGaruda
                                .length ==
                            0 &&
                        state.dataGaruda!.data!.resultGaruda.journalGaruda
                                .length ==
                            0) {
                      return Column(
                        children: [
                          _dataTidakDitemukan(title: 'Paper'),
                          _dataTidakDitemukan(title: 'Jurnal')
                        ],
                      );
                    }
                  } else if (state is GarudaUmumSearchFailed) {
                    return serverProblem();
                  }
                  return Container();
                },
              )
            ],
          )));
    });
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
                                    keyword: "computer")),
                              child: GarudaPaperUmum(keyword: "computer"),
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
                                  issn:
                                      res[index].journalPaper.journalIssn == ""
                                          ? " - "
                                          : res[index].journalPaper.journalIssn,
                                  abstract: res[index].abstract == ""
                                      ? " - "
                                      : res[index].abstract,
                                  journalName: res[index]
                                              .journalPaper
                                              .journalName
                                              .toString() ==
                                          ""
                                      ? " - "
                                      : res[index]
                                          .journalPaper
                                          .journalName
                                          .toString(),
                                  publisher: res[index].publisher == ""
                                      ? " - "
                                      : res[index].publisher,
                                  sourceIssue: res[index].sourceIssue == ""
                                      ? " - "
                                      : res[index].sourceIssue,
                                  sourceName: res[index].sourceName == ""
                                      ? " - "
                                      : res[index].sourceName,
                                  title: res[index].title,
                                )));
                  },
                  heightSpace: 0,
                  title: res[index].title,
                  subTitle: res[index].sourceName == ""
                      ? " - "
                      : res[index].sourceName,
                  judulJurnal: res[index].journalPaper.journalName == ""
                      ? " - "
                      : res[index].journalPaper.journalName,
                  univ:
                      res[index].publisher == "" ? " - " : res[index].publisher,
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
                              create: (context) =>
                                  di.locator<GarudaSearchingJournalBloc>()
                                    ..add(GarudaSearchingEvent(keyword: '')),
                              child: GarudaSearchJournalUmum(
                                keyword: '',
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
                                    published:
                                        res[index].publisherGaruda.name == ""
                                            ? " - "
                                            : res[index].publisherGaruda.name,
                                    litTags: res[index]
                                                .subjectGaruda
                                                .map((e) => e.areaName)
                                                .toList() ==
                                            []
                                        ? ['-']
                                        : res[index]
                                            .subjectGaruda
                                            .map((e) => e.areaName)
                                            .toList(),
                                    description:
                                        res[index].journalDescription == ""
                                            ? " - "
                                            : res[index].journalDescription,
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
                    subTitle: res[index].publisherGaruda.name == ""
                        ? " - "
                        : res[index].publisherGaruda.name,
                    ssn: res[index].journalIssn == ""
                        ? " - "
                        : res[index].journalIssn,
                    listTagName: res[index]
                                .subjectGaruda
                                .map((e) => e.areaName)
                                .toList() ==
                            []
                        ? ['-']
                        : res[index]
                            .subjectGaruda
                            .map((e) => e.areaName)
                            .toList());
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 20.w);
              },
              itemCount: res.length == 1 ? 1 : 2),
          SizedBox(
            height: 40.w,
          ),
        ],
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
                      create: (context) => di.locator<GarudaUmumSearchBloc>(),
                      child: DetailSearchingUmumGaruda(),
                    )));
      },
      child: Container(
        color: Colors.transparent,
        child: IgnorePointer(
          child: SearchBar(
            openKeyboard: false,
            hintText: 'Cari informasi Layanan',
            searchType: TypeSearchBar.regular,
          ),
        ),
      ),
    );
  }
}

Column _dataTidakDitemukan({required String title}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.only(left: 16.w, right: 17.w),
        child: Text(
          title,
          style: styleSubJudul,
        ),
      ),
      SizedBox(
        height: 20.w,
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
              fontWeight: FontWeight.w400, fontSize: 10.sp, color: neutral50),
        ),
      ),
      SizedBox(
        height: 20.w,
      ),
    ],
  );
}
