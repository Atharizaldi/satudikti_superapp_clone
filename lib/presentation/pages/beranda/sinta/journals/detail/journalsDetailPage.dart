import 'package:app/data/source/remote/model/sinta/journals/JournalsDetail.dart';
import 'package:app/data/source/remote/model/sinta/journals/JournalsScholar.dart'
    as journalsScholar;
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/sub_title_with_arrow_lainnya.dart';
import 'package:app/presentation/pages/beranda/sinta/journals/detail/bloc/journals_detail_bloc.dart';
import 'package:app/presentation/pages/beranda/sinta/journals/detail/bloc/journals_scopus_publication_bloc.dart';
import 'package:app/presentation/pages/beranda/sinta/journals/journals_scopus_publication/journals_scopus_publication_page.dart';
import 'package:app/presentation/pages/beranda/sinta/sinta_journals_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class JournalsDetailPage extends StatelessWidget {
  final String id;

  JournalsDetailPage({required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBgPage,
      appBar: CustomAppBar(title: 'Journal'),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30.h,
              ),
              _header(),
              SizedBox(
                height: 30.h,
              ),
              _publikasiScopus(),
              SizedBox(
                height: 30.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    TextStyle _textStyle = TextStyle(
        color: neutral30, fontWeight: FontWeight.w400, fontSize: 12.sp);
    return BlocBuilder<JournalsDetailBloc, JournalsDetailState>(
      builder: (context, state) {
        if (state is JournalsDetailLoaded) {
          Journal journal = state.journal;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/sinta/journal.png",
                  width: 120.w,
                  height: 155.h,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              SelectableText(
                journal.title ?? "-",
                style: TextStyle(
                    color: blue2, fontWeight: FontWeight.w700, fontSize: 24.sp),
              ),
              SizedBox(
                height: 20.h,
              ),
              SelectableText(
                "Published By: ${journal.publisher}",
                style: _textStyle.copyWith(fontSize: 14.sp, color: neutral50),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SelectableText(
                      "P-ISSN: ${journal.pissn}",
                      style: _textStyle,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: SelectableText(
                      "E-ISSN: ${journal.eissn}",
                      style: _textStyle,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Subject Area: ${(journal.subjects?.isNotEmpty == true) ? journal.subjects?.first : "-"}",
                style: _textStyle.copyWith(fontStyle: FontStyle.italic),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _itemRank("Impact Factor", journal.impact3y ?? "-",
                      Color(0xff1A689E)),
                  SizedBox(
                    width: 20.w,
                  ),
                  _itemRank("Accreditation", "S${journal.accreditation}",
                      _accreditationColor(journal.accreditation))
                ],
              ),
            ],
          );
        }
        return headerJournalsSkeleton();
      },
    );
  }

  Color _accreditationColor(String? accreditation) {
    if (accreditation == "1") {
      return Color(0xff5FD3D4);
    } else if (accreditation == "2") {
      return Color(0xffB6A2DE);
    } else if (accreditation == "3") {
      return Color(0xff5AB1EF);
    } else if (accreditation == "4") {
      return Color(0xffFFB980);
    } else if (accreditation == "5") {
      return Color(0xffD87A80);
    } else if (accreditation == "6") {
      return Color(0xff8D98B3);
    }
    return Color(0xff8D98B3);
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

  Widget _publikasiScopus() {
    return BlocBuilder<JournalsScopusPublicationBloc,
        JournalsScopusPublicationState>(
      builder: (context, state) {
        if (state is JournalsScopusPublicationLoaded) {
          String formattedTotalItem = state.totalItem.toString() == ""
              ? "0"
              : NumberFormat.currency(locale: 'id', decimalDigits: 0, name: '')
                  .format(state.totalItem.toInt());
          if (state.list.length == 0) {
            return _itemPublikasiScopusTidakAda();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SubTitleWithArrowLainnya(
                subJudul: 'Kumpulan Publikasi yang Diterbitkan',
                function: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) =>
                            di.locator<JournalsScopusPublicationBloc>()
                              ..add(GetJournalsScopusEvent(id: this.id)),
                        child: JournalsScopusPublicationPage(id: this.id),
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
              _buildListView(state.list)
            ],
          );
        } else if (state is JournalsScopusPublicationNotFound) {
          return _itemPublikasiScopusTidakAda();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Kumpulan Publikasi yang Diterbitkan",
              style: TextStyle(
                color: blue3,
                fontWeight: FontWeight.w700,
                fontSize: 20.sp,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            journalsPublicationSkeleton(),
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

  Widget _buildListView(List<journalsScholar.Google> list) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (BuildContext context, index) {
        return _itemPublikasiScopus(list[index]);
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 20.h,
        );
      },
    );
  }

  Widget _itemPublikasiScopus(journalsScholar.Google scholar) {
    String cited = scholar.citation ?? "0";
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
            "${scholar.title}",
            style: TextStyle(
              color: blue4,
              fontWeight: FontWeight.w700,
              fontSize: 16.sp,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 15.h,
          ),
          Text(
            scholar.journalName ?? "-",
            style: _textStyle.copyWith(fontStyle: FontStyle.italic),
          ),
          SizedBox(
            height: 15.h,
          ),
          Text(
            "Authors: ${(scholar.author ?? "-")}",
            style: _textStyle.copyWith(
              fontStyle: FontStyle.italic,
              color: neutral30,
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Row(
            children: [
              Image.asset(
                "assets/icons/calendar.png",
                width: 14.w,
                height: 14.w,
              ),
              SizedBox(
                width: 4.w,
              ),
              Text(
                scholar.publishYear ?? "-",
                style: _textStyle.copyWith(
                  color: neutral30,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                width: 30.w,
              ),
              Image.asset(
                "assets/icons/ic_sharp_loop.png",
                width: 14.w,
                height: 14.w,
              ),
              Text(
                "S${scholar.accreditation} Journal",
                style: _textStyle.copyWith(
                    color: Color(0xffF79400), fontWeight: FontWeight.w500),
              ),
              SizedBox(
                width: 30.w,
              ),
              Text(
                "${((cited == "") ? "0" : cited)} Cited",
                style: _textStyle.copyWith(color: blue4),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _itemPublikasiScopusTidakAda() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Kumpulan Publikasi yang Diterbitkan",
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
                "Journal tidak memiliki publikasi Scopus",
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
}
