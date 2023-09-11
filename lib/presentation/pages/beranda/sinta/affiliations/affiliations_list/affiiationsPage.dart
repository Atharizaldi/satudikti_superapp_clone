import 'package:app/data/source/remote/model/sinta/affiliations/AffiliationsList.dart';
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/inkEffect.dart';
import 'package:app/presentation/component/search/searchBar.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/reusableWidgets/reusableWidgetsCard.dart';
import 'package:app/presentation/pages/beranda/sinta/affiliations/affiliations_detail/affiliationsDetailPage.dart';
import 'package:app/presentation/pages/beranda/sinta/affiliations/affiliations_detail/bloc/affiliations_detail_bloc.dart';
import 'package:app/presentation/pages/beranda/sinta/affiliations/affiliations_detail/bloc/affiliations_scopus_publication_bloc.dart';
import 'package:app/presentation/pages/beranda/sinta/affiliations/affiliations_list/bloc/affiliations_list_bloc.dart';
import 'package:app/presentation/pages/beranda/sinta/component/defaultPtImage.dart';
import 'package:app/presentation/pages/beranda/sinta/sinta_affiliations_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/shims/dart_ui_fake.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../../../searchPage/component/searchNotFound.dart';

class AffiliationsPage extends StatefulWidget {
  final String keyword;
  final bool top;

  const AffiliationsPage({Key? key, required this.keyword, required this.top})
      : super(key: key);

  @override
  State<AffiliationsPage> createState() => _AffiliationsPageState();
}

class _AffiliationsPageState extends State<AffiliationsPage> {
  TextEditingController textEditingController = TextEditingController();
  ScrollController _scrollController = new ScrollController();
  late AffiliationsListBloc _affiliationsListBloc;
  Logger log = Logger();

  void onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;

    if (currentScroll == maxScroll) {
      _affiliationsListBloc.add(
        GetAffiliationsListEvent(
          keyword: _affiliationsListBloc.keywordSearch,
          top: widget.top,
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
    _affiliationsListBloc = BlocProvider.of<AffiliationsListBloc>(context);
    _scrollController.addListener(onScroll);
    textEditingController.text = widget.keyword;
    return Scaffold(
      backgroundColor: whiteBgPage,
      appBar: widget.top
          ? CustomAppBar(title: 'Top Affiliations')
          : CustomAppBar(title: 'Affiliations'),
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
              BlocBuilder<AffiliationsListBloc, AffiliationsListState>(
                builder: (context, state) {
                  if (state is AffiliationsListLoaded) {
                    return _loadedWidget(state);
                  } else if (state is AffiliationsListLoading) {
                    return affiliationsListLoadingWithTotal();
                  } else if (state is AffiliationsListNoInternet) {
                    return noInternetWithContainer();
                  } else if (state is AffiliationsListError) {
                    return serverProblem();
                  } else if (state is AffiliationsListNotFound) {
                    // return searchNotFound("Affiliations");
                    return Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _loadedFormatTotal(state),
                        searchNotFound("Affiliations")
                      ],
                    );
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

  Widget _loadedFormatTotal(AffiliationsListNotFound state) {
    String formattedTotalItem = state.totalItem.toString() == ""
        ? "0"
        : NumberFormat.currency(locale: 'id', decimalDigits: 0, name: '')
            .format(state.totalItem.toInt());
    return _textSpan(formattedTotalItem);
  }

  Widget _loadedWidget(AffiliationsListLoaded state) {
    String formattedTotalItem = state.totalItem.toString() == ""
        ? "0"
        : NumberFormat.currency(locale: 'id', decimalDigits: 0, name: '')
            .format(state.totalItem.toInt());
    // if (formattedTotalItem == "0") {
    //   return Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       _textSpan(formattedTotalItem),
    //       searchNotFound("Affiliations")
    //     ],
    //   );
    // } else {
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
                              "Affiliations",
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
                        _buildListViewTop(
                            context, state, state.affiliationsList),
                      ],
                    )),
              )
            : _buildListView(context, state, state.affiliationsList),
      ],
    );
  }
  // }

  Widget _searchBar() {
    return Container(
      color: Colors.transparent,
      child: SearchBar(
        controller: textEditingController,
        openKeyboard: false,
        hintText: 'Cari Affiliations disini',
        searchType: TypeSearchBar.regular,
        isSubmitted: (value) async {
          _affiliationsListBloc
              .add(GetAffiliationsListEvent(keyword: value, top: false));
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
                  text: ' affiliations',
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
                  text: ' affiliations yang tersedia',
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
    BuildContext context,
    AffiliationsListLoaded state,
    List<Affiliations> list,
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
                      create: (context) => di.locator<AffiliationsDetailBloc>()
                        ..add(GetAffiliationsDetailEvent(
                            id: list[index].id ?? "")),
                    ),
                    BlocProvider(
                      create: (context) =>
                          di.locator<AffiliationsScopusPublicationBloc>()
                            ..add(GetAffiliationsScopusEvent(
                                id: list[index].id ?? "")),
                    ),
                  ],
                  child: AffiliationsDetailPage(
                    id: list[index].id ?? "",
                  ),
                ),
              ),
            );
          });
        } else {
          return affiliationsCardSkeleton();
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
    Affiliations affiliations,
    VoidCallback onTap,
  ) {
    String logo = affiliations.logo ?? "-";
    String nama = affiliations.name ?? "-";
    String singkatan = affiliations.abbreviaton ?? "-";
    String id = affiliations.id ?? "-";
    String code = affiliations.codePddikti ?? "-";
    String provinceT = affiliations.province?.name ?? "";
    String cityT = affiliations.city?.name ?? "";
    String kodeNegaraT = affiliations.country ?? "";
    String province = "${(provinceT == "") ? "-" : provinceT}";
    String city = "${(cityT == "") ? "-" : cityT}";
    String kodeNegara = "${(kodeNegaraT == "") ? "-" : kodeNegaraT}";
    return InkEffect(
      onTap: onTap,
      boxDecoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (logo != "")
                ? Image.network(
                    logo,
                    width: 60.w,
                    height: 60.w,
                    fit: BoxFit.contain,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return defaultPtImage();
                    },
                  )
                : defaultPtImage(),
            SizedBox(
              width: 12.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText(
                    (nama == "") ? "-" : nama,
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
                  Row(
                    children: [
                      SelectableText(
                        (singkatan == "") ? "-" : singkatan,
                        onTap: onTap,
                        enableInteractiveSelection: false,
                        style: TextStyle(
                          color: neutral50,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      SelectableText(
                        "ID : ${(id == "") ? "-" : id}",
                        onTap: onTap,
                        enableInteractiveSelection: false,
                        style: TextStyle(
                          color: neutral50,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      SelectableText(
                        "Code : ${(code == "") ? "-" : code}",
                        onTap: onTap,
                        enableInteractiveSelection: false,
                        style: TextStyle(
                          color: neutral50,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/ic_location.png",
                        width: (12.66).h,
                        height: (13.5).w,
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      Text(
                        "$province, ",
                        style: TextStyle(
                          color: blue4,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                        ),
                      ),
                      Text(
                        "$city, ",
                        style: TextStyle(
                          color: blue4,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                        ),
                      ),
                      Text(
                        "$kodeNegara",
                        style: TextStyle(
                          color: blue4,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListViewTop(
    BuildContext context,
    AffiliationsListLoaded state,
    List<Affiliations> list,
  ) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: (state.hasReachedMax) ? list.length : list.length + 1,
      itemBuilder: (BuildContext context, index) {
        if (index < list.length) {
          return _buildListCardTop(
              index, context, index.toString(), list[index], () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (builder) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => di.locator<AffiliationsDetailBloc>()
                        ..add(GetAffiliationsDetailEvent(
                            id: list[index].id ?? "")),
                    ),
                    BlocProvider(
                      create: (context) =>
                          di.locator<AffiliationsScopusPublicationBloc>()
                            ..add(GetAffiliationsScopusEvent(
                                id: list[index].id ?? "")),
                    ),
                  ],
                  child: AffiliationsDetailPage(
                    id: list[index].id ?? "",
                  ),
                ),
              ),
            );
          });
        } else {
          return affiliationsCardSkeleton();
        }
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
    );
  }

  Widget _buildListCardTop(
    int index,
    BuildContext context,
    String value,
    Affiliations affiliations,
    VoidCallback onTap,
  ) {
    String logo = affiliations.logo ?? "-";
    String nama = affiliations.name ?? "-";
    String singkatan = affiliations.abbreviaton ?? "-";
    String score = affiliations.sintaScoreV3_3year ?? "-";
    String id = affiliations.id ?? "-";
    String code = affiliations.codePddikti ?? "-";
    String provinceT = affiliations.province?.name ?? "";
    String cityT = affiliations.city?.name ?? "";
    String kodeNegaraT = affiliations.country ?? "";
    String province = "${(provinceT == "") ? "-" : provinceT}";
    String city = "${(cityT == "") ? "-" : cityT}";
    String kodeNegara = "${(kodeNegaraT == "") ? "-" : kodeNegaraT}";
    return InkEffect(
        onTap: onTap,
        boxDecoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Container(
          height: 99.5.h,
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${index + 1}",
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF000000),
                      letterSpacing: -0.06),
                ),
                SizedBox(
                  width: 12.w,
                ),
                (logo != "")
                    ? Image.network(
                        logo,
                        width: 47.w,
                        height: 50.w,
                        fit: BoxFit.contain,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return defaultPtImage();
                        },
                      )
                    : defaultPtImage(),
                SizedBox(
                  width: 12.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 170.w,
                        child: Text(
                          (nama == "") ? "-" : nama,
                          style: TextStyle(
                              color: blue4,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              letterSpacing: 0.06,
                              overflow: TextOverflow.fade),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: [
                          SelectableText(
                            "ID : ${(id == "") ? "-" : id}",
                            onTap: onTap,
                            enableInteractiveSelection: false,
                            style: TextStyle(
                              color: neutral50,
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                            ),
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          SelectableText(
                            "Code : ${(code == "") ? "-" : code}",
                            onTap: onTap,
                            enableInteractiveSelection: false,
                            style: TextStyle(
                              color: neutral50,
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Image.asset(
                            "assets/icons/ic_location.png",
                            width: (12.66).h,
                            height: (13.5).w,
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Text(
                            "$city ",
                            style: TextStyle(
                              color: blue4,
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Text(
                  score.split('.').first,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: green3,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
