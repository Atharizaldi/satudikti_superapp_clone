import 'package:app/data/source/remote/model/sinta/affiliations/AffiliationsScopus.dart'
    as affiliationsScopus;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/pages/beranda/sinta/affiliations/affiliations_detail/bloc/affiliations_scopus_publication_bloc.dart';
import 'package:app/presentation/pages/beranda/sinta/sinta_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AffiliationsScopusPublicationPage extends StatefulWidget {
  final String id;

  const AffiliationsScopusPublicationPage({Key? key, required this.id})
      : super(key: key);

  @override
  State<AffiliationsScopusPublicationPage> createState() =>
      _AffiliationsScopusPublicationPageState();
}

class _AffiliationsScopusPublicationPageState
    extends State<AffiliationsScopusPublicationPage> {
  ScrollController _scrollController = new ScrollController();
  late AffiliationsScopusPublicationBloc _affiliationsScopusPublicationBloc;

  void onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;

    if (currentScroll == maxScroll) {
      _affiliationsScopusPublicationBloc
          .add(GetAffiliationsScopusEvent(id: widget.id));
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _affiliationsScopusPublicationBloc =
        BlocProvider.of<AffiliationsScopusPublicationBloc>(context);
    _scrollController.addListener(onScroll);
    return Scaffold(
      backgroundColor: whiteBgPage,
      appBar: CustomAppBar(title: 'Publikasi Scopus'),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          child: BlocBuilder<AffiliationsScopusPublicationBloc,
              AffiliationsScopusPublicationState>(
            builder: (context, state) {
              if (state is AffiliationsScopusPublicationLoaded) {
                if (state.documents.length == 0) {
                  return _itemPublikasiScopusTidakAda();
                }
                return _buildListView(state.documents, state.hasReachedMax);
              } else if (state is AffiliationsScopusPublicationNotFound) {
                return _itemPublikasiScopusTidakAda();
              }
              return scopusPublicationSkeleton();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildListView(List<affiliationsScopus.Documents> list, bool hasReachedMax) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: (hasReachedMax) ? list.length : list.length + 1,
      itemBuilder: (BuildContext context, index) {
        if (index < list.length) {
          return _itemPublikasiScopus(list[index]);
        } else {
          return itemPublikasiScopusSkeleton();
        }
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 20.h,
        );
      },
    );
  }

  Widget _itemPublikasiScopus(affiliationsScopus.Documents document) {
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
                "assets/sinta/author_tidak_memiliki_scopus.png",
                width: 140.w,
                height: 120.h,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 30.h),
              Text(
                "Author tidak memiliki publikasi Scopus",
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
