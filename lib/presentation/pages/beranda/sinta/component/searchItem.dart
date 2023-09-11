import 'package:app/data/source/remote/model/sinta/affiliations/AffiliationsList.dart';
import 'package:app/data/source/remote/model/sinta/authors/AuthorsList.dart';
import 'package:app/data/source/remote/model/sinta/journals/JournalsList.dart';
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/inkEffect.dart';
import 'package:app/presentation/component/sub_title_with_arrow_lainnya.dart';
import 'package:app/presentation/pages/beranda/sinta/affiliations/affiliations_detail/affiliationsDetailPage.dart';
import 'package:app/presentation/pages/beranda/sinta/affiliations/affiliations_detail/bloc/affiliations_detail_bloc.dart';
import 'package:app/presentation/pages/beranda/sinta/affiliations/affiliations_detail/bloc/affiliations_scopus_publication_bloc.dart';
import 'package:app/presentation/pages/beranda/sinta/affiliations/affiliations_list/affiiationsPage.dart';
import 'package:app/presentation/pages/beranda/sinta/affiliations/affiliations_list/bloc/affiliations_list_bloc.dart';
import 'package:app/presentation/pages/beranda/sinta/authors/authors_detail/authors_detail_page.dart';
import 'package:app/presentation/pages/beranda/sinta/authors/authors_detail/bloc/authors_detail_bloc.dart';
import 'package:app/presentation/pages/beranda/sinta/authors/authors_detail/bloc/authors_scopus_publication_bloc.dart';
import 'package:app/presentation/pages/beranda/sinta/authors/authors_list/authorsPage.dart';
import 'package:app/presentation/pages/beranda/sinta/authors/authors_list/bloc/authors_list_bloc.dart';
import 'package:app/presentation/pages/beranda/sinta/component/defaultPtImage.dart';
import 'package:app/presentation/pages/beranda/sinta/journals/detail/bloc/journals_detail_bloc.dart';
import 'package:app/presentation/pages/beranda/sinta/journals/detail/bloc/journals_scopus_publication_bloc.dart';
import 'package:app/presentation/pages/beranda/sinta/journals/detail/journalsDetailPage.dart';
import 'package:app/presentation/pages/beranda/sinta/journals/journals_list/bloc/journals_list_bloc.dart';
import 'package:app/presentation/pages/beranda/sinta/journals/journals_list/journalsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

Container resultCardAuthors(BuildContext context, String keyword,
    List<Authors> authorsList, int totalItem) {
  String formattedTotalItem = totalItem.toString() == ""
      ? "0"
      : NumberFormat.currency(locale: 'id', decimalDigits: 0, name: '')
          .format(totalItem.toInt());
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16.w),
    margin: EdgeInsets.only(bottom: 20.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SubTitleWithArrowLainnya(
          subJudul: 'Authors ($formattedTotalItem)',
          function: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => BlocProvider(
                          create: (context) => di.locator<AuthorsListBloc>()
                            ..add(GetAuthorsListEvent(keyword: keyword, top: false)),
                          child: AuthorsPage(keyword: keyword, top: false,),
                        )));
          },
        ),
        SizedBox(
          height: 20.h,
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: authorsList.length == 1 ? 1 : 2,
          itemBuilder: (context, index) {
            return _buildAuthorsCard(authorsList[index], () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (builder) => MultiBlocProvider(
                    providers: [
                      BlocProvider(
                          create: (context) => di.locator<AuthorsDetailBloc>()
                            ..add(GetAuthorsDetailEvent(
                                nidn: authorsList[index].id ?? ""))),
                      BlocProvider(
                          create: (context) =>
                              di.locator<AuthorsScopusPublicationBloc>()
                                ..add(GetAuthorsScopusEvent(
                                    nidn: authorsList[index].id ?? ""))),
                    ],
                    child: AuthorsDetailpage(
                      nidn: authorsList[index].nidn ?? "",
                    ),
                  ),
                ),
              );
            });
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 20.h);
          },
        ),
      ],
    ),
  );
}

Widget _buildAuthorsCard(
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

Container resultCardAffiliations(BuildContext context, String keyword,
    List<Affiliations> affiliationsList, int totalItem) {
  String formattedTotalItem = totalItem.toString() == ""
      ? "0"
      : NumberFormat.currency(locale: 'id', decimalDigits: 0, name: '')
          .format(totalItem.toInt());
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16.w),
    margin: EdgeInsets.only(bottom: 20.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SubTitleWithArrowLainnya(
          subJudul: 'Affiliations ($formattedTotalItem)',
          function: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => BlocProvider(
                          create: (context) => di
                              .locator<AffiliationsListBloc>()
                            ..add(GetAffiliationsListEvent(keyword: keyword, top: false)),
                          child: AffiliationsPage(keyword: keyword, top: false,),
                        )));
          },
        ),
        SizedBox(
          height: 20.h,
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: affiliationsList.length == 1 ? 1 : 2,
          itemBuilder: (context, index) {
            return _buildAffiliationsCard(affiliationsList[index], () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (builder) => MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) =>
                            di.locator<AffiliationsDetailBloc>()
                              ..add(GetAffiliationsDetailEvent(
                                  id: affiliationsList[index].id ?? "")),
                      ),
                      BlocProvider(
                        create: (context) =>
                            di.locator<AffiliationsScopusPublicationBloc>()
                              ..add(GetAffiliationsScopusEvent(
                                  id: affiliationsList[index].id ?? "")),
                      ),
                    ],
                    child: AffiliationsDetailPage(
                      id: affiliationsList[index].id ?? "",
                    ),
                  ),
                ),
              );
            });
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 20.h);
          },
        ),
      ],
    ),
  );
}

Widget _buildAffiliationsCard(
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

Container resultCardJournals(BuildContext context, String keyword,
    List<Journals> journalsList, int totalItem) {
  String formattedTotalItem = totalItem.toString() == ""
      ? "0"
      : NumberFormat.currency(locale: 'id', decimalDigits: 0, name: '')
          .format(totalItem.toInt());
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16.w),
    margin: EdgeInsets.only(bottom: 20.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SubTitleWithArrowLainnya(
          subJudul: 'Journals ($formattedTotalItem)',
          function: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => BlocProvider(
                          create: (context) => di.locator<JournalsListBloc>()
                            ..add(GetJournalsListEvent(keyword: keyword)),
                          child: JournalsPage(keyword: keyword),
                        )));
          },
        ),
        SizedBox(
          height: 20.h,
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: journalsList.length == 1 ? 1 : 2,
          itemBuilder: (context, index) {
            return _buildJournalsCard(journalsList[index], () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (builder) => MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => di.locator<JournalsDetailBloc>()
                          ..add(GetJournalsDetailEvent(
                              id: journalsList[index].id ?? "")),
                      ),
                      BlocProvider(
                        create: (context) =>
                            di.locator<JournalsScopusPublicationBloc>()
                              ..add(GetJournalsScopusEvent(
                                  id: journalsList[index].id ?? "")),
                      ),
                    ],
                    child: JournalsDetailPage(
                      id: journalsList[index].id ?? "",
                    ),
                  ),
                ),
              );
            });
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 20.h);
          },
        ),
      ],
    ),
  );
}

Widget _buildJournalsCard(
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
