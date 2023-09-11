import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/search/searchBar.dart';
import 'package:app/presentation/pages/beranda/beritaDanPengumumanDetail/component/bannerInformasi.dart';
import 'package:app/presentation/pages/beranda/garuda/bloc/garuda_journal/garuda_bloc.dart';
import 'package:app/presentation/pages/beranda/garuda/bloc/garuda_paper/garuda_paper_bloc.dart';
import 'package:app/presentation/pages/beranda/garuda/bloc/garuda_umum_search/garuda_umum_search_bloc.dart';
import 'package:app/presentation/pages/beranda/garuda/bloc/statistik_garuda/statistik_garuda_bloc.dart';
import 'package:app/presentation/pages/beranda/garuda/components/newListStyleCardGaruda.dart';
import 'package:app/presentation/pages/beranda/garuda/components/skeletonLoadingGaruda.dart';
import 'package:app/presentation/pages/beranda/garuda/journal/detailjournal.dart';
import 'package:app/presentation/pages/beranda/garuda/journal/journal.dart';
import 'package:app/presentation/pages/beranda/garuda/paper/paper.dart';
import 'package:app/presentation/pages/beranda/garuda/search_umum/detail_search_umum_garuda.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/injection.dart' as di;
import 'package:intl/intl.dart';

Widget _searchBar(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (builder) => BlocProvider(
                    create: (context) => di.locator<GarudaUmumSearchBloc>()
                      ..add(GarudaUmumSearchMainEvent(keyword: "computer")),
                    child: DetailSearchUmumGaruda(),
                  )));
    },
    child: Container(
      color: Colors.transparent,
      child: IgnorePointer(
        child: SearchBar(
          openKeyboard: false,
          hintText: 'Pencarian Jurnal/Artikel',
          searchType: TypeSearchBar.regular,
        ),
      ),
    ),
  );
}

Widget listDraggableGarudaHome(BuildContext context) {
  return Column(
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
        height: 48.h,
      ),
      Padding(
        padding: EdgeInsets.only(left: 17.5.w, right: 16.5.w),
        child: Text(
          "Pilih Layanan",
          style: TextStyle(
              fontSize: 20.sp, fontWeight: FontWeight.bold, color: blue3),
        ),
      ),
      SizedBox(
        height: 20.h,
      ),
      NewListStyleGaruda(
          heightSpace: 0,
          function: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BlocProvider(
                          create: (context) => di.locator<GarudaPaperBloc>()
                            ..add(GarudaPaperSearchEvent(keyword: "computer")),
                          child: PaperGaruda(),
                        )));
          },
          image: "assets/garuda/ilustrasi_paper.png",
          title: "Paper / Artikel",
          subTitle:
              "Kumpulan ringkasan hasil penelitian yang didukung dengan data serta argumen yang valid."),
      SizedBox(
        height: 20.h,
      ),
      NewListStyleGaruda(
          heightSpace: 0,
          function: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BlocProvider(
                          create: (context) => di.locator<GarudaBloc>()
                            ..add(SearchGarudaJournalEvent()),
                          child: JournalGaruda(),
                        )));
          },
          image: "assets/garuda/ilustrasi_jurnal.png",
          title: "Jurnal / Conferences  ",
          subTitle:
              "Kumpulan karya ilmiah yang diikutsertakan dalam suatu konferensi dapat kamu akses disini."),
      SizedBox(
        height: 48.h,
      ),
      BlocBuilder<GarudaBloc, GarudaState>(
        builder: (context, state) {
          if (state is GarudaLoadingState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 17.w),
                  child: Text(
                    "Jurnal",
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: blue3),
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                SkeletonLoadingGaruda(),
                bannerInformasiGaruda(context),
                SizedBox(
                  height: 39.h,
                ),
              ],
            );
          } else if (state is GarudaInitialState) {
            return SizedBox();
          } else if (state is GarudaTidakAdaDataState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 17.5.w, right: 16.5.w),
                  child: Text(
                    "Jurnal",
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: blue3),
                  ),
                ),
                SizedBox(
                  height: 21.h,
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
                  height: 8.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 17.5.w, right: 16.5.w),
                  child: Text(
                    "Statistik",
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: blue3),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                BlocBuilder<StatistikGarudaBloc, StatistikGarudaState>(
                  builder: (context, state) {
                    if (state is StatistikGarudaLoading) {
                      return Padding(
                        padding: EdgeInsets.only(left: 17.5.w, right: 16.5.w),
                        child: Container(
                          margin: EdgeInsets.zero,
                          padding: EdgeInsets.zero,
                          width: double.infinity,
                          child: GridView.count(
                            padding: EdgeInsets.zero,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              CardStatistikLoading(),
                              CardStatistikLoading(),
                              CardStatistikLoading(),
                            ],
                            crossAxisCount: 3,
                          ),
                        ),
                      );
                    } else if (state is StatistikGarudaLoaded) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 114.w,
                            width: 104.w,
                            child: CardStatistik(
                              image: "assets/garuda/articles_statistik.png",
                              value: state.modelStatistikGaruda.data!
                                          .listData![2].value
                                          .toString() ==
                                      ""
                                  ? " - "
                                  : NumberFormat.currency(
                                          locale: 'id',
                                          decimalDigits: 0,
                                          name: '')
                                      .format(state.modelStatistikGaruda.data!
                                          .listData![2].value),
                              title: state.modelStatistikGaruda.data!
                                          .listData![2].attribute
                                          .toString() ==
                                      "article"
                                  ? "Articles"
                                  : "Articles",
                            ),
                          ),
                          Container(
                            height: 114.w,
                            width: 104.w,
                            child: CardStatistik(
                              image: "assets/garuda/journals_statistik.png",
                              value: state.modelStatistikGaruda.data!
                                          .listData![0].value
                                          .toString() ==
                                      ""
                                  ? " - "
                                  : NumberFormat.currency(
                                          locale: 'id',
                                          decimalDigits: 0,
                                          name: '')
                                      .format(state.modelStatistikGaruda.data!
                                          .listData![0].value),
                              title: state.modelStatistikGaruda.data!
                                          .listData![0].attribute
                                          .toString() ==
                                      "journal"
                                  ? "Journals"
                                  : "Journals",
                            ),
                          ),
                          Container(
                            height: 114.w,
                            width: 104.w,
                            child: CardStatistik(
                                image: "assets/garuda/subject_statistik.png",
                                value: state.modelStatistikGaruda.data!
                                            .listData![1].value
                                            .toString() ==
                                        ""
                                    ? " - "
                                    : NumberFormat.currency(
                                            locale: 'id',
                                            decimalDigits: 0,
                                            name: '')
                                        .format(state.modelStatistikGaruda.data!
                                            .listData![1].value),
                                title: state.modelStatistikGaruda.data!
                                            .listData![1].attribute
                                            .toString() ==
                                        "subject"
                                    ? "Subjects"
                                    : "Subjects"),
                          ),
                        ],
                      );
                    } else if (state is StatistikGarudaFailed) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 114.w,
                            width: 104.w,
                            child: CardStatistik(
                              image: "assets/garuda/articles_statistik.png",
                              value: "-",
                              title: "Articles",
                            ),
                          ),
                          Container(
                            height: 114.w,
                            width: 104.w,
                            child: CardStatistik(
                              image: "assets/garuda/journals_statistik.png",
                              value: "-",
                              title: "Article",
                            ),
                          ),
                          Container(
                            height: 114.w,
                            width: 104.w,
                            child: CardStatistik(
                                image: "assets/garuda/subject_statistik.png",
                                value: "-",
                                title: "Subjects"),
                          ),
                        ],
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
                SizedBox(
                  height: 12.h,
                ),
                bannerInformasiGaruda(context),
                SizedBox(
                  height: 39.h,
                ),
              ],
            );
          } else if (state is GarudaLoadedState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 17.5.w, right: 16.5.w),
                  child: Text(
                    "Jurnal",
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: blue3),
                  ),
                ),
                SizedBox(
                  height: 21.h,
                ),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.journalGaruda.length > 2
                      ? 3
                      : state.journalGaruda.length > 1
                          ? 2
                          : state.journalGaruda.length > 0
                              ? 1
                              : 0,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: NewListStyleGarudaJurnal(
                          heightSpace: 0,
                          function: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailJournalGaruda(
                                          title: state
                                                      .dataGaruda
                                                      .data!
                                                      .resultGaruda
                                                      .journalGaruda[index]
                                                      .journalName ==
                                                  ""
                                              ? " - "
                                              : state
                                                  .dataGaruda
                                                  .data!
                                                  .resultGaruda
                                                  .journalGaruda[index]
                                                  .journalName,
                                          description: state
                                                      .dataGaruda
                                                      .data!
                                                      .resultGaruda
                                                      .journalGaruda[index]
                                                      .journalDescription ==
                                                  ""
                                              ? " - "
                                              : state
                                                  .dataGaruda
                                                  .data!
                                                  .resultGaruda
                                                  .journalGaruda[index]
                                                  .journalDescription,
                                          essn: state
                                                      .dataGaruda
                                                      .data!
                                                      .resultGaruda
                                                      .journalGaruda[index]
                                                      .journalEissn ==
                                                  ""
                                              ? " - "
                                              : state
                                                  .dataGaruda
                                                  .data!
                                                  .resultGaruda
                                                  .journalGaruda[index]
                                                  .journalEissn,
                                          issn: state
                                                      .dataGaruda
                                                      .data!
                                                      .resultGaruda
                                                      .journalGaruda[index]
                                                      .journalIssn ==
                                                  ""
                                              ? " - "
                                              : state
                                                  .dataGaruda
                                                  .data!
                                                  .resultGaruda
                                                  .journalGaruda[index]
                                                  .journalIssn,
                                          published: state
                                                      .dataGaruda
                                                      .data!
                                                      .resultGaruda
                                                      .journalGaruda[index]
                                                      .publisherGaruda
                                                      .name ==
                                                  ""
                                              ? " - "
                                              : state
                                                  .dataGaruda
                                                  .data!
                                                  .resultGaruda
                                                  .journalGaruda[index]
                                                  .publisherGaruda
                                                  .name,
                                          litTags: state
                                                      .dataGaruda
                                                      .data!
                                                      .resultGaruda
                                                      .journalGaruda[index]
                                                      .subjectGaruda
                                                      .map((e) => e.areaName)
                                                      .toList() ==
                                                  []
                                              ? ['-']
                                              : state
                                                  .dataGaruda
                                                  .data!
                                                  .resultGaruda
                                                  .journalGaruda[index]
                                                  .subjectGaruda
                                                  .map((e) => e.areaName)
                                                  .toList(),
                                        )));
                          },
                          image: "assets/garuda/iconjurnal.png",
                          title: state.dataGaruda.data!.resultGaruda
                                      .journalGaruda[index].journalName ==
                                  ""
                              ? "-"
                              : state.dataGaruda.data!.resultGaruda
                                  .journalGaruda[index].journalName,
                          subTitle: state
                                      .dataGaruda
                                      .data!
                                      .resultGaruda
                                      .journalGaruda[index]
                                      .publisherGaruda
                                      .name ==
                                  ""
                              ? " - "
                              : state.dataGaruda.data!.resultGaruda
                                  .journalGaruda[index].publisherGaruda.name),
                    );
                  },
                ),
                SizedBox(
                  height: 8.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 17.5.w, right: 16.5.w),
                  child: Text(
                    "Statistik",
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: blue3),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                BlocBuilder<StatistikGarudaBloc, StatistikGarudaState>(
                  builder: (context, state) {
                    if (state is StatistikGarudaLoading) {
                      return Padding(
                        padding: EdgeInsets.only(left: 17.5.w, right: 16.5.w),
                        child: Container(
                          margin: EdgeInsets.zero,
                          padding: EdgeInsets.zero,
                          width: double.infinity,
                          child: GridView.count(
                            padding: EdgeInsets.zero,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              CardStatistikLoading(),
                              CardStatistikLoading(),
                              CardStatistikLoading(),
                            ],
                            crossAxisCount: 3,
                          ),
                        ),
                      );
                    } else if (state is StatistikGarudaLoaded) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 114.w,
                            width: 104.w,
                            child: CardStatistik(
                              image: "assets/garuda/articles_statistik.png",
                              value: state.modelStatistikGaruda.data!
                                          .listData![2].value
                                          .toString() ==
                                      ""
                                  ? " - "
                                  : NumberFormat.currency(
                                          locale: 'id',
                                          decimalDigits: 0,
                                          name: '')
                                      .format(state.modelStatistikGaruda.data!
                                          .listData![2].value),
                              title: state.modelStatistikGaruda.data!
                                          .listData![2].attribute
                                          .toString() ==
                                      "article"
                                  ? "Articles"
                                  : "Articles",
                            ),
                          ),
                          Container(
                            height: 114.w,
                            width: 104.w,
                            child: CardStatistik(
                              image: "assets/garuda/journals_statistik.png",
                              value: state.modelStatistikGaruda.data!
                                          .listData![0].value
                                          .toString() ==
                                      ""
                                  ? " - "
                                  : NumberFormat.currency(
                                          locale: 'id',
                                          decimalDigits: 0,
                                          name: '')
                                      .format(state.modelStatistikGaruda.data!
                                          .listData![0].value),
                              title: state.modelStatistikGaruda.data!
                                          .listData![0].attribute
                                          .toString() ==
                                      "journal"
                                  ? "Journals"
                                  : "Journals",
                            ),
                          ),
                          Container(
                            height: 114.w,
                            width: 104.w,
                            child: CardStatistik(
                                image: "assets/garuda/subject_statistik.png",
                                value: state.modelStatistikGaruda.data!
                                            .listData![1].value
                                            .toString() ==
                                        ""
                                    ? " - "
                                    : NumberFormat.currency(
                                            locale: 'id',
                                            decimalDigits: 0,
                                            name: '')
                                        .format(state.modelStatistikGaruda.data!
                                            .listData![1].value),
                                title: state.modelStatistikGaruda.data!
                                            .listData![1].attribute
                                            .toString() ==
                                        "subject"
                                    ? "Subjects"
                                    : "Subjects"),
                          ),
                        ],
                      );
                    } else if (state is StatistikGarudaFailed) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 114.w,
                            width: 104.w,
                            child: CardStatistik(
                              image: "assets/garuda/articles_statistik.png",
                              value: "-",
                              title: "Articles",
                            ),
                          ),
                          Container(
                            height: 114.w,
                            width: 104.w,
                            child: CardStatistik(
                              image: "assets/garuda/journals_statistik.png",
                              value: "-",
                              title: "Article",
                            ),
                          ),
                          Container(
                            height: 114.w,
                            width: 104.w,
                            child: CardStatistik(
                                image: "assets/garuda/subject_statistik.png",
                                value: "-",
                                title: "Subjects"),
                          ),
                        ],
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
                SizedBox(
                  height: 12.h,
                ),
                bannerInformasiGaruda(context),
                SizedBox(
                  height: 39.h,
                ),
              ],
            );
          } else if (state is GarudaNoInternetState) {
            return Column(
              children: [
                WidgetNoInternetGaruda(),
                bannerInformasiGaruda(context),
              ],
            );
          } else if (state is GarudaServerBermasalahState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 17.5.w, right: 16.5.w),
                  child: Text(
                    "Jurnal",
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: blue3),
                  ),
                ),
                SizedBox(
                  height: 21.h,
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
                Padding(
                  padding: EdgeInsets.only(left: 17.5.w, right: 16.5.w),
                  child: Text(
                    "Statistik",
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: blue3),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                BlocBuilder<StatistikGarudaBloc, StatistikGarudaState>(
                  builder: (context, state) {
                    if (state is StatistikGarudaLoading) {
                      return Padding(
                        padding: EdgeInsets.only(left: 17.5.w, right: 16.5.w),
                        child: Container(
                          margin: EdgeInsets.zero,
                          padding: EdgeInsets.zero,
                          width: double.infinity,
                          child: GridView.count(
                            padding: EdgeInsets.zero,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              CardStatistikLoading(),
                              CardStatistikLoading(),
                              CardStatistikLoading(),
                            ],
                            crossAxisCount: 3,
                          ),
                        ),
                      );
                    } else if (state is StatistikGarudaLoaded) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 114.w,
                            width: 104.w,
                            child: CardStatistik(
                              image: "assets/garuda/articles_statistik.png",
                              value: state.modelStatistikGaruda.data!
                                          .listData![2].value
                                          .toString() ==
                                      ""
                                  ? " - "
                                  : NumberFormat.currency(
                                          locale: 'id',
                                          decimalDigits: 0,
                                          name: '')
                                      .format(state.modelStatistikGaruda.data!
                                          .listData![2].value),
                              title: state.modelStatistikGaruda.data!
                                          .listData![2].attribute
                                          .toString() ==
                                      "article"
                                  ? "Articles"
                                  : "Articles",
                            ),
                          ),
                          Container(
                            height: 114.w,
                            width: 104.w,
                            child: CardStatistik(
                              image: "assets/garuda/journals_statistik.png",
                              value: state.modelStatistikGaruda.data!
                                          .listData![0].value
                                          .toString() ==
                                      ""
                                  ? " - "
                                  : NumberFormat.currency(
                                          locale: 'id',
                                          decimalDigits: 0,
                                          name: '')
                                      .format(state.modelStatistikGaruda.data!
                                          .listData![0].value),
                              title: state.modelStatistikGaruda.data!
                                          .listData![0].attribute
                                          .toString() ==
                                      "journal"
                                  ? "Journals"
                                  : "Journals",
                            ),
                          ),
                          Container(
                            height: 114.w,
                            width: 104.w,
                            child: CardStatistik(
                                image: "assets/garuda/subject_statistik.png",
                                value: state.modelStatistikGaruda.data!
                                            .listData![1].value
                                            .toString() ==
                                        ""
                                    ? " - "
                                    : NumberFormat.currency(
                                            locale: 'id',
                                            decimalDigits: 0,
                                            name: '')
                                        .format(state.modelStatistikGaruda.data!
                                            .listData![1].value),
                                title: state.modelStatistikGaruda.data!
                                            .listData![1].attribute
                                            .toString() ==
                                        "subject"
                                    ? "Subjects"
                                    : "Subjects"),
                          ),
                        ],
                      );
                    } else if (state is StatistikGarudaFailed) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 114.w,
                            width: 104.w,
                            child: CardStatistik(
                              image: "assets/garuda/articles_statistik.png",
                              value: "-",
                              title: "Articles",
                            ),
                          ),
                          Container(
                            height: 114.w,
                            width: 104.w,
                            child: CardStatistik(
                              image: "assets/garuda/journals_statistik.png",
                              value: "-",
                              title: "Article",
                            ),
                          ),
                          Container(
                            height: 114.w,
                            width: 104.w,
                            child: CardStatistik(
                                image: "assets/garuda/subject_statistik.png",
                                value: "-",
                                title: "Subjects"),
                          ),
                        ],
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
                SizedBox(
                  height: 12.h,
                ),
                bannerInformasiGaruda(context),
                SizedBox(
                  height: 39.h,
                ),
              ],
            );
          }
          return Container();
        },
      ),
    ],
  );
}

class WidgetNoInternetGaruda extends StatelessWidget {
  const WidgetNoInternetGaruda({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/ilus_connectionLost.png',
            width: 248.w,
            height: 191.w,
          ),
          SizedBox(height: 20.h),
          Text.rich(
            TextSpan(
              text: 'Koneksi Internet Bermasalah',
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
              children: <InlineSpan>[
                TextSpan(
                  text: '\nSilakan periksa koneksi anda',
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: neutralCaption),
                )
              ],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 40.h,
          ),
        ],
      ),
    );
  }
}

class CardStatistik extends StatelessWidget {
  final dynamic image;
  final String value, title;
  const CardStatistik({
    Key? key,
    required this.image,
    required this.value,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: white,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 188, 186, 186).withOpacity(0.15),
            spreadRadius: 0.2,
            blurRadius: 0.1,
            offset: Offset(0, 0.1), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 12.w,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.w),
            child: Container(
              height: 21.w,
              width: 24.w,
              child: Image.asset(this.image),
            ),
          ),
          SizedBox(
            height: 13.5.w,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.w),
            child: Text(
              this.value,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 16.w, fontWeight: FontWeight.bold, color: blue3),
            ),
          ),
          SizedBox(
            height: 8.w,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.w),
            child: Text(this.title,
                style: TextStyle(
                    fontSize: 12.w,
                    fontWeight: FontWeight.w400,
                    color: neutral30)),
          )
        ],
      ),
    );
  }
}
