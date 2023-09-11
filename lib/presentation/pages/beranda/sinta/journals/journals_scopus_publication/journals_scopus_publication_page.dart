import 'package:app/data/source/remote/model/sinta/journals/JournalsScholar.dart'
as journalsScholar;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/pages/beranda/sinta/journals/detail/bloc/journals_scopus_publication_bloc.dart';
import 'package:app/presentation/pages/beranda/sinta/sinta_journals_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JournalsScopusPublicationPage extends StatefulWidget {
  final String id;

  const JournalsScopusPublicationPage({Key? key, required this.id})
      : super(key: key);

  @override
  State<JournalsScopusPublicationPage> createState() =>
      _JournalsScopusPublicationPageState();
}

class _JournalsScopusPublicationPageState
    extends State<JournalsScopusPublicationPage> {
  ScrollController _scrollController = new ScrollController();
  late JournalsScopusPublicationBloc _journalssScopusPublicationBloc;

  void onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;

    if (currentScroll == maxScroll) {
      _journalssScopusPublicationBloc
          .add(GetJournalsScopusEvent(id: widget.id));
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    _journalssScopusPublicationBloc =
        BlocProvider.of<JournalsScopusPublicationBloc>(context);
    _scrollController.addListener(onScroll);
    return Scaffold(
      backgroundColor: whiteBgPage,
      appBar: CustomAppBar(title: 'Publikasi Scopus'),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          child: BlocBuilder<JournalsScopusPublicationBloc,
              JournalsScopusPublicationState>(
            builder: (context, state) {
              if (state is JournalsScopusPublicationLoaded) {
                if (state.list.length == 0) {
                  return _itemPublikasiScopusTidakAda();
                }
                return _buildListView(state.list, state.hasReachedMax);
              } else if (state is JournalsScopusPublicationNotFound) {
                return _itemPublikasiScopusTidakAda();
              }
              return journalsPublicationSkeleton();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildListView(List<journalsScholar.Google> list, bool hasReachedMax) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: (hasReachedMax) ? list.length : list.length + 1,
      itemBuilder: (BuildContext context, index) {
        if (index < list.length) {
          return _itemPublikasiScopus(list[index]);
        } else {
          return itemPublikasiSkeleton();
        }
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
