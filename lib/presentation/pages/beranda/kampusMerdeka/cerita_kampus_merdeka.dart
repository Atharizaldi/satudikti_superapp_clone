import 'package:app/common/dateFormat.dart';
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/kampusMerdeka/bloc/cerita_kampus_merdeka/cerita_kampus_merdeka_bloc.dart';
import 'package:app/presentation/pages/beranda/kampusMerdeka/component/card_CKM_Loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../component/noInternet.dart';
import 'bloc/detail_cerita_km/detail_cerita_km_bloc.dart';
import 'component/card_CKM.dart';
import 'detail_cerita_ckm/detail_cerita.dart';

class CeritaKampusMerdekaSection extends StatefulWidget {
  const CeritaKampusMerdekaSection({Key? key}) : super(key: key);

  @override
  State<CeritaKampusMerdekaSection> createState() =>
      _CeritaKampusMerdekaSectionState();
}

class _CeritaKampusMerdekaSectionState
    extends State<CeritaKampusMerdekaSection> {
  late CeritaKampusMerdekaBloc _ckmBloc;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CeritaKampusMerdekaBloc, CeritaKampusMerdekaState>(
      builder: (context, state) {
        _ckmBloc = BlocProvider.of<CeritaKampusMerdekaBloc>(context);

        if (state is CeritaKMNoInternetState) {
          return _ckm(context, state);
        } else if (state is CeritaKMErrorState) {
          return _ckm(context, state);
        } else if (state is CeritaKMLoadedState) {
          return _ckm(context, state);
        } else {
          return _ckm(context, state);
        }
      },
      listener: (context, state) {
        if (state is CeritaKMNoInternetState) {
          ScaffoldMessenger.of(context).showSnackBar(noInternet);
        }
      },
    );
  }

  Widget _ckm(BuildContext context, CeritaKampusMerdekaState state) {
    if (state is CeritaKMLoadingState) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SkeletonLoadingCKM(),
      );
    } else if (state is CeritaKMLoadedState) {
      return Column(
        children: [
          Container(
            child: ListView.separated(
              shrinkWrap: true,
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                // print(
                //     'CEK INDEX HOME KAMPUS MERDEKA ${state.popularCeritaKM[index].id.toString()}');
                return CardCKM(
                  fun: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                            create: (context) =>
                                di.locator<DetailCeritaKMBloc>()
                                  ..add(GetDetailCeritaKMEvent(
                                      id: state.popularCeritaKM[index].id
                                          .toString())),
                            child: DetailCKMPage()),
                      ),
                    );
                  },
                  imageURL: state.popularCeritaKM[index].fileCover,
                  judulCerita: state.popularCeritaKM[index].judul,
                  author: state.popularCeritaKM[index].author,
                  date: FormatDate().formatDateFormatTime(
                      state.popularCeritaKM[index].tanggal),
                  like: state.popularCeritaKM[index].nLikes,
                  comment: state.popularCeritaKM[index].nComment,
                  category: state.popularCeritaKM[index].idProgram.toString(),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 20.h,
                );
              },
              itemCount: 3,
            ),
          ),
        ],
      );
    } else if (state is CeritaKMNoInternetState) {
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          color: Colors.transparent,
          height: screenHeight(context) * 0.5,
          child: NoInternet(
            bgColor: whiteBgPage,
            onPressed: () {
              _ckmBloc.add(GetCeritaKMPopularEvent());
            },
            buttonHide: false,
          ));
    } else {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        color: Colors.transparent,
        child: SkeletonLoadingCKM(),
      );
    }
  }
}
