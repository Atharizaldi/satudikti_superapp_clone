import 'package:app/common/dateFormat.dart';
import 'package:app/common/regex.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/component/server_problem.dart';
import 'package:app/presentation/pages/showWebsite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share/share.dart';

import '../bloc/detail_cerita_km/detail_cerita_km_bloc.dart';

class DetailCKMPage extends StatefulWidget {
  DetailCKMPage({Key? key}) : super(key: key);

  @override
  _DetailCKMPageState createState() => _DetailCKMPageState();
}

class _DetailCKMPageState extends State<DetailCKMPage> {
  late DetailCeritaKMBloc _detailCeritaKMBloc;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DetailCeritaKMBloc, DetailCeritaKMState>(
      builder: (context, state) {
        _detailCeritaKMBloc = BlocProvider.of<DetailCeritaKMBloc>(context);
        if (state is DetailCeritaKMNoInternetState) {
          return _detailCerita(context, state);
        } else if (state is DetailCeritaKMErrorState) {
          return _detailCerita(context, state);
        } else if (state is DetailCeritaKMLoadedState) {
          return _detailCerita(context, state);
        } else {
          return _detailCerita(context, state);
        }
      },
      listener: (context, state) {
        if (state is DetailCeritaKMNoInternetState) {
          ScaffoldMessenger.of(context).showSnackBar(noInternet);
        }
      },
    );
  }

  Widget _detailCerita(BuildContext context, DetailCeritaKMState state) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cerita Kampus Merdeka",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              letterSpacing: -0.2,
              fontSize: 20.sp),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: appBarGradient),
        ),
        backgroundColor: blueLinear1,
        centerTitle: true,
        actions: [
          state is DetailCeritaKMLoadedState
              ? GestureDetector(
                  onTap: () {
                    Share.share("*" +
                        state.dataDetailCerita.judul +
                        "*" +
                        "\n" +
                        "Baca Selengkapnya: " +
                        state.dataDetailCerita.urlCerita +
                        "\n\nDownload aplikasi SatuDikti sekarang, dan dapatkan informasi terkini seputar Pendidikan Tinggi: \nPlaystore s.id/satudikti-android\nAppstore s.id/satudikti-ios");
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 16.w),
                    child: Image.asset(
                      'assets/icons/share.png',
                      scale: 2,
                    ),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: Image.asset(
                    'assets/icons/share.png',
                    scale: 2,
                  ),
                )
        ],
      ),
      body: _body(context, state),
    );
  }

  Widget _body(BuildContext context, DetailCeritaKMState state) {
    print('DETAIL CKM PAGE $state HAS SUMMONED');
    if (state is DetailCeritaKMinInitial) {
      return Center(
        child: CircularProgressIndicator(
          color: blueLinear1,
        ),
      );
    } else if (state is DetailCeritaKMinLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: blueLinear1,
        ),
      );
    } else if (state is DetailCeritaKMErrorState) {
      return Container(
        color: Colors.transparent,
        height: screenHeight(context) * 0.5,
        child: ServerProblem(
          bgColor: whiteBgPage,
          onPressed: () {},
          buttonHide: true,
        ),
      );
    } else if (state is DetailCeritaKMLoadedState) {
      return SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              // height: 280,
              child: Image.network(
                state.dataDetailCerita.fileCover,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stacktrace) {
                  return Image.asset(
                    'assets/km/ckm_placeholder.png',
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.dataDetailCerita.judul,
                    style: TextStyle(
                        color: blue2,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        height: 1.60,
                        letterSpacing: -0.2.sp),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Image.asset(
                        'assets/km/icons/icon_author.png',
                        width: 24.w,
                        height: 24.h,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        state.dataDetailCerita.author,
                        style: TextStyle(
                            color: neutral90,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(width: 12.w),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    FormatDate()
                        .formatDateFormatTime(state.dataDetailCerita.tanggal),
                    style: TextStyle(
                        color: teksAbuCerah4,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 20.h),
                  // Html(
                  //   data: state.dataDetailCerita.isiCerita,
                  //   onLinkTap: (url, _, __, ___) {
                  //     return launchURL(url!);
                  //   },
                  //   style: {
                  //     'p': Style(
                  //         padding: EdgeInsets.zero,
                  //         margin: EdgeInsets.zero,
                  //         color: abu7,
                  //         fontSize: FontSize(14.sp),
                  //         fontWeight: FontWeight.w400,
                  //         textAlign: TextAlign.justify,
                  //         letterSpacing: -0.02.sp),
                  //   },
                  // ),

                  Text(
                    removeHtmlTags(state.dataDetailCerita.isiCerita),
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: abu7,
                      fontSize: 14.sp,
                      letterSpacing: -0.02.sp,
                      height: 2,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  // lihatArtikelAsli(context, state.dataDetailCerita.urlCerita),
                  InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShowWebsite(
                          link: state.dataDetailCerita.urlCerita,
                        ),
                      ),
                    ),
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'Sumber: ${state.dataDetailCerita.urlCerita}',
                          style: TextStyle(
                              color: neutral80,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.5.sp),
                        ),
                        TextSpan(
                          text: '',
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: blue5,
                              decoration: TextDecoration.underline,
                              height: 1.3,
                              letterSpacing: -0.5.sp),
                        )
                      ]),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Row(children: [
                    Image.asset(
                      'assets/km/icons/icon_like.png',
                      width: 24.w,
                      height: 24.h,
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      state.dataDetailCerita.nLikes.toString(),
                      style: TextStyle(
                          color: neutral70,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 30.w),
                    Row(
                      children: [
                        Image.asset(
                          'assets/km/icons/icon_comment.png',
                          width: 24.w,
                          height: 24.h,
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          state.dataDetailCerita.nComment.toString(),
                          style: TextStyle(
                              color: neutral70,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ]),
                  SizedBox(height: 50.h),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      if (state is DetailCeritaKMNoInternetState) {
        return Center(
          child: Container(
            color: Colors.transparent,
            height: screenHeight(context) * 0.5,
            child: NoInternet(
              onPressed: () {
                _detailCeritaKMBloc.add(GetDetailCeritaKMEvent(id: state.id));
              },
              buttonHide: false,
            ),
          ),
        );
      } else {
        return Container(
          color: Colors.transparent,
          height: screenHeight(context) * 0.5,
          child: ServerProblem(
            bgColor: whiteBgPage,
            onPressed: () {},
            buttonHide: false,
          ),
        );
      }
    }
  }
}
