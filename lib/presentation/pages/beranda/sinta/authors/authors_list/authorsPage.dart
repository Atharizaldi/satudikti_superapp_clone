import 'package:app/data/source/remote/model/sinta/authors/AuthorsList.dart';
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/inkEffect.dart';
import 'package:app/presentation/component/search/searchBar.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/reusableWidgets/reusableWidgetsCard.dart';
import 'package:app/presentation/pages/beranda/searchPage/component/searchNotFound.dart';
import 'package:app/presentation/pages/beranda/sinta/authors/authors_detail/authors_detail_page.dart';
import 'package:app/presentation/pages/beranda/sinta/authors/authors_detail/bloc/authors_detail_bloc.dart';
import 'package:app/presentation/pages/beranda/sinta/authors/authors_detail/bloc/authors_scopus_publication_bloc.dart';
import 'package:app/presentation/pages/beranda/sinta/authors/authors_list/bloc/authors_list_bloc.dart';
import 'package:app/presentation/pages/beranda/sinta/sinta_authors_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/shims/dart_ui_fake.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class AuthorsPage extends StatefulWidget {
  final String keyword;
  final bool top;

  const AuthorsPage({Key? key, required this.keyword, required this.top})
      : super(key: key);

  @override
  State<AuthorsPage> createState() => _AuthorsPageState();
}

class _AuthorsPageState extends State<AuthorsPage> {
  TextEditingController textEditingController = TextEditingController();
  ScrollController _scrollController = new ScrollController();
  late AuthorsListBloc _authorsListBloc;
  Logger log = Logger();

  void onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;

    if (currentScroll == maxScroll) {
      _authorsListBloc.add(
        GetAuthorsListEvent(
            keyword: _authorsListBloc.keywordSearch, top: widget.top),
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
    _authorsListBloc = BlocProvider.of<AuthorsListBloc>(context);
    _scrollController.addListener(onScroll);
    textEditingController.text = widget.keyword;
    return Scaffold(
      backgroundColor: whiteBgPage,
      appBar: widget.top
          ? CustomAppBar(title: 'Top Authors')
          : CustomAppBar(title: 'Authors'),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.top
                  ? SizedBox()
                  : SizedBox(
                      height: 30.h,
                    ),
              widget.top ? SizedBox() : _searchBar(),
              SizedBox(
                height: 30.h,
              ),
              BlocBuilder<AuthorsListBloc, AuthorsListState>(
                builder: (context, state) {
                  if (state is AuthorsListLoaded) {
                    return _loadedWidget(state);
                  } else if (state is AuthorsListLoading) {
                    return authorsListLoadingWithTotal();
                  } else if (state is AuthorsListNoInternet) {
                    return noInternetWithContainer();
                  } else if (state is AuthorsListError) {
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

  Widget _loadedWidget(AuthorsListLoaded state) {
    String formattedTotalItem = state.totalItem.toString() == ""
        ? "0"
        : NumberFormat.currency(locale: 'id', decimalDigits: 0, name: '')
            .format(state.totalItem.toInt());
    if (formattedTotalItem == "0") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_textSpan(formattedTotalItem), searchNotFound("Authors")],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _textSpan(formattedTotalItem),
          SizedBox(
            height: 20.h,
          ),
          widget.top
              ? Container(
                  decoration: BoxDecoration(
                      color: white, borderRadius: BorderRadius.circular(10.r)),
                  child: Padding(
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "#",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF666666),
                                ),
                              ),
                              SizedBox(
                                width: 9.w,
                              ),
                              Text(
                                "Authors",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF666666),
                                ),
                              ),
                              Spacer(),
                              Image.asset(
                                'assets/sinta/small_logo.png',
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                "Score",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF666666),
                                ),
                              ),
                            ],
                          ),
                          Divider(),
                          _buildListViewTop(context, state, state.authorsList),
                        ],
                      )),
                )
              : _buildListView(context, state, state.authorsList),
        ],
      );
    }
  }

  Widget _notFoundWidget(AuthorsListLoaded state) {
    String formattedTotalItem = state.totalItem.toString() == ""
        ? "0"
        : NumberFormat.currency(locale: 'id', decimalDigits: 0, name: '')
            .format(state.totalItem.toInt());
    return Column(
      children: [_textSpan(formattedTotalItem), searchNotFound("text")],
    );
  }

  Widget _searchBar() {
    return Container(
      color: Colors.transparent,
      child: SearchBar(
        controller: textEditingController,
        openKeyboard: false,
        hintText: 'Cari Authors disini',
        searchType: TypeSearchBar.regular,
        isSubmitted: (value) async {
          _authorsListBloc.add(GetAuthorsListEvent(keyword: value, top: false));
        },
      ),
    );
  }

  Widget _textSpan(String totalItem) {
    return widget.top
        ? Text.rich(
            TextSpan(
              text: 'Top ',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: neutralCaption,
              ),
              children: <InlineSpan>[
                TextSpan(
                  text: totalItem,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: ' authors',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: neutralCaption,
                  ),
                )
              ],
            ),
          )
        : Text.rich(
            TextSpan(
              text: 'Ada ',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: neutralCaption,
              ),
              children: <InlineSpan>[
                TextSpan(
                  text: totalItem,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: ' authors yang tersedia',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: neutralCaption,
                  ),
                )
              ],
            ),
          );
  }

  Widget _buildListView(
      BuildContext context, AuthorsListLoaded state, List<Authors> list) {
    return ListView.separated(
      padding: EdgeInsets.all(0),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: (state.hasReachedMax) ? list.length : list.length + 1,
      itemBuilder: (BuildContext context, index) {
        if (index < list.length) {
          return _buildListCard(list[index], () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (builder) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                        create: (context) => di.locator<AuthorsDetailBloc>()
                          ..add(GetAuthorsDetailEvent(
                              nidn: list[index].nidn ?? ""))),
                    BlocProvider(
                        create: (context) =>
                            di.locator<AuthorsScopusPublicationBloc>()
                              ..add(GetAuthorsScopusEvent(
                                  nidn: list[index].nidn ?? ""))),
                  ],
                  child: AuthorsDetailpage(
                    nidn: list[index].nidn ?? "",
                  ),
                ),
              ),
            );
          });
        } else {
          return authorsCardSkeleton();
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
    Authors authors,
    VoidCallback onTap,
  ) {
    String nama = authors.name ?? "-";
    String namaUniv = authors.affiliation?.name ?? "-";
    String sintaId = authors.id ?? "-";
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
              (nama != "") ? nama : "-",
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
              (namaUniv != "") ? namaUniv : "-",
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
            SelectableText(
              "Sinta ID: ${(sintaId != "") ? sintaId : "-"}",
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
      ),
    );
  }

  Widget _buildListViewTop(
      BuildContext context, AuthorsListLoaded state, List<Authors> list) {
    return ListView.separated(
      padding: EdgeInsets.all(0),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: (state.hasReachedMax) ? list.length : list.length + 1,
      itemBuilder: (BuildContext context, index) {
        if (index < list.length) {
          return _buildListCardTop(index, list[index], () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (builder) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                        create: (context) => di.locator<AuthorsDetailBloc>()
                          ..add(GetAuthorsDetailEvent(
                              nidn: list[index].nidn ?? ""))),
                    BlocProvider(
                        create: (context) =>
                            di.locator<AuthorsScopusPublicationBloc>()
                              ..add(GetAuthorsScopusEvent(
                                  nidn: list[index].nidn ?? ""))),
                  ],
                  child: AuthorsDetailpage(
                    nidn: list[index].nidn ?? "",
                  ),
                ),
              ),
            );
          });
        } else {
          return authorsCardSkeleton();
        }
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
    );
  }

  Widget _buildListCardTop(
    int index,
    Authors authors,
    VoidCallback onTap,
  ) {
    String nama = authors.name ?? "-";
    String namaUniv = authors.affiliation?.name ?? "-";
    String sintaId = authors.id ?? "-";
    String score = authors.score ?? "-";
    return InkEffect(
        onTap: onTap,
        boxDecoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Container(
            height: 88,
            child: Center(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 1.w,
                ),
                Text(
                  "${index + 1}",
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF000000),
                      letterSpacing: -0.021),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 230.w,
                      child: Text(
                        nama,
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: blue4,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    SizedBox(
                      width: 187.w,
                      child: Text(
                        namaUniv,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF808080),
                          letterSpacing: 0.05,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    SelectableText(
                      "Sinta ID: ${(sintaId != "") ? sintaId : "-"}",
                      onTap: onTap,
                      enableInteractiveSelection: false,
                      style: TextStyle(
                          color: teksAbuCerah4,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                          letterSpacing: 0.05,
                          height: 1.2),
                    ),
                  ],
                ),
                Spacer(),
                Text(
                  score.split(".").first,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: green3,
                  ),
                ),
              ],
            ))));
  }
}
