import 'package:app/data/source/remote/model/sinta/journals/JournalsList.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/inkEffect.dart';
import 'package:app/presentation/component/search/searchBar.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/reusableWidgets/reusableWidgetsCard.dart';
import 'package:app/presentation/pages/beranda/sinta/journals/detail/bloc/journals_detail_bloc.dart';
import 'package:app/presentation/pages/beranda/sinta/journals/detail/bloc/journals_scopus_publication_bloc.dart';
import 'package:app/presentation/pages/beranda/sinta/journals/detail/journalsDetailPage.dart';
import 'package:app/presentation/pages/beranda/sinta/journals/journals_list/bloc/journals_list_bloc.dart';
import 'package:app/presentation/pages/beranda/sinta/sinta_journals_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/shims/dart_ui_fake.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/injection.dart' as di;
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../../../searchPage/component/searchNotFound.dart';

class JournalsPage extends StatefulWidget {
  final String keyword;

  const JournalsPage({Key? key, required this.keyword}) : super(key: key);

  @override
  State<JournalsPage> createState() => _JournalsPageState();
}

class _JournalsPageState extends State<JournalsPage> {
  TextEditingController textEditingController = TextEditingController();
  ScrollController _scrollController = new ScrollController();
  late JournalsListBloc _journalsListBloc;
  Logger log = Logger();

  void onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;

    if (currentScroll == maxScroll) {
      _journalsListBloc.add(
        GetJournalsListEvent(
          keyword: _journalsListBloc.keywordSearch,
        ),
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _journalsListBloc = BlocProvider.of<JournalsListBloc>(context);
    _scrollController.addListener(onScroll);
    textEditingController.text = widget.keyword;
    return Scaffold(
      backgroundColor: whiteBgPage,
      appBar: CustomAppBar(title: 'Journals'),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30.h,
              ),
              _searchBar(),
              SizedBox(
                height: 30.h,
              ),
              BlocBuilder<JournalsListBloc, JournalsListState>(
                builder: (context, state) {
                  if (state is JournalsListLoaded) {
                    return _loadedWidget(state);
                  } else if (state is JournalsListLoading) {
                    return journalsListLoadingWithTotal();
                  } else if (state is JournalsListNoInternet) {
                    return noInternetWithContainer();
                  } else if (state is JournalsListError) {
                    return serverProblem();
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loadedWidget(JournalsListLoaded state) {
    String formattedTotalItem = state.totalItem.toString() == ""
        ? "0"
        : NumberFormat.currency(locale: 'id', decimalDigits: 0, name: '')
            .format(state.totalItem.toInt());
    if (formattedTotalItem == "0") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_textSpan(formattedTotalItem), searchNotFound("Journals")],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _textSpan(formattedTotalItem),
          SizedBox(
            height: 30.h,
          ),
          _buildListView(context, state, state.journalsList),
        ],
      );
    }
  }

  Widget _searchBar() {
    return Container(
      color: Colors.transparent,
      child: SearchBar(
        controller: textEditingController,
        openKeyboard: false,
        hintText: 'Cari Journals disini',
        searchType: TypeSearchBar.regular,
        isSubmitted: (value) async {
          _journalsListBloc.add(GetJournalsListEvent(keyword: value));
        },
      ),
    );
  }

  Widget _textSpan(String totalItem) {
    return Text.rich(
      TextSpan(
        text: 'Ada ',
        style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: neutralCaption),
        children: <InlineSpan>[
          TextSpan(
            text: totalItem,
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black),
          ),
          TextSpan(
            text: ' journals yang tersedia',
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: neutralCaption),
          )
        ],
      ),
    );
  }

  Widget _buildListView(
    BuildContext context,
    JournalsListLoaded state,
    List<Journals> list,
  ) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: (state.hasReachedMax) ? list.length : list.length + 1,
      itemBuilder: (BuildContext context, index) {
        if (index < list.length) {
          return _buildListCard(context, index.toString(), list[index], () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (builder) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => di.locator<JournalsDetailBloc>()
                        ..add(GetJournalsDetailEvent(id: list[index].id ?? "")),
                    ),
                    BlocProvider(
                      create: (context) => di
                          .locator<JournalsScopusPublicationBloc>()
                        ..add(GetJournalsScopusEvent(id: list[index].id ?? "")),
                    ),
                  ],
                  child: JournalsDetailPage(
                    id: list[index].id ?? "",
                  ),
                ),
              ),
            );
          });
        } else {
          return journalsCardSkeleton();
        }
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 20.h,
        );
      },
    );
  }

  Widget _buildListCard(
    BuildContext context,
    String value,
    Journals journals,
    VoidCallback onTap,
  ) {
    String judul = journals.title ?? "-";
    String univ = journals.institution ?? "-";
    String pissn = journals.pissn ?? "-";
    String eissn = journals.eissn ?? "-";
    String urlJournal = journals.urlJournal ?? "-";
    return InkEffect(
      onTap: onTap,
      boxDecoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectableText(
              (judul != "") ? judul : "-",
              onTap: onTap,
              enableInteractiveSelection: false,
              style: TextStyle(
                color: blue4,
                fontWeight: FontWeight.w700,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            SelectableText(
              (univ != "") ? univ : "-",
              onTap: onTap,
              enableInteractiveSelection: false,
              style: TextStyle(
                color: neutral50,
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Row(
              children: [
                SelectableText(
                  "P-ISSN : ${(pissn != "") ? pissn : "-"}",
                  onTap: onTap,
                  enableInteractiveSelection: false,
                  style: TextStyle(
                      color: teksAbuCerah4,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp),
                ),
                SizedBox(
                  width: 8.w,
                ),
                SelectableText(
                  "E-ISSN : ${(eissn != "") ? eissn : "-"}",
                  onTap: onTap,
                  enableInteractiveSelection: false,
                  style: TextStyle(
                    color: teksAbuCerah4,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              (urlJournal != "") ? urlJournal : "-",
              style: TextStyle(
                color: blue4,
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
