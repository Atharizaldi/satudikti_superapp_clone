import 'package:app/common/dateFormat.dart';
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/component/server_problem.dart';
import 'package:app/presentation/pages/beranda/kampusMerdeka/bloc/cerita_kampus_merdeka/cerita_kampus_merdeka_bloc.dart';
import 'package:app/presentation/pages/beranda/kampusMerdeka/bloc/detail_cerita_km/detail_cerita_km_bloc.dart';
import 'package:app/presentation/pages/beranda/kampusMerdeka/bloc/kampus_merdeka/kampusmerdeka_bloc.dart';
import 'package:app/presentation/pages/beranda/kampusMerdeka/component/card_CKM.dart';
import 'package:app/presentation/pages/beranda/kampusMerdeka/component/skeleton_loading_tabbar_ckm.dart';
import 'package:app/presentation/pages/beranda/sister/component/tabbar_scroll.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'detail_cerita.dart';

class DaftarCeritaPage extends StatefulWidget {
  const DaftarCeritaPage({Key? key}) : super(key: key);

  @override
  State<DaftarCeritaPage> createState() => _DaftarCeritaPageState();
}

class _DaftarCeritaPageState extends State<DaftarCeritaPage> {
  late CeritaKampusMerdekaBloc _ckmBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF9FAFE),
        appBar: CustomAppBar(
          title: 'Daftar Cerita',
          textStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18.sp,
          ),
        ),
        body: BlocConsumer<CeritaKampusMerdekaBloc, CeritaKampusMerdekaState>(
          listener: (context, state) {
            if (state is KampusmerdekaNoInternetState) {
              ScaffoldMessenger.of(context).showSnackBar(noInternet);
            }
          },
          builder: (context, state) {
            _ckmBloc = BlocProvider.of<CeritaKampusMerdekaBloc>(context);
            return _body(state);
          },
        ));
  }

  Widget _body(CeritaKampusMerdekaState state) {
    if (state is CeritaKMLoadingState) {
      return SkeletonLoadingTabBarCKM();
    } else if (state is CeritaKMLoadedState) {
      return Column(
        children: [
          TabBarScroll(
            tabs: [
              Tab(child: Text('Cerita Terkini')),
              Tab(child: Text('MSIB')),
              Tab(child: Text('Pertukaran Mahasiswa')),
              Tab(child: Text('Kampus Mengajar')),
              Tab(child: Text('IISMA')),
              Tab(child: Text('Wirausaha')),
              Tab(child: Text('Praktisi Mengajar')),
              Tab(child: Text('Festival Kampus Merdeka')),
            ],
            tabview: [
              //////////////////////// CKM TERKINI ////////////////////////
              SingleChildScrollView(
                child: ListView.separated(
                  padding: EdgeInsets.only(bottom: 20.h),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.recentCeritaKM.length,
                  itemBuilder: (context, index) {
                    return CardCKM(
                      fun: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                create: (context) =>
                                    di.locator<DetailCeritaKMBloc>()
                                      ..add(GetDetailCeritaKMEvent(
                                          id: state.recentCeritaKM[index].id
                                              .toString())),
                                child: DetailCKMPage()),
                          ),
                        );
                      },
                      imageURL: state.recentCeritaKM[index].fileCover,
                      judulCerita: state.recentCeritaKM[index].judul,
                      author: state.recentCeritaKM[index].author,
                      date: FormatDate().formatDateFormatTime(
                          state.recentCeritaKM[index].tanggal),
                      like: state.recentCeritaKM[index].nLikes,
                      comment: state.recentCeritaKM[index].nComment,
                      category:
                          state.recentCeritaKM[index].idProgram.toString(),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 12.h,
                    );
                  },
                ),
              ),
              ////////////////////// CKM MSIB ////////////////////////
              SingleChildScrollView(
                child: ListView.separated(
                  padding: EdgeInsets.only(bottom: 20.h),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.msibCeritaKM.length,
                  itemBuilder: (context, index) {
                    return CardCKM(
                      fun: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                create: (context) =>
                                    di.locator<DetailCeritaKMBloc>()
                                      ..add(GetDetailCeritaKMEvent(
                                          id: state.msibCeritaKM[index].id
                                              .toString())),
                                child: DetailCKMPage()),
                          ),
                        );
                      },
                      imageURL: state.msibCeritaKM[index].fileCover,
                      judulCerita: state.msibCeritaKM[index].judul,
                      author: state.msibCeritaKM[index].author,
                      date: FormatDate().formatDateFormatTime(
                          state.msibCeritaKM[index].tanggal),
                      like: state.msibCeritaKM[index].nLikes,
                      comment: state.msibCeritaKM[index].nComment,
                      category: state.msibCeritaKM[index].idProgram.toString(),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 12.h,
                    );
                  },
                ),
              ),
              //////////////////////// CKM PERTUKARAN PELAJAR ////////////////////////
              SingleChildScrollView(
                child: ListView.separated(
                  padding: EdgeInsets.only(bottom: 20.h),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.pertukaranMahasiswaCeritaKM.length,
                  itemBuilder: (context, index) {
                    return CardCKM(
                      fun: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                create: (context) => di
                                    .locator<DetailCeritaKMBloc>()
                                  ..add(GetDetailCeritaKMEvent(
                                      id: state
                                          .pertukaranMahasiswaCeritaKM[index].id
                                          .toString())),
                                child: DetailCKMPage()),
                          ),
                        );
                      },
                      imageURL:
                          state.pertukaranMahasiswaCeritaKM[index].fileCover,
                      judulCerita:
                          state.pertukaranMahasiswaCeritaKM[index].judul,
                      author: state.pertukaranMahasiswaCeritaKM[index].author,
                      date: FormatDate().formatDateFormatTime(
                          state.pertukaranMahasiswaCeritaKM[index].tanggal),
                      like: state.pertukaranMahasiswaCeritaKM[index].nLikes,
                      comment:
                          state.pertukaranMahasiswaCeritaKM[index].nComment,
                      category: state
                          .pertukaranMahasiswaCeritaKM[index].idProgram
                          .toString(),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 12.h,
                    );
                  },
                ),
              ),
              //////////////////////// CKM KAMPUS MENGAJAR ////////////////////////
              SingleChildScrollView(
                child: ListView.separated(
                  padding: EdgeInsets.only(bottom: 20.h),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.kampusMengajarCeritaKM.length,
                  itemBuilder: (context, index) {
                    return CardCKM(
                      fun: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                create: (context) => di
                                    .locator<DetailCeritaKMBloc>()
                                  ..add(GetDetailCeritaKMEvent(
                                      id: state.kampusMengajarCeritaKM[index].id
                                          .toString())),
                                child: DetailCKMPage()),
                          ),
                        );
                      },
                      imageURL: state.kampusMengajarCeritaKM[index].fileCover,
                      judulCerita: state.kampusMengajarCeritaKM[index].judul,
                      author: state.kampusMengajarCeritaKM[index].author,
                      date: FormatDate().formatDateFormatTime(
                          state.kampusMengajarCeritaKM[index].tanggal),
                      like: state.kampusMengajarCeritaKM[index].nLikes,
                      comment: state.kampusMengajarCeritaKM[index].nComment,
                      category: state.kampusMengajarCeritaKM[index].idProgram
                          .toString(),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 12.h,
                    );
                  },
                ),
              ),
              //////////////////////// CKM IISMA ////////////////////////
              SingleChildScrollView(
                child: ListView.separated(
                  padding: EdgeInsets.only(bottom: 20.h),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.iismaCeritaKM.length,
                  itemBuilder: (context, index) {
                    return CardCKM(
                      fun: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                create: (context) =>
                                    di.locator<DetailCeritaKMBloc>()
                                      ..add(GetDetailCeritaKMEvent(
                                          id: state.iismaCeritaKM[index].id
                                              .toString())),
                                child: DetailCKMPage()),
                          ),
                        );
                      },
                      imageURL: state.iismaCeritaKM[index].fileCover,
                      judulCerita: state.iismaCeritaKM[index].judul,
                      author: state.iismaCeritaKM[index].author,
                      date: FormatDate().formatDateFormatTime(
                          state.iismaCeritaKM[index].tanggal),
                      like: state.iismaCeritaKM[index].nLikes,
                      comment: state.iismaCeritaKM[index].nComment,
                      category: state.iismaCeritaKM[index].idProgram.toString(),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 12.h,
                    );
                  },
                ),
              ),
              //////////////////////// CKM WIRAUSAHA ////////////////////////
              SingleChildScrollView(
                child: ListView.separated(
                  padding: EdgeInsets.only(bottom: 20.h),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.wirausahaCeritaKM.length,
                  itemBuilder: (context, index) {
                    return CardCKM(
                      fun: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                create: (context) =>
                                    di.locator<DetailCeritaKMBloc>()
                                      ..add(GetDetailCeritaKMEvent(
                                          id: state.wirausahaCeritaKM[index].id
                                              .toString())),
                                child: DetailCKMPage()),
                          ),
                        );
                      },
                      imageURL: state.wirausahaCeritaKM[index].fileCover,
                      judulCerita: state.wirausahaCeritaKM[index].judul,
                      author: state.wirausahaCeritaKM[index].author,
                      date: FormatDate().formatDateFormatTime(
                          state.wirausahaCeritaKM[index].tanggal),
                      like: state.wirausahaCeritaKM[index].nLikes,
                      comment: state.wirausahaCeritaKM[index].nComment,
                      category:
                          state.wirausahaCeritaKM[index].idProgram.toString(),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 12.h,
                    );
                  },
                ),
              ),
              //////////////////////// CKM PRAKTISI ////////////////////////
              SingleChildScrollView(
                child: ListView.separated(
                  padding: EdgeInsets.only(bottom: 20.h),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.praktisiMengajarCeritaKM.length,
                  itemBuilder: (context, index) {
                    return CardCKM(
                      fun: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                create: (context) =>
                                    di.locator<DetailCeritaKMBloc>()
                                      ..add(GetDetailCeritaKMEvent(
                                          id: state
                                              .praktisiMengajarCeritaKM[index]
                                              .id
                                              .toString())),
                                child: DetailCKMPage()),
                          ),
                        );
                      },
                      imageURL: state.praktisiMengajarCeritaKM[index].fileCover,
                      judulCerita: state.praktisiMengajarCeritaKM[index].judul,
                      author: state.praktisiMengajarCeritaKM[index].author,
                      date: FormatDate().formatDateFormatTime(
                          state.praktisiMengajarCeritaKM[index].tanggal),
                      like: state.praktisiMengajarCeritaKM[index].nLikes,
                      comment: state.praktisiMengajarCeritaKM[index].nComment,
                      category: state.praktisiMengajarCeritaKM[index].idProgram
                          .toString(),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 12.h,
                    );
                  },
                ),
              ),
              //////////////////////// CKM FESTIVAL KAMPUS MERDEKA ////////////////////////
              SingleChildScrollView(
                child: ListView.separated(
                  padding: EdgeInsets.only(bottom: 20.h),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.festivalKMCeritaKM.length,
                  itemBuilder: (context, index) {
                    return CardCKM(
                      fun: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                create: (context) =>
                                    di.locator<DetailCeritaKMBloc>()
                                      ..add(GetDetailCeritaKMEvent(
                                          id: state.festivalKMCeritaKM[index].id
                                              .toString())),
                                child: DetailCKMPage()),
                          ),
                        );
                      },
                      imageURL: state.festivalKMCeritaKM[index].fileCover,
                      judulCerita: state.festivalKMCeritaKM[index].judul,
                      author: state.festivalKMCeritaKM[index].author,
                      date: FormatDate().formatDateFormatTime(
                          state.festivalKMCeritaKM[index].tanggal),
                      like: state.festivalKMCeritaKM[index].nLikes,
                      comment: state.festivalKMCeritaKM[index].nComment,
                      category:
                          state.festivalKMCeritaKM[index].idProgram.toString(),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 12.h,
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      if (state is CeritaKMNoInternetState) {
        return Center(
          child: NoInternet(
            bgColor: whiteBgPage,
            onPressed: () {
              _ckmBloc.add(GetCeritaKMRecentlyEvent());
              _ckmBloc.add(GetCeritaKMMSIBEvent());
              _ckmBloc.add(GetCeritaKMPertukaranMahasiswaEvent());
              _ckmBloc.add(GetCeritaKMKampusMengajarEvent());
              _ckmBloc.add(GetCeritaKMIISMAEvent());
              _ckmBloc.add(GetCeritaKMWirausahaEvent());
              _ckmBloc.add(GetCeritaKMFestivalKampusMerdekaEvent());
            },
            buttonHide: false,
          ),
        );
      } else {
        return ServerProblem(
          bgColor: whiteBgPage,
          onPressed: () {},
          buttonHide: true,
        );
      }
    }
  }
}
