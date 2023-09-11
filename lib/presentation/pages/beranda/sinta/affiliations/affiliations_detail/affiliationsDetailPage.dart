import 'package:app/data/source/remote/model/sinta/affiliations/AffiliationsDetail.dart'
    as affiliationsDetail;
import 'package:app/data/source/remote/model/sinta/affiliations/AffiliationsScopus.dart'
    as affiliationsScopus;
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/inkEffect.dart';
import 'package:app/presentation/component/sub_title_with_arrow_lainnya.dart';
import 'package:app/presentation/pages/beranda/sinta/affiliations/affiliations_detail/bloc/affiliations_detail_bloc.dart';
import 'package:app/presentation/pages/beranda/sinta/affiliations/affiliations_detail/bloc/affiliations_scopus_publication_bloc.dart';
import 'package:app/presentation/pages/beranda/sinta/affiliations/affiliations_scopus_publication/affiliations_scopus_publication_page.dart';
import 'package:app/presentation/pages/beranda/sinta/component/defaultPtImage.dart';
import 'package:app/presentation/pages/beranda/sinta/sinta_affiliations_loading.dart';
import 'package:app/presentation/pages/beranda/sinta/sinta_loading.dart';
import 'package:app/presentation/pages/showWebsite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class AffiliationsDetailPage extends StatelessWidget {
  final String id;

  AffiliationsDetailPage({required this.id});

  final TextStyle _textStyle = TextStyle(
      color: teksAbuCerah4, fontWeight: FontWeight.w400, fontSize: 12.sp);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBgPage,
      appBar: CustomAppBar(title: 'Affiliations'),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30.h,
              ),
              _profil(),
              SizedBox(
                height: 20.h,
              ),
              _summary(),
              SizedBox(
                height: 30.h,
              ),
              _publikasiScopus(),
              SizedBox(
                height: 30.h,
              ),
              _kunjungiWebsite(),
              SizedBox(
                height: 36.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profil() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
          color: white, borderRadius: BorderRadius.circular(10.r)),
      child: BlocBuilder<AffiliationsDetailBloc, AffiliationsDetailState>(
        builder: (context, state) {
          if (state is AffiliationsDetailLoaded) {
            affiliationsDetail.Affiliations affiliations = state.affiliations;
            String id = affiliations.id ?? "-";
            String kodePt = affiliations.codePddikti ?? "-";
            String univ = affiliations.name ?? "-";
            String singkatan = affiliations.abbreviaton ?? "-";
            String univWithSingkatan =
                "${(univ == "") ? "-" : univ} (${(singkatan == "") ? "-" : singkatan})";
            String provinceT = affiliations.province?.name ?? "";
            String cityT = affiliations.city?.name ?? "";
            String kodeNegaraT = affiliations.country ?? "";
            String province = "${(provinceT == "") ? "-" : provinceT}";
            String city = "${(cityT == "") ? "-" : cityT}";
            String kodeNegara = "${(kodeNegaraT == "") ? "-" : kodeNegaraT}";
            String logo = affiliations.logo ?? "";
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r)),
                      child: (logo != "")
                          ? Image.network(
                              logo,
                              width: 60.w,
                              height: 60.w,
                              fit: BoxFit.contain,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                                return defaultPtImage();
                              },
                            )
                          : defaultPtImage(),
                    ),
                  ],
                ),
                SizedBox(
                  width: 20.w,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SelectableText(
                            "ID: ${(id == "") ? "-" : id}",
                            style: _textStyle,
                          ),
                          SizedBox(
                            width: 12.w,
                          ),
                          SelectableText(
                            "Kode PT: ${(kodePt == "") ? "-" : kodePt}",
                            style: _textStyle,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      SelectableText(
                        univWithSingkatan,
                        style: _textStyle.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: blue4),
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
                          SelectableText(
                            "$province, ",
                            style: TextStyle(
                              color: blue4,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                            ),
                          ),
                          SelectableText(
                            "$city, ",
                            style: TextStyle(
                              color: blue4,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                            ),
                          ),
                          SelectableText(
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
            );
          }
          return affiliationsProfileSkeleton();
        },
      ),
    );
  }

  Widget _summary() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Statistik Summary Affiliations",
          style: TextStyle(
            color: blue3,
            fontWeight: FontWeight.w700,
            fontSize: 20.sp,
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        BlocBuilder<AffiliationsDetailBloc, AffiliationsDetailState>(
          builder: (context, state) {
            if (state is AffiliationsDetailLoaded) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _itemRank("SINTA Score Overall", state.overall,
                          Color(0xff62CCB3)),
                      SizedBox(
                        width: 20.w,
                      ),
                      _itemRank("SINTA Score 3 Yr", state.overall3y,
                          Color(0xff1A689E))
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _itemRank("SINTA Score Productivity", state.productivity,
                          Color(0xff9EDE73)),
                      SizedBox(
                        width: 20.w,
                      ),
                      _itemRank("Shinta Score Productivity 3 Yr",
                          state.productivity3y, Color(0xff1A689E))
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  _summaryTable(state.tables),
                ],
              );
            }
            return affiliationsSummarySkeleton();
          },
        ),
      ],
    );
  }

  Widget _itemRank(String title, String value, Color valueColor) {
    TextStyle _itemTextStyle = TextStyle(
        color: neutral30, fontSize: 10.sp, fontWeight: FontWeight.w500);
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
            color: white, borderRadius: BorderRadius.circular(10.r)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: _itemTextStyle,
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              value,
              style: _itemTextStyle.copyWith(
                  color: valueColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryTable(List<List<String>> tables) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
      decoration: BoxDecoration(
          color: white, borderRadius: BorderRadius.circular(10.r)),
      child: Column(
        children: [
          _itemTableTitle(),
          SizedBox(
            height: 10.h,
          ),
          _itemTable("Article", tables[0][0], tables[0][1], tables[0][2],
              tables[0][3]),
          SizedBox(
            height: 18.h,
          ),
          _itemTable("Citation", tables[1][0], tables[1][1], tables[1][2],
              tables[1][3]),
          SizedBox(
            height: 18.h,
          ),
          _itemTable("Cited Document", tables[2][0], tables[2][1], tables[2][2],
              tables[2][3]),
        ],
      ),
    );
  }

  Widget _itemTableTitle() {
    TextStyle _titleTextStyle = TextStyle(
      fontSize: 10.sp,
      fontWeight: FontWeight.w500,
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 90.w,
          height: 15.h,
        ),
        Container(
          width: 53.w,
          height: 15.h,
          child: Center(
            child: Text(
              "Scopus",
              style: _titleTextStyle.copyWith(color: Color(0xffF79400)),
            ),
          ),
        ),
        Container(
          width: 53.w,
          height: 15.h,
          child: Center(
            child: Text(
              "GScholar",
              style: _titleTextStyle.copyWith(color: Color(0xff3FBE2B)),
            ),
          ),
        ),
        Container(
          width: 53.w,
          height: 15.h,
          child: Center(
            child: Text(
              "WOS",
              style: _titleTextStyle.copyWith(color: Color(0xff0E7AC5)),
            ),
          ),
        ),
        Container(
          width: 53.w,
          height: 15.h,
          child: Center(
            child: Text(
              "Garuda",
              style: _titleTextStyle.copyWith(color: Color(0xffF66951)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _itemTable(String value1, String value2, String value3, String value4,
      String value5) {
    TextStyle _titleTextStyle = TextStyle(
      color: neutral70,
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
    );
    TextStyle _scoreTextStyle = TextStyle(
      color: Color(0xffF79400),
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 90.w,
          height: 15.h,
          child: Text(
            value1,
            style: _titleTextStyle,
          ),
        ),
        Container(
          width: 53.w,
          height: 15.h,
          child: Center(
            child: Text(
              value2,
              style: _scoreTextStyle,
            ),
          ),
        ),
        Container(
          width: 53.w,
          height: 15.h,
          child: Center(
            child: Text(
              value3,
              style: _scoreTextStyle,
            ),
          ),
        ),
        Container(
          width: 53.w,
          height: 15.h,
          child: Center(
            child: Text(
              value4,
              style: _scoreTextStyle,
            ),
          ),
        ),
        Container(
          width: 53.w,
          height: 15.h,
          child: Center(
            child: Text(
              value5,
              style: _scoreTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _publikasiScopus() {
    return BlocBuilder<AffiliationsScopusPublicationBloc,
        AffiliationsScopusPublicationState>(
      builder: (context, state) {
        if (state is AffiliationsScopusPublicationLoaded) {
          String formattedTotalItem = state.totalItem.toString() == ""
              ? "0"
              : NumberFormat.currency(locale: 'id', decimalDigits: 0, name: '')
                  .format(state.totalItem.toInt());
          if (state.documents.length == 0) {
            return _itemPublikasiScopusTidakAda();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SubTitleWithArrowLainnya(
                subJudul: 'Publikasi Scopus',
                function: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) =>
                            di.locator<AffiliationsScopusPublicationBloc>()
                              ..add(GetAffiliationsScopusEvent(id: this.id)),
                        child: AffiliationsScopusPublicationPage(id: this.id),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 8.h,
              ),
              _textSpan(formattedTotalItem),
              SizedBox(
                height: 20.h,
              ),
              _buildListView(state.documents)
            ],
          );
        } else if (state is AffiliationsScopusPublicationNotFound) {
          return _itemPublikasiScopusTidakAda();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Publikasi Scopus",
              style: TextStyle(
                color: blue3,
                fontWeight: FontWeight.w700,
                fontSize: 20.sp,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            scopusPublicationSkeleton(),
          ],
        );
      },
    );
  }

  Widget _textSpan(String totalItem) {
    return Text.rich(
      TextSpan(
        text: 'Terdapat ',
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
            text: ' publikasi Scopus',
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

  Widget _buildListView(List<affiliationsScopus.Documents> list) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (BuildContext context, index) {
        return _itemPublikasiScopus(context, list[index]);
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 20.h,
        );
      },
    );
  }

  Widget _itemPublikasiScopusTidakAda() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Publikasi Scopus",
          style: TextStyle(
            color: blue3,
            fontWeight: FontWeight.w700,
            fontSize: 20.sp,
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Container(
          decoration: BoxDecoration(
              color: white, borderRadius: BorderRadius.circular(10.r)),
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/sinta/affiliation_tidak_memiliki_scopus.png",
                width: 140.w,
                height: 120.h,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 30.h),
              Text(
                "Affiliations tidak memiliki publikasi Scopus",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: neutral100,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _itemPublikasiScopus(
      BuildContext context, affiliationsScopus.Documents document) {
    String cited = document.citedbyCount ?? "0";
    TextStyle _textStyle = TextStyle(
      color: neutral50,
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
    );
    return Container(
      decoration: BoxDecoration(
          color: white, borderRadius: BorderRadius.circular(10.r)),
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            document.title ?? "-",
            style: TextStyle(
              color: blue4,
              fontWeight: FontWeight.w700,
              fontSize: 16.sp,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              Image.asset(
                "assets/icons/ic_sharp_loop.png",
                width: 14.w,
                height: 14.w,
              ),
              Text(
                "Q${document.quartile} Journal",
                style: _textStyle.copyWith(
                    color: Color(0xffF79400), fontWeight: FontWeight.w500),
              ),
              SizedBox(
                width: 12.w,
              ),
              Text(
                "${((cited == "") ? "0" : cited)} Cited",
                style: _textStyle.copyWith(color: blue4),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            document.publicationName ?? "-",
            style: _textStyle.copyWith(fontStyle: FontStyle.italic),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            "Creator: ${(document.creator ?? "-")}",
            style: _textStyle.copyWith(fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  Widget _kunjungiWebsite() {
    return BlocBuilder<AffiliationsDetailBloc, AffiliationsDetailState>(
      builder: (context, state) {
        if (state is AffiliationsDetailLoaded) {
          return InkEffect(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShowWebsite(
                      link: state.affiliations.linkProfile ??
                          "https://sinta3.kemdikbud.go.id",
                    ),
                  ));
            },
            boxDecoration: BoxDecoration(
              gradient: sintaKunjungiWebsiteBgGradient,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
              child: Row(
                children: [
                  Image.asset(
                    "assets/sinta/ic_computer.png",
                    width: 64.w,
                    height: 64.w,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Lihat informasi lebih detail",
                          style: TextStyle(
                              color: white,
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Kunjungi website",
                              style: TextStyle(
                                  color: white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Icon(
                              Icons.navigate_next,
                              color: white,
                              size: 15,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return kunjungiWebsiteSkeleton();
      },
    );
  }
}
