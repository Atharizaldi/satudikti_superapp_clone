import 'package:app/common/baseUrl.dart';
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/SkeletonLoading.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/inkEffect.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/component/server_problem.dart';
import 'package:app/presentation/pages/beranda/gmagz/baca_majalah/baca_majalah_gamgz.dart';
import 'package:app/presentation/pages/beranda/gmagz/bloc/detailmajalah/majalah_detail_gmagz_bloc.dart';
import 'package:app/presentation/pages/beranda/sister/component/empty_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class LanjutBacaGMagz extends StatelessWidget {
  late MajalahDetailGMagzBloc _majalahDetailGMagzBloc;
  final int allPage;
  final int nowPage;
  final int lanjutBaca;
  final String imageUrl;
  final String judul;

  LanjutBacaGMagz({
    Key? key,
    required this.allPage,
    required this.nowPage,
    required this.lanjutBaca,
    required this.imageUrl,
    required this.judul,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("INI IMAGE URLNYAA $imageUrl");
    return BlocConsumer<MajalahDetailGMagzBloc, MajalahDetailGMagzState>(
      builder: (context, state) {
        _majalahDetailGMagzBloc =
            BlocProvider.of<MajalahDetailGMagzBloc>(context);
        if (state is MajalahDetailGMagzNoInternetState) {
          return _majalah(context, state);
        } else if (state is MajalahDetailGMagzErrorState) {
          return _majalah(context, state);
        } else if (state is MajalahDetailGMagzLoadedState) {
          return _majalah(context, state);
        } else {
          return _majalah(context, state);
        }
      },
      listener: (context, state) {
        if (state is MajalahDetailGMagzNoInternetState) {
          ScaffoldMessenger.of(context).showSnackBar(noInternet);
        }
      },
    );
  }

  Widget _majalah(BuildContext context, MajalahDetailGMagzState state) {
    late double persen;
    persen = nowPage / allPage;
    if (state is MajalahDetailGMagzinInitial) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: SkeletonLoading(
          height: 160.h,
          width: double.infinity,
          cornerRadius: 8.r,
        ),
      );
    } else if (state is MajalahDetailLoading) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: SkeletonLoading(
          height: 160.h,
          width: double.infinity,
          cornerRadius: 8.r,
        ),
      );
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
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SkeletonLoading(
            height: 160.h,
            width: double.infinity,
            cornerRadius: 8.r,
          ),
        );
      } else {
        return Wrap(
          children: [
            Container(
              // margin: EdgeInsets.only(top: 50.w),
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r)),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4.r),
                    child: Image.network(
                      '$urlAPI$imageUrl',
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return SkeletonLoading(width: 104.w, height: 160.w);
                      },
                      width: 104.w,
                      height: 160.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  // Text("data")
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(judul,
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Plus Jakarta Sans',
                                color: Color.fromRGBO(52, 52, 52, 1))),
                        Text(
                          "Halaman $nowPage per $allPage",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Plus Jakarta Sans',
                              color: Color.fromRGBO(128, 128, 128, 1)),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 18.h),
                          child: Row(
                            children: [
                              LinearPercentIndicator(
                                padding: EdgeInsets.zero,
                                barRadius: Radius.circular(8.r),
                                width: 140.w,
                                lineHeight: 8.h,
                                percent: persen,
                                backgroundColor:
                                    Color.fromRGBO(240, 249, 255, 1),
                                progressColor: Color.fromRGBO(36, 141, 218, 1),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                (persen * 100).toStringAsFixed(2).toString() +
                                    " %",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Inter',
                                    color: Color.fromRGBO(52, 64, 84, 1)),
                              ),
                            ],
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: InkEffect(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                            create: (context) => di.locator<
                                                MajalahDetailGMagzBloc>()
                                              ..add(GetMajalahDetailGMagzEvent(
                                                  id: state.dataMajalah
                                                      .detailBook.idBook)),
                                            child: BacaMajalahGMagz(
                                                islanjutBaca: true,
                                                gambar: state
                                                    .dataMajalah
                                                    .detailBook
                                                    .uriFileCover
                                                    .filePath,
                                                lanjutBaca: lanjutBaca,
                                                id: state.dataMajalah.detailBook
                                                    .idBook,
                                                judul: state.dataMajalah
                                                    .detailBook.judul,
                                                url: state
                                                    .dataMajalah
                                                    .detailBook
                                                    .uriFileMajalah
                                                    .filePath),
                                          )));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 30.w),
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(36, 141, 218, 1),
                                  borderRadius: BorderRadius.circular(8.r)),
                              child: Text("Lanjutkan Membaca",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Plus Jakarta Sans",
                                      color: Colors.white)),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
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
