import 'dart:math';

import 'package:app/common/dateFormat.dart';
import 'package:app/common/launchUrl.dart';
import 'package:app/data/source/remote/model/berita/newsDetail.dart';
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/pages/beranda/berita/bloc/berita_bloc.dart';
import 'package:app/presentation/pages/beranda/berita/component/newBeritaListStyleCard.dart';
import 'package:app/presentation/pages/beranda/beritaDanPengumumanDetail/beritaDanPengumumanSubPage.dart';
import 'package:app/presentation/pages/beranda/beritaDanPengumumanDetail/component/bannerImage.dart';
import 'package:app/presentation/pages/beranda/beritaDanPengumumanDetail/component/lihatArtikelAsli.dart';
import 'package:app/presentation/pages/beranda/beritaDanPengumumanDetail/component/newBeritadanPengumumanFooter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:share/share.dart';

Widget beritaDetail(BuildContext context, NewsDetail newsDetail,
    FormatDate formatDate, int newsId) {
  return BlocProvider(
      create: (context) =>
          di.locator<BeritaBloc>()..add(GetBeritaEvent(category: "1")),
      child: Builder(builder: (context) {
        return Scaffold(
            appBar: AppBar(
              title: Text(
                "Detail Berita",
                style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 1),
              ),
              flexibleSpace: Container(
                decoration: BoxDecoration(gradient: appBarGradient),
              ),
              backgroundColor: blueLinear1,
              centerTitle: true,
              actions: [
                GestureDetector(
                  onTap: () {
                    Share.share("*" +
                        newsDetail.title +
                        "*" +
                        "\n" +
                        "Baca Selengkapnya: " +
                        newsDetail.link +
                        "\n\nDownload aplikasi SatuDikti sekarang, dan dapatkan informasi terkini seputar Pendidikan Tinggi: \nPlaystore s.id/satudikti-android\nAppstore s.id/satudikti-ios");
                  },
                  child: Image.asset(
                    'assets/icons/share.png',
                    scale: 2,
                  ),
                )
              ],
            ),
            body: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 271.h,
                    child: bannerImage("", newsDetail, null),
                  ),
                  SizedBox(height: 36.h),
                  Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          newsDetail.title,
                          style: TextStyle(
                            color: blue2,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                            height: 1.65,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          children: [
                            Text(
                              newsDetail.creator,
                              style: TextStyle(
                                  color: teksAbuCerah4,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(width: 8.w),
                            Image.asset("assets/icons/ellipse.png"),
                            SizedBox(width: 8.w),
                            Text(
                                formatDate.formatDate(newsDetail.publisherDate),
                                style: TextStyle(
                                    color: teksAbuCerah4,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400))
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 10.w, right: 16.w, top: 14.w),
                    child: Html(
                      data: newsDetail.content,
                      onLinkTap: (url, _, __, ___) {
                        return launchURL(url!);
                      },
                      style: {
                        "p": Style(
                            color: abu7,
                            fontWeight: FontWeight.w400,
                            fontSize: FontSize.percent(120),
                            lineHeight: LineHeight.percent(150)),
                        // "video":
                      },
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Padding(
                    padding: EdgeInsets.only(left: 16.w),
                    child: lihatArtikelAsli(context, newsDetail.link),
                  ),
                  SizedBox(height: 40.h),
                  BlocBuilder<BeritaBloc, BeritaState>(
                      builder: (context, state) {
                    if (state is BeritaLoadingState) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: blueLinear1,
                        ),
                      );
                    } else if (state is BeritaNoInternetState) {
                      return NoInternet(
                        onPressed: () {
                          // _beritaBloc
                          //     .add(GetBeritaEvent(category: "1"));
                        },
                        buttonHide: false,
                      );
                    } else if (state is BeritaErrorState) {
                      return SizedBox();
                    } else if (state is BeritaLoadedState) {
                      if (state.newsList.length == 0) {
                        return SizedBox();
                      } else {
                        Logger().i(newsId);
                        Logger().i(state.newsList.length);

                        //Added id check on news recommendation so
                        //the currently opened news doesn't show up
                        List<int> numberList = [];
                        while (numberList.length < 3) {
                          int randomNumber = Random().nextInt(10);
                          if (state.newsList[randomNumber].newsId != newsId &&
                              !numberList.contains(randomNumber)) {
                            numberList.add(randomNumber);
                          }
                        }
                        Logger().i(numberList);

                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                "Berita Lainnya",
                                style: TextStyle(
                                    color: blue3,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              SizedBox(
                                height: 32.h,
                              ),
                              NewBeritaListStyleCard(
                                function: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BeritaDanPengumumanSubPage(
                                                category: '',
                                                id: state
                                                    .newsList[numberList[0]]
                                                    .newsId),
                                      ));
                                },
                                image: (state.newsList[numberList[0]]
                                                .thumbnailImage ==
                                            "" ||
                                        state.newsList[numberList[0]]
                                                .thumbnailImage ==
                                            'null')
                                    ? 'assets/default-con/berita.png'
                                    : state
                                        .newsList[numberList[0]].thumbnailImage,
                                judul: state.newsList[numberList[0]].title,
                                tanggal:
                                    state.newsList[numberList[0]].publisherDate,
                                kategori: '',
                              ),
                              SizedBox(
                                height: 27.h,
                              ),
                              NewBeritaListStyleCard(
                                function: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BeritaDanPengumumanSubPage(
                                                category: '',
                                                id: state
                                                    .newsList[numberList[1]]
                                                    .newsId),
                                      ));
                                },
                                image: (state.newsList[numberList[1]]
                                                .thumbnailImage ==
                                            "" ||
                                        state.newsList[numberList[1]]
                                                .thumbnailImage ==
                                            'null')
                                    ? 'assets/default-con/berita.png'
                                    : state
                                        .newsList[numberList[1]].thumbnailImage,
                                judul: state.newsList[numberList[1]].title,
                                tanggal:
                                    state.newsList[numberList[1]].publisherDate,
                                kategori: '',
                              ),
                              SizedBox(
                                height: 27.h,
                              ),
                              NewBeritaListStyleCard(
                                function: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BeritaDanPengumumanSubPage(
                                                category: '',
                                                id: state
                                                    .newsList[numberList[2]]
                                                    .newsId),
                                      ));
                                },
                                image: (state.newsList[numberList[2]]
                                                .thumbnailImage ==
                                            "" ||
                                        state.newsList[numberList[2]]
                                                .thumbnailImage ==
                                            'null')
                                    ? 'assets/default-con/berita.png'
                                    : state
                                        .newsList[numberList[2]].thumbnailImage,
                                judul: state.newsList[numberList[2]].title,
                                tanggal:
                                    state.newsList[numberList[2]].publisherDate,
                                kategori: '',
                              ),
                              SizedBox(
                                height: 60.h,
                              ),
                            ],
                          ),
                        );
                        // return buildNewsList(state.newsList,
                        //     state.hasReachedMax, _scrollController);
                      }
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          color: blueLinear1,
                        ),
                      );
                    }
                  }),
                  newBeritaDanPengumumanFooter()
                ],
              ),
            ));
      }));

  // return Scaffold(
  //     appBar: AppBar(
  //       title: Text(
  //         "Berita",
  //         style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 1),
  //       ),
  //       flexibleSpace: Container(
  //         decoration: BoxDecoration(gradient: appBarGradient),
  //       ),
  //       backgroundColor: blueLinear1,
  //       centerTitle: true,
  //       actions: [
  //         GestureDetector(
  //           onTap: () {
  //             Share.share(newsDetail.link);
  //           },
  //           child: Image.asset(
  //             'assets/icons/share.png',
  //             scale: 2,
  //           ),
  //         )
  //       ],
  //     ),
  //     body: SingleChildScrollView(
  //       physics: ClampingScrollPhysics(),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Container(
  //             width: double.infinity,
  //             height: 271.h,
  //             child: bannerImage("", newsDetail, null),
  //           ),
  //           SizedBox(height: 30.h),
  //           Padding(
  //             padding: EdgeInsets.only(left: 16.w, right: 16.w),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   newsDetail.title,
  //                   style: TextStyle(
  //                       color: blue2,
  //                       fontSize: 24.sp,
  //                       fontWeight: FontWeight.w700,),
  //                 ),
  //                 SizedBox(height: 20.h),
  //                 Row(
  //                   children: [
  //                     Text(
  //                       newsDetail.creator,
  //                       style: TextStyle(
  //                           color: teksAbuCerah4,
  //                           fontSize: 12.sp,
  //                           fontWeight: FontWeight.w400),
  //                     ),
  //                     SizedBox(width: 8.w),
  //                     Image.asset("assets/icons/ellipse.png"),
  //                     SizedBox(width: 8.w),
  //                     Text(formatDate.formatDate(newsDetail.publisherDate),
  //                         style: TextStyle(
  //                             color: teksAbuCerah4,
  //                             fontSize: 12.sp,
  //                             fontWeight: FontWeight.w400))
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //           Padding(
  //             padding: EdgeInsets.only(left: 16.w, right: 16.w),
  //             child: Html(
  //               data: newsDetail.content,
  //               onLinkTap: (url, _, __, ___) {
  //                 return launchURL(url!);
  //               },
  //               style: {
  //                 "p": Style(
  //                     color: abu7,
  //                     fontWeight: FontWeight.w400,
  //                     fontSize: FontSize.percent(120),
  //                     lineHeight: LineHeight.percent(150)),
  //                 // "video":
  //               },
  //             ),
  //           ),
  //           SizedBox(height: 30.h),
  //           Padding(
  //             padding: EdgeInsets.only(left: 16.w),
  //             child: lihatArtikelAsli(context, newsDetail.link),
  //           ),
  //           SizedBox(height: 45.h),
  //           newBeritaDanPengumumanFooter()
  //         ],
  //       ),
  //     ));
}
