import 'dart:math';

import 'package:app/common/dateFormat.dart';
import 'package:app/common/launchUrl.dart';
import 'package:app/data/source/remote/model/pengumuman/pengumumanDetail.dart';
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/pages/beranda/beritaDanPengumumanDetail/component/bannerImage.dart';
import 'package:app/presentation/pages/beranda/beritaDanPengumumanDetail/component/lihatArtikelAsli.dart';
import 'package:app/presentation/pages/beranda/beritaDanPengumumanDetail/component/newBeritadanPengumumanFooter.dart';
import 'package:app/presentation/pages/beranda/beritaDanPengumumanDetail/detailBloc/berita_pengumuman_detail_bloc.dart';
import 'package:app/presentation/pages/beranda/pengumuman/component/noData.dart';
import 'package:app/presentation/pages/beranda/pengumuman/component/pengumuman_card.dart';
import 'package:app/presentation/pages/beranda/pengumuman/umum/bloc/pengumuman_umum_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:share/share.dart';
import 'package:video_player/video_player.dart';

Logger log = Logger();

class PengumumanDetailPage extends StatefulWidget {
  final PengumumanDetail pengumumanDetail;
  final FormatDate formatDate;
  final String? category;
  final int pengumumanId;

  // final String? unicoderaw;

  const PengumumanDetailPage({
    Key? key,
    required this.pengumumanDetail,
    required this.formatDate,
    required this.pengumumanId,
    this.category,
    // this.unicoderaw
  }) : super(key: key);

  @override
  _PengumumanDetailPageState createState() => _PengumumanDetailPageState();
}

class _PengumumanDetailPageState extends State<PengumumanDetailPage> {
  VideoPlayerController? _controller;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            di.locator<PengumumanUmumBloc>()..add(GetPengumumanEvent()),
        child: Builder(builder: (context) {
          return Scaffold(
              appBar: AppBar(
                title: Text(
                  "Detail Pengumuman",
                  style:
                      TextStyle(fontWeight: FontWeight.w600, letterSpacing: 1),
                ),
                flexibleSpace: Container(
                  decoration: BoxDecoration(gradient: appBarGradient),
                ),
                backgroundColor: blueLinear1,
                centerTitle: true,
                actions: [
                  GestureDetector(
                    onTap: () {
                      Share.share("" +
                          widget.pengumumanDetail.title +
                          "" +
                          "\n\n" +
                          "Baca Selengkapnya: \n" +
                          widget.pengumumanDetail.link +
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 261,
                      child: bannerImage(
                          widget.category, null, widget.pengumumanDetail),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _tag(widget.category!),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            // widget.pengumumanDetail.title,
                            widget.pengumumanDetail.title
                                .replaceAll("&#8217;", "'"),
                            style: TextStyle(
                                color: blue2,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                height: 1.60),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Text(
                                widget.pengumumanDetail.creator,
                                style: TextStyle(
                                    color: teksAbuCerah4,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Image.asset("assets/icons/ellipse.png"),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                  widget.formatDate.formatDate(
                                      widget.pengumumanDetail.publisherDate),
                                  style: TextStyle(
                                      color: teksAbuCerah4,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400))
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    htmlContent(widget.pengumumanDetail.content),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: lihatArtikelAsli(
                          context, widget.pengumumanDetail.link),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    BlocBuilder<PengumumanUmumBloc, PengumumanUmumState>(
                        builder: (context, state) {
                      if (state is PengumumanLoadingState) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: blueLinear1,
                          ),
                        );
                      } else if (state is PengumumanNoInternetState) {
                        return NoInternet(
                          onPressed: () {
                            // _pengumumanUmumBloc.add(GetPengumumanEvent());
                          },
                          buttonHide: false,
                        );
                      } else if (state is PengumumanErrorState) {
                        return noData(context);
                      } else if (state is PengumumanLoadedState) {
                        if (state.pengumumanList.length == 0) {
                          return SizedBox();
                        } else {
                          Logger().i(widget.pengumumanId);
                          Logger().i(state.pengumumanList.length);

                          //Added id check on announcement recommendation so
                          //the currently opened announcement doesn't show up
                          List<int> numberList = [];
                          while (numberList.length < 3) {
                            int randomNumber = Random().nextInt(10);
                            if (state.pengumumanList[randomNumber].id !=
                                    widget.pengumumanId &&
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
                                  "Pengumuman Lainnya",
                                  style: TextStyle(
                                      color: blue3,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                SizedBox(
                                  height: 32.h,
                                ),
                                PengumumanCard(
                                    pengumuman:
                                        state.pengumumanList[numberList[0]],
                                    category: state
                                        .pengumumanList[numberList[0]]
                                        .categories[0]
                                        .categoryId
                                        .toString()),
                                SizedBox(
                                  height: 40.h,
                                ),
                                PengumumanCard(
                                    pengumuman:
                                        state.pengumumanList[numberList[1]],
                                    category: state
                                        .pengumumanList[numberList[1]]
                                        .categories[0]
                                        .categoryId
                                        .toString()),
                                SizedBox(
                                  height: 40.h,
                                ),
                                PengumumanCard(
                                    pengumuman:
                                        state.pengumumanList[numberList[2]],
                                    category: state
                                        .pengumumanList[numberList[2]]
                                        .categories[0]
                                        .categoryId
                                        .toString()),
                                SizedBox(
                                  height: 65.h,
                                ),
                              ],
                            ),
                          );
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
  }

  Widget htmlContent(String content) {
    log.i(content);
    return BlocProvider(
      create: (context) => di.locator<BeritaPengumumanDetailBloc>(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Html(
            data: content,
            onLinkTap: (url, _, __, ___) {
              return launchURL(url!);
            },
            style: {
              "p": Style(
                color: abu7,
                fontWeight: FontWeight.w400,
              ),
            },
            customRender: {
              "video": (RenderContext context, Widget child) {
                final attrs = context.tree.element?.attributes;
                if (attrs == null) {
                  log.i("attrs null");
                  return Container();
                } else {
                  String temp = attrs.values.toString();
                  String videoLink = temp
                      .replaceAll("(", "")
                      .replaceAll(" ", "")
                      .replaceAll(")", "")
                      .replaceAll(",", "");
                  log.i("videoLink: $videoLink");
                  _controller = VideoPlayerController.network('$videoLink')
                    ..initialize();
                  return BlocBuilder<BeritaPengumumanDetailBloc,
                      BeritaPengumumanDetailState>(builder: (context, state) {
                    return GestureDetector(
                        onTap: () {
                          if (state is VideoState) {
                            if (state.isPlaying) {
                              log.i("video paused");
                              _controller?.pause();
                              BlocProvider.of<BeritaPengumumanDetailBloc>(
                                      context)
                                  .add(VideoTapEvent(isPlaying: false));
                            } else {
                              log.i("video play");
                              _controller?.play();
                              BlocProvider.of<BeritaPengumumanDetailBloc>(
                                      context)
                                  .add(VideoTapEvent(isPlaying: true));
                            }
                          }
                        },
                        child: AspectRatio(
                          aspectRatio: _controller?.value.aspectRatio ?? 0,
                          child: VideoPlayer(_controller!),
                        ));
                  });
                }
              }
            }),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  Widget _tag(String kategori) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: blue6,
      ),
      child: Text(
        kategori.toUpperCase(),
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w200,
          letterSpacing: -0.02.sp,
          color: blue2,
        ),
      ),
    );
  }
}
