import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/search/searchBar.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/reusableWidgets/reusableWidgetsCard.dart';
import 'package:app/presentation/pages/beranda/searchPage/component/searchNotFound.dart';
import 'package:app/presentation/pages/beranda/sinta/component/searchItem.dart';
import 'package:app/presentation/pages/beranda/sinta/search/bloc/sinta_search_bloc.dart';
import 'package:app/presentation/pages/beranda/sinta/sinta_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SintaSearchPage extends StatefulWidget {
  const SintaSearchPage({Key? key}) : super(key: key);

  @override
  State<SintaSearchPage> createState() => _SintaSearchPageState();
}

class _SintaSearchPageState extends State<SintaSearchPage> {
  TextEditingController textEditingController = TextEditingController();

  late SintaSearchBloc _sintaSearchBloc;

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _sintaSearchBloc = BlocProvider.of<SintaSearchBloc>(context);
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
                size: 24.w,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        title: Padding(
          padding: EdgeInsets.only(left: 10.w, right: 20.w),
          child: SearchBar(
            controller: textEditingController,
            openKeyboard: false,
            hintText: 'Pencarian Sinta',
            searchType: TypeSearchBar.regular,
            isSubmitted: (value) {
              _sintaSearchBloc.add(
                GetAuthorsAffiliationsJournalsEvent(
                  keyword: value,
                ),
              );
            },
          ),
        ),
      ),
      body: BlocBuilder<SintaSearchBloc, SintaSearchState>(
        builder: (context, state) {
          if (state is SintaSearchInitial) {
            return Container();
          } else if (state is SintaSearchNoInternet) {
            return Center(child: noInternetWithContainer());
          } else if (state is SintaSearchError) {
            return Center(child: serverProblem());
          } else if (state is SintaSearchLoading) {
            return sintaSearchSkeleton();
          } else if (state is SintaSearchLoaded) {
            //cek satu satu terus return di column, isinya resultCard
            bool authorsFound = state.totalItemAuthors > 0;
            bool affiliationsFound = state.totalItemAffiliations > 0;
            bool journalsFound = state.totalItemJournals > 0;

            //ketika kosong semua
            if (!authorsFound && !affiliationsFound && !journalsFound) {
              return Center(child: searchNotFound("Pencarian"));
            }

            //ketika salah satu atau dua yang ada
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (authorsFound)
                      ? resultCardAuthors(
                          context,
                          textEditingController.text,
                          state.authorsList,
                          state.totalItemAuthors,
                        )
                      : Container(),
                  (affiliationsFound)
                      ? resultCardAffiliations(
                          context,
                          textEditingController.text,
                          state.affiliationsList,
                          state.totalItemAffiliations,
                        )
                      : Container(),
                  (journalsFound)
                      ? resultCardJournals(
                          context,
                          textEditingController.text,
                          state.journalsList,
                          state.totalItemJournals,
                        )
                      : Container(),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
