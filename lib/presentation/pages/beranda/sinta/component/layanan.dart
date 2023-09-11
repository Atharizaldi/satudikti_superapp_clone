import 'package:app/data/source/remote/model/sinta/affiliations/AffiliationsList.dart';
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/inkEffect.dart';
import 'package:app/presentation/pages/beranda/sinta/affiliations/affiliations_list/affiiationsPage.dart';
import 'package:app/presentation/pages/beranda/sinta/affiliations/affiliations_list/bloc/affiliations_list_bloc.dart';
import 'package:app/presentation/pages/beranda/sinta/authors/authors_list/authorsPage.dart';
import 'package:app/presentation/pages/beranda/sinta/authors/authors_list/bloc/authors_list_bloc.dart';
import 'package:app/presentation/pages/beranda/sinta/journals/journals_list/bloc/journals_list_bloc.dart';
import 'package:app/presentation/pages/beranda/sinta/journals/journals_list/journalsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../data/source/remote/model/sinta/authors/AuthorsList.dart';
import '../../kompetensiDosen/reusableWidgets/reusableWidgetsCard.dart';
import '../affiliations/affiliations_detail/affiliationsDetailPage.dart';
import '../affiliations/affiliations_detail/bloc/affiliations_detail_bloc.dart';
import '../affiliations/affiliations_detail/bloc/affiliations_scopus_publication_bloc.dart';
import '../authors/authors_detail/authors_detail_page.dart';
import '../authors/authors_detail/bloc/authors_detail_bloc.dart';
import '../authors/authors_detail/bloc/authors_scopus_publication_bloc.dart';
import '../sinta_affiliations_loading.dart';
import '../sinta_authors_loading.dart';
import 'defaultPtImage.dart';

Widget layanan(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Pilih Layanan",
        style: TextStyle(
            color: blue3, fontWeight: FontWeight.w700, fontSize: 20.sp),
      ),
      SizedBox(
        height: 20.h,
      ),
      cardLayanan(
        "Authors",
        "Cari dan temukan penulis jurnal pilihanmu beserta informasi detailnya disini.",
        () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (builder) => BlocProvider(
                        create: (context) => di.locator<AuthorsListBloc>()
                          ..add(GetAuthorsListEvent(keyword: "", top: false)),
                        child: AuthorsPage(
                          keyword: "",
                          top: false,
                        ),
                      )));
        },
        Image.asset(
          "assets/sinta/ic_authors.png",
          width: 24.w,
          height: 30.w,
          fit: BoxFit.fill,
          alignment: Alignment.center,
        ),
      ),
      SizedBox(
        height: 20.h,
      ),
      cardLayanan(
        "Affiliations",
        "Cari dan temukan afiliasi dari berbagai lembaga, perguruan tinggi, dan departemen yang dapat kamu akses disini.",
        () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (builder) => BlocProvider(
                        create: (context) => di.locator<AffiliationsListBloc>()
                          ..add(GetAffiliationsListEvent(
                              keyword: "", top: false)),
                        child: AffiliationsPage(
                          keyword: "",
                          top: false,
                        ),
                      )));
        },
        Image.asset(
          "assets/sinta/ic_affiliations.png",
          width: 28.w,
          height: 24.w,
          fit: BoxFit.fill,
          alignment: Alignment.center,
        ),
      ),
      SizedBox(
        height: 20.h,
      ),
      cardLayanan(
        "Journals",
        "Cari dan temukan kumpulan jurnal dari berbagai penulis dan afiliasi yang dapat kamu unduh disini.",
        () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (builder) => BlocProvider(
                        create: (context) => di.locator<JournalsListBloc>()
                          ..add(GetJournalsListEvent(keyword: "")),
                        child: JournalsPage(
                          keyword: "",
                        ),
                      )));
        },
        Image.asset(
          "assets/sinta/ic_journals.png",
          width: 24.w,
          height: 27.w,
          fit: BoxFit.fill,
          alignment: Alignment.center,
        ),
      ),
      SizedBox(
        height: 48.h,
      ),
      Text(
        "Top 50 Authors",
        style: TextStyle(
            color: blue3, fontWeight: FontWeight.w700, fontSize: 20.sp),
      ),
      SizedBox(
        height: 26.h,
      ),
      Container(
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
                BlocProvider(
                    create: (context) => di.locator<AuthorsListBloc>()
                      ..add(GetAuthorsListEvent(keyword: "", top: true)),
                    child: BlocBuilder<AuthorsListBloc, AuthorsListState>(
                        builder: (context, state) {
                      if (state is AuthorsListLoaded) {
                        return listViewAuthors(context, state);
                      } else if (state is AuthorsListLoading) {
                        return authorsListLoadingWithTotal();
                      } else if (state is AuthorsListNoInternet) {
                        return noInternetWithContainer();
                      } else if (state is AuthorsListError) {
                        return serverProblem();
                      }
                      return Container();
                    })),
                Divider(),
                SizedBox(
                  height: 20.h,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => BlocProvider(
                                  create: (context) =>
                                      di.locator<AuthorsListBloc>()
                                        ..add(GetAuthorsListEvent(
                                            keyword: "", top: true)),
                                  child: AuthorsPage(
                                    keyword: "",
                                    top: true,
                                  ),
                                )));
                  },
                  child: Text(
                    "Lihat Semua",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: blue4,
                    ),
                  ),
                )
              ],
            )),
      ),
      SizedBox(
        height: 34.h,
      ),
      Text(
        "Top 100 Affiliations",
        style: TextStyle(
            color: blue3, fontWeight: FontWeight.w700, fontSize: 20.sp),
      ),
      SizedBox(
        height: 26.h,
      ),
      Container(
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
                BlocProvider(
                    create: (context) => di.locator<AffiliationsListBloc>()
                      ..add(GetAffiliationsListEvent(keyword: "", top: true)),
                    child: BlocBuilder<AffiliationsListBloc,
                        AffiliationsListState>(
                      builder: (context, state) {
                        if (state is AffiliationsListLoaded) {
                          return listViewAffiliations(context, state);
                        } else if (state is AffiliationsListLoading) {
                          return affiliationsListLoadingWithTotal();
                        } else if (state is AffiliationsListNoInternet) {
                          return noInternetWithContainer();
                        } else if (state is AffiliationsListError) {
                          return serverProblem();
                        }
                        return Container();
                      },
                    )),
                Divider(),
                SizedBox(
                  height: 20.h,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => BlocProvider(
                                  create: (context) =>
                                      di.locator<AffiliationsListBloc>()
                                        ..add(GetAffiliationsListEvent(
                                            keyword: "", top: true)),
                                  child: AffiliationsPage(
                                    keyword: "",
                                    top: true,
                                  ),
                                )));
                  },
                  child: Text(
                    "Lihat Semua",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: blue4,
                    ),
                  ),
                )
              ],
            )),
      ),
    ],
  );
}

Widget listViewAuthors(BuildContext context, AuthorsListLoaded state) {
  return ListView.separated(
    padding: EdgeInsets.all(0),
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: 4,
    itemBuilder: (BuildContext context, index) {
      List<Authors> list = state.authorsList;
      print(list[index].score);
      return GestureDetector(
          onTap: () {
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
          },
          child: Container(
              height: 62,
              child: Center(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 1.w,
                  ),
                  Text(
                    "${index + 1}",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF666666),
                    ),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        list[index].name ?? "",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: blue4,
                        ),
                      ),
                      SizedBox(
                        width: 187.w,
                        child: Text(
                          list[index].affiliation?.name ?? "",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF999999),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                  Spacer(),
                  Text(
                    list[index].score ?? "",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: green3,
                    ),
                  ),
                ],
              ))));
    },
    separatorBuilder: (BuildContext context, int index) {
      return Divider();
    },
  );
}

Widget listViewAffiliations(
    BuildContext context, AffiliationsListLoaded state) {
  return ListView.separated(
    padding: EdgeInsets.all(0),
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: 5,
    itemBuilder: (BuildContext context, index) {
      List<Affiliations> list = state.affiliationsList;
      return GestureDetector(
          onTap: () {
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
          },
          child: Container(
              height: 62,
              child: Center(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 1.w,
                  ),
                  Text(
                    "${index + 1}",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF666666),
                    ),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  (list[index].logo != "")
                      ? Image.network(
                          list[index].logo ?? "",
                          width: 36.w,
                          height: 36.w,
                          fit: BoxFit.contain,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return defaultPtImageMini();
                          },
                        )
                      : defaultPtImageMini(),
                  SizedBox(
                    width: 8.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                          width: 187.w,
                          child: Text(
                            list[index].name ?? "",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: blue4,
                            ),
                            maxLines: 3,
                          )),
                      Text(list[index].abbreviaton ?? "",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF999999),
                          )),
                    ],
                  ),
                  Spacer(),
                  Text(
                    list[index].sintaScoreV3_3year?.split('.').first ?? "",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: green3,
                    ),
                  ),
                ],
              ))));
    },
    separatorBuilder: (BuildContext context, int index) {
      return Divider();
    },
  );
}

Widget cardLayanan(
    String title, String subTitle, VoidCallback onTap, Widget centerImage) {
  return InkEffect(
    onTap: onTap,
    boxDecoration:
        BoxDecoration(color: white, borderRadius: BorderRadius.circular(10.r)),
    child: Padding(
      padding: EdgeInsets.all(20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 64.h,
            height: 64.h,
            decoration: BoxDecoration(
              color: Color(0xffF8F9FD),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(child: centerImage),
          ),
          SizedBox(
            width: 20.w,
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: blue4,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp),
                ),
                SizedBox(
                  width: 6.h,
                ),
                Text(
                  subTitle,
                  style: TextStyle(
                      color: teksAbuCerah4,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      letterSpacing: 0.5),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
