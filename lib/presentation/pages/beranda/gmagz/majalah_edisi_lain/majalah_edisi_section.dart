import 'package:app/common/baseUrl.dart';
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/component/server_problem.dart';
import 'package:app/presentation/component/sub_title_with_arrow_lainnya.dart';
import 'package:app/presentation/pages/beranda/gmagz/bloc/detailmajalah/majalah_detail_gmagz_bloc.dart';
import 'package:app/presentation/pages/beranda/gmagz/bloc/majalah/majalah_gmagz_bloc.dart';
import 'package:app/presentation/pages/beranda/gmagz/component/home_majalah_card.dart';
import 'package:app/presentation/pages/beranda/gmagz/component/skeleton_loading_home.dart';
import 'package:app/presentation/pages/beranda/gmagz/detailPage/detail_page.dart';
import 'package:app/presentation/pages/beranda/gmagz/majalah_edisi_lain/majalah_edisi.dart';
import 'package:app/presentation/pages/beranda/sister/component/empty_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MajalahEdisiSection extends StatefulWidget {
  const MajalahEdisiSection({Key? key}) : super(key: key);

  @override
  State<MajalahEdisiSection> createState() => _MajalahEdisiSectionState();
}

class _MajalahEdisiSectionState extends State<MajalahEdisiSection> {
  late MajalahGMagzBloc _majalahGMagzBloc;
  double? scaleSize = 0.8;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MajalahGMagzBloc, MajalahGMagzState>(
      builder: (context, state) {
        _majalahGMagzBloc = BlocProvider.of<MajalahGMagzBloc>(context);

        if (state is MajalahGMagzNoInternetState) {
          return _majalah(context, state);
        } else if (state is MajalahGMagzErrorState) {
          return _majalah(context, state);
        } else if (state is MajalahGMagzLoadedState) {
          return _majalah(context, state);
        } else {
          return _majalah(context, state);
        }
      },
      listener: (context, state) {
        if (state is MajalahGMagzNoInternetState) {
          ScaffoldMessenger.of(context).showSnackBar(noInternet);
        }
      },
    );
    // return _majalah();
  }

  Widget _majalah(BuildContext context, MajalahGMagzState state) {
    if (state is MajalahGMagzinInitial) {
      return SkeletonLoadingHomeGmagz();
    } else if (state is MajalahGMagzLoading) {
      return SkeletonLoadingHomeGmagz();
    } else if (state is MajalahGMagzLoadedState) {
      if (state.listBook.isEmpty) {
        return SkeletonLoadingHomeGmagz();
      } else {
        print("$urlAPI${state.listBook[0].uriCover.filePath}  INIURINYA");
        return Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w),
                child: SubTitleWithArrowLainnya(
                  subJudul: 'Majalah Edisi Lain',
                  function: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                  create: (context) =>
                                      di.locator<MajalahGMagzBloc>()
                                        ..add(GetMajalahGMagzEvent(
                                            sort: "false",
                                            judul: "",
                                            displayby: "")),
                                  child: MajalahEdisiPage(),
                                )));
                  },
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (int i = 0; i < 5; i++)
                      SizedBox(
                        width: 160.w,
                        height: 425.h,
                        child: MajalahCard(
                          image:
                              "$urlAPI${state.listBook[i].uriCover.filePath}",
                          title: state.listBook[i].judul,
                          date: state.listBook[i].tahun != 0
                              ? state.listBook[i].tahun.toString()
                              : '-',
                          rating: state.listBook[i].rating,
                          press: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                          create: (context) => di
                                              .locator<MajalahDetailGMagzBloc>()
                                            ..add(GetMajalahDetailGMagzEvent(
                                                id: state.listBook[i].idBook)),
                                          child: DetailMagPage(),
                                        )));
                          },
                          scaleSize: scaleSize,
                        ),
                      ),
                  ],
                ),
              )
            ],
          ),
        );
      }
    } else {
      if (state is MajalahGMagzNoInternetState) {
        return Container(
          color: Colors.transparent,
          height: screenHeight(context) * 0.5,
          child: NoInternet(
              onPressed: () {
                _majalahGMagzBloc.add(GetMajalahGMagzEvent(
                    sort: "false", judul: "", displayby: ""));
              },
              buttonHide: false),
        );
      } else if (state is MajalahGMagzNotFoundState) {
        return EmptyDataPage();
      } else if (state is MajalahGMagzErrorState) {
        return Container(
          color: Colors.transparent,
          height: screenHeight(context) * 0.5,
          child: ServerProblem(
              onPressed: () {
                _majalahGMagzBloc.add(GetMajalahGMagzEvent(
                    sort: "false", judul: "", displayby: ""));
              },
              buttonHide: false),
        );
      } else {
        return Container(
          color: Colors.transparent,
          height: screenHeight(context) * 0.5,
          child: ServerProblem(
              onPressed: () {
                _majalahGMagzBloc.add(GetMajalahGMagzEvent(
                    sort: "false", judul: "", displayby: ""));
              },
              buttonHide: false),
        );
      }
    }
  }
}
