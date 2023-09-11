import 'package:app/common/baseUrl.dart';
import 'package:app/common/launchUrl.dart';
import 'package:app/common/regex.dart';
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/inkEffect.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/component/server_problem.dart';
import 'package:app/presentation/pages/beranda/gmagz/baca_majalah/baca_majalah_gamgz.dart';
import 'package:app/presentation/pages/beranda/gmagz/bloc/detailmajalah/majalah_detail_gmagz_bloc.dart';
import 'package:app/presentation/pages/beranda/gmagz/component/comment_review.dart';
import 'package:app/presentation/pages/beranda/gmagz/component/magazine_image_view.dart';
import 'package:app/presentation/pages/beranda/gmagz/component/rating_review_gmagz.dart';
import 'package:app/presentation/pages/beranda/gmagz/component/skeleton_loading_detail_majalah_gmagz.dart';
import 'package:app/presentation/pages/beranda/sister/component/empty_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailMagPage extends StatelessWidget {
  late MajalahDetailGMagzBloc _majalahDetailGMagzBloc;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MajalahDetailGMagzBloc, MajalahDetailGMagzState>(
      builder: (context, state) {
        _majalahDetailGMagzBloc =
            BlocProvider.of<MajalahDetailGMagzBloc>(context);
        if (state is MajalahDetailGMagzNoInternetState) {
          return _majalahDetail(context, state);
        } else if (state is MajalahDetailGMagzErrorState) {
          return _majalahDetail(context, state);
        } else if (state is MajalahDetailGMagzLoadedState) {
          return _majalahDetail(context, state);
        } else {
          return _majalahDetail(context, state);
        }
      },
      listener: (context, state) {
        if (state is MajalahDetailGMagzNoInternetState) {
          ScaffoldMessenger.of(context).showSnackBar(noInternet);
        }
      },
    );
    // return _majalahDetail();
  }

  Widget _majalahDetail(BuildContext context, MajalahDetailGMagzState state) {
    return Scaffold(
      backgroundColor: whiteBgPage,
      appBar: CustomAppBar(
        actions: [
          state is MajalahDetailGMagzLoadedState
              ? GestureDetector(
                  onTap: () async {
                    await Share.share("" +
                        state.dataMajalah.detailBook.judul +
                        "" +
                        "\n\n" +
                        "Baca Selengkapnya: \n" +
                        // "https://shopee.co.id/product/326487418/5358717104?d_id=b2bae&utm_content=3EpKSwcQnrv5HCE8MgSnoqFHF3SX" +
                        // "$urlAPI/v2/gmagz/books/file/BULETIN-PUSDIKLAT-I-ilovepdf-compressed%20(2).pdf" +
                        "$urlAPI${state.dataMajalah.detailBook.uriFileMajalah.filePath}" +
                        "\n\nDownload aplikasi SatuDikti sekarang, dan dapatkan informasi terkini seputar Pendidikan Tinggi: \nPlaystore s.id/satudikti-android\nAppstore s.id/satudikti-ios");
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 16.w),
                    child: ImageIcon(
                      AssetImage("assets/icons/share.png"),
                      size: 20.sp,
                    ),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: ImageIcon(
                    AssetImage("assets/icons/share.png"),
                    size: 20.sp,
                  ),
                ),
        ],
        title: "Detail Majalah",
      ),
      body: _body(context, state),
      bottomNavigationBar: Container(
          decoration: BoxDecoration(color: white, boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              blurRadius: 25,
              spreadRadius: 0,
              offset: Offset(0, 6),
            )
          ]),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 25.h),
            height: 110.h,
            child: Center(
              child: state is MajalahDetailGMagzLoadedState
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 50.w,
                          height: 50.h,
                          alignment: Alignment.topCenter,
                          margin: EdgeInsets.fromLTRB(0, 0, 4.w, 16.h),
                          child: IconButton(
                            onPressed: () async {
                              _majalahDetailGMagzBloc.add(PutGMagzDownloader(
                                  id: state.dataMajalah.detailBook.idBook));
                              String url =
                                  "$urlAPI${state.dataMajalah.detailBook.uriFileMajalah.filePath}";
                              // 'https://dev.welove.web.id/public/android/Bumeeco.apk';
                              if (await canLaunchUrl(Uri.parse(url))) {
                                launchURL(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                            icon: Icon(Icons.file_download_outlined,
                                color: blue4, size: 35.w),
                          ),
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        InkEffect(
                          borderRadius: 8.r,
                          boxDecoration: BoxDecoration(
                            border: Border.all(color: blue4),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                          create: (context) => di
                                              .locator<MajalahDetailGMagzBloc>()
                                            ..add(GetMajalahDetailGMagzEvent(
                                                id: state.dataMajalah.detailBook
                                                    .idBook)),
                                          child: BacaMajalahGMagz(
                                              gambar: state
                                                  .dataMajalah
                                                  .detailBook
                                                  .uriFileCover
                                                  .filePath,
                                              id: state.dataMajalah.detailBook
                                                  .idBook,
                                              judul: state
                                                  .dataMajalah.detailBook.judul,
                                              url: state.dataMajalah.detailBook
                                                  .uriFileMajalah.filePath),
                                        )));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: blue4,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            width: 298.w,
                            height: 53.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Mulai Membaca',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : null,
            ),
          )),
    );
  }

  Widget _body(BuildContext context, MajalahDetailGMagzState state) {
    final removeTag = RegExp(r'<[^>]*>');
    print("INI STATEEEEEEEEEEEE $state");

    if (state is MajalahDetailGMagzinInitial) {
      return SkeletonLoadingDetailMajalahGMagz();
    } else if (state is MajalahDetailLoading) {
      return SkeletonLoadingDetailMajalahGMagz();
    } else if (state is MajalahDetailGMagzErrorState) {
      return Container(
        color: Colors.transparent,
        height: screenHeight(context) * 0.5,
        child: ServerProblem(
            onPressed: () {
              _majalahDetailGMagzBloc
                  .add(GetMajalahDetailGMagzEvent(id: state.id));
            },
            buttonHide: false),
      );
    } else if (state is MajalahDetailGMagzLoadedState) {
      if (state.dataMajalah.detailBook.idBook.isEmpty) {
        return SkeletonLoadingDetailMajalahGMagz();
      } else {
        return DefaultTabController(
          length: 2,
          child: NestedScrollView(
            physics: NeverScrollableScrollPhysics(),
            headerSliverBuilder: (context, isScolled) {
              return [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                  collapsedHeight: 390.w,
                  // expandedHeight: 900.w,
                  flexibleSpace: RefreshIndicator(
                    onRefresh: () async {
                      _majalahDetailGMagzBloc.add(GetMajalahDetailGMagzEvent(
                          id: state.dataMajalah.detailBook.idBook));
                    },
                    child: ListView(
                      children: [
                        Container(
                          color: whiteBgPage,
                          // height: 306.h,
                          child: Stack(
                            fit: StackFit.loose,
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  width: double.infinity,
                                  height: 196.h,
                                  decoration:
                                      BoxDecoration(gradient: appBarGradient),
                                ),
                              ),
                              Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  Container(
                                    child: DetailMagImageView(
                                      imageURL:
                                          "$urlAPI${state.dataMajalah.detailBook.uriFileCover.filePath}",
                                      // imageURL:
                                      //     "$urlAPI${state.dataMajalah.detailBook.uriFileCover.filePath}",
                                      judulMajalah:
                                          state.dataMajalah.detailBook.judul,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        RatingReviewGMagz(
                            nilaiBaca: state.dataMajalah.detailBook.jumlahBaca,
                            nilaiDownload:
                                state.dataMajalah.detailBook.jumlahUnduh,
                            nilaiRating: state.dataMajalah.detailBook.rating,
                            nilaiReview:
                                state.dataMajalah.detailBook.totalReview),
                      ],
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  delegate: MyDelegate(TabBar(
                    tabs: [
                      Tab(
                        text: "Sinopsis",
                      ),
                      Tab(text: "Review"),
                    ],
                    isScrollable: false,
                    // labelPadding: EdgeInsets.symmetric(horizontal: 25.w),
                    padding:
                        EdgeInsets.symmetric(horizontal: 90.w, vertical: 0.w),
                    unselectedLabelColor: Color.fromRGBO(128, 128, 128, 1),
                    labelColor: Color.fromRGBO(36, 141, 218, 1),
                    labelStyle: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Plus Jakarta Sans"),
                    indicatorColor: Color.fromRGBO(36, 141, 218, 1),
                  )),
                  floating: true,
                  pinned: true,
                )
              ];
            },
            body: TabBarView(
              children: [
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 16.w, right: 16.w, top: 20.w, bottom: 15.h),
                    color: Colors.transparent,
                    child: Text(
                      removeHtmlTags(state.dataMajalah.detailBook.sinopsis),
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.sp,
                          height: 1.5,
                          fontFamily: "Plus Jakarta Sans"),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
                ListView.separated(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.w, horizontal: 20.w),

                  // padding: EdgeInsets.zero,
                  // shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.review.length,
                  // itemCount: widget.listFAQ.data.faq.length,
                  itemBuilder: (context, index) {
                    return CommentReview(
                        date: state.review[index].createDate,
                        detail: state.review[index].comment,
                        name: state.review[index].namaPengguna,
                        star: state.review[index].rating);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 20.h);
                  },
                ),
              ],
            ),
          ),
        );
      }
    } else {
      if (state is MajalahDetailGMagzNoInternetState) {
        return Container(
          color: Colors.transparent,
          height: screenHeight(context) * 0.5,
          child: NoInternet(
              onPressed: () {
                _majalahDetailGMagzBloc
                    .add(GetMajalahDetailGMagzEvent(id: state.id));
              },
              buttonHide: false),
        );
      } else if (state is MajalahDetailGMagzNotFoundState) {
        return EmptyDataPage();
      } else if (state is MajalahDetailGMagzErrorState) {
        return Container(
          color: Colors.transparent,
          height: screenHeight(context) * 0.5,
          child: ServerProblem(
              onPressed: () {
                _majalahDetailGMagzBloc
                    .add(GetMajalahDetailGMagzEvent(id: state.id));
              },
              buttonHide: false),
        );
      } else {
        return Container(
          color: Colors.transparent,
          height: screenHeight(context) * 0.5,
          child: ServerProblem(
              onPressed: () {
                _majalahDetailGMagzBloc.add(
                    GetMajalahDetailGMagzEvent(id: _majalahDetailGMagzBloc.id));
              },
              buttonHide: false),
        );
      }
    }
  }
}

class MyDelegate extends SliverPersistentHeaderDelegate {
  MyDelegate(this.tabBar);

  final TabBar tabBar;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: whiteBgPage,
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
