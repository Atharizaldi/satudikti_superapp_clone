import 'package:app/common/dateFormat.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/component/server_problem.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/usulan_dosen/usulan_dosen_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/card/card_ajuan_perubahan.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/detail_ajuan_perubahan_data_page.dart';
import 'package:app/presentation/pages/beranda/sister/component/empty_data.dart';
import 'package:app/presentation/pages/beranda/sister/component/skeleton_loading_sister.dart';
import 'package:app/presentation/pages/beranda/sister/component/tabbar_scroll.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DaftarRiwayatUsulanDosen extends StatefulWidget {
  const DaftarRiwayatUsulanDosen({Key? key}) : super(key: key);

  @override
  State<DaftarRiwayatUsulanDosen> createState() =>
      _DaftarRiwayatUsulanDosenState();
}

late UsulanDosenBloc _usulanDosenBloc;

class _DaftarRiwayatUsulanDosenState extends State<DaftarRiwayatUsulanDosen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UsulanDosenBloc, UsulanDosenState>(
      builder: (context, state) {
        _usulanDosenBloc = BlocProvider.of<UsulanDosenBloc>(context);
        if (state is UsulanDosenNoInternet) {
          return _usulan(context, state);
        } else if (state is UsulanDosenError) {
          return _usulan(context, state);
        } else if (state is UsulanDosenLoaded) {
          return _usulan(context, state);
        } else {
          return _usulan(context, state);
        }
      },
      listener: (context, state) {
        if (state is UsulanDosenNoInternet) {
          ScaffoldMessenger.of(context).showSnackBar(noInternet);
        }
      },
    );
    // return _usulan();
  }

  Widget _usulan(BuildContext context, UsulanDosenState state) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Daftar Riwayat Usulan',
      ),
      // backgroundColor: Colors.amber,
      backgroundColor: whiteBgPage,
      body: _body(context, state),
    );
  }

  Widget _body(BuildContext context, UsulanDosenState state) {
    if (state is UsulanDosenInitial) {
      return SkeletonLoadingSISTER();
    } else if (state is UsulanDosenLoaded) {
      return Column(
        children: [
          TabBarScroll(
            tabs: [
              Tab(child: Text('Semua')),
              Tab(child: Text('Draft')),
              Tab(child: Text('Diajukan')),
              Tab(child: Text('Disetujui')),
              Tab(child: Text('Ditolak')),
            ],
            tabview: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    // GestureDetector(
                    //   onTap: () {},
                    //   child: Container(
                    //     color: Colors.transparent,
                    //     child: SearchBar(
                    //       margin: EdgeInsets.symmetric(
                    //         horizontal: 16.w,
                    //       ),
                    //       // isSubmitted: (value){
                    //       //   setState(() {
                    //       //     text = value;
                    //       //   });
                    //       // },
                    //       hintText: 'Cari pengumuman',
                    //       searchType: TypeSearchBar.regular,
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 20.h,
                    ),
                    // semua
                    ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.listSemua.length,
                      itemBuilder: (context, index) {
                        return CardAjuanPerubahan(
                          nama: state.listSemua[index].jenis.toString(),
                          categoriesKey:
                              state.listSemua[index].status.toString(),
                          date: FormatDate.formatDateIdID(
                              state.listSemua[index].tUpdateTime.toString()),
                          descriptionData: '',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailRiwayatUsulanPDDIKTIPage(
                                  status:
                                      state.listSemua[index].status.toString(),
                                  dokumenValid: state
                                      .listSemua[index].dokumenValid
                                      .toString(),
                                  jenis:
                                      state.listSemua[index].jenis.toString(),
                                  ket:
                                      state.listSemua[index].catatan.toString(),
                                  nama: state.listSemua[index].nama.toString(),
                                  tglUpdate: FormatDate.formatDateIdID(
                                    state.listSemua[index].tUpdateTime
                                        .toString(),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 12.h,
                        );
                      },
                    ),
                  ],
                ),
              ),
              // draft
              state.listDraft.length != 0
                  ? SingleChildScrollView(
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.listDraft.length,
                        itemBuilder: (context, index) {
                          return CardAjuanPerubahan(
                            nama: state.listDraft[index].jenis.toString(),
                            categoriesKey:
                                state.listDraft[index].status.toString(),
                            date: state.listDraft[index].tUpdateTime.toString(),
                            descriptionData: '',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailRiwayatUsulanPDDIKTIPage(
                                    status: state.listDraft[index].status
                                        .toString(),
                                    dokumenValid: state
                                        .listDraft[index].dokumenValid
                                        .toString(),
                                    jenis:
                                        state.listDraft[index].jenis.toString(),
                                    ket: state.listDraft[index].catatan
                                        .toString(),
                                    nama:
                                        state.listDraft[index].nama.toString(),
                                    tglUpdate: FormatDate.formatDateIdID(state
                                        .listDraft[index].tUpdateTime
                                        .toString()),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 12.h,
                          );
                        },
                      ),
                    )
                  : EmptyDataPage(),
              // diajukan
              state.listDiusulkan.length != 0
                  ? SingleChildScrollView(
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.listDiusulkan.length,
                        itemBuilder: (context, index) {
                          return CardAjuanPerubahan(
                            nama: state.listDiusulkan[index].jenis.toString(),
                            categoriesKey:
                                state.listDiusulkan[index].toString(),
                            date: state.listDiusulkan[index].tUpdateTime
                                .toString(),
                            descriptionData: 'Nama Ibu Kandung',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailRiwayatUsulanPDDIKTIPage(
                                    status: state.listDiusulkan[index].status
                                        .toString(),
                                    dokumenValid: state
                                        .listDiusulkan[index].dokumenValid
                                        .toString(),
                                    jenis: state.listDiusulkan[index].jenis
                                        .toString(),
                                    ket: state.listDiusulkan[index].catatan
                                        .toString(),
                                    nama: state.listDiusulkan[index].nama
                                        .toString(),
                                    tglUpdate: FormatDate.formatDateIdID(
                                      state.listDiusulkan[index].tUpdateTime
                                          .toString(),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 12.h,
                          );
                        },
                      ),
                    )
                  : EmptyDataPage(),

              // disetujui
              state.listDisetujui.length != 0
                  ? SingleChildScrollView(
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.listDisetujui.length,
                        itemBuilder: (context, index) {
                          return CardAjuanPerubahan(
                            nama: state.listDisetujui[index].jenis.toString(),
                            categoriesKey:
                                state.listDisetujui[index].status.toString(),
                            descriptionData: '',
                            date: state.listDisetujui[index].tUpdateTime
                                .toString(),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailRiwayatUsulanPDDIKTIPage(
                                    status: state.listDisetujui[index].status
                                        .toString(),
                                    dokumenValid: state
                                        .listDisetujui[index].dokumenValid
                                        .toString(),
                                    jenis: state.listDisetujui[index].jenis
                                        .toString(),
                                    ket: state.listDisetujui[index].catatan
                                        .toString(),
                                    nama: state.listDisetujui[index].nama
                                        .toString(),
                                    tglUpdate: FormatDate.formatDateIdID(
                                      state.listDisetujui[index].tUpdateTime
                                          .toString(),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 12.h,
                          );
                        },
                      ),
                    )
                  : EmptyDataPage(),

              // ditolak
              state.listDitolak.length != 0
                  ? SingleChildScrollView(
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.listDitolak.length,
                        itemBuilder: (context, index) {
                          return CardAjuanPerubahan(
                            nama: state.listDitolak[index].jenis.toString(),
                            categoriesKey:
                                state.listDitolak[index].status.toString(),
                            date:
                                state.listDitolak[index].tUpdateTime.toString(),
                            descriptionData: '',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailRiwayatUsulanPDDIKTIPage(
                                    status: state.listDitolak[index].status
                                        .toString(),
                                    dokumenValid: state
                                        .listDitolak[index].dokumenValid
                                        .toString(),
                                    jenis: state.listDitolak[index].jenis
                                        .toString(),
                                    ket: state.listDitolak[index].catatan
                                        .toString(),
                                    nama: state.listDitolak[index].nama
                                        .toString(),
                                    tglUpdate: FormatDate.formatDateIdID(
                                      state.listDitolak[index].tUpdateTime
                                          .toString(),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 12.h,
                          );
                        },
                      ),
                    )
                  : EmptyDataPage(),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
        ],
      );
    } else {
      if (state is UsulanDosenNoInternet) {
        return Container(
          color: Colors.transparent,
          height: screenHeight(context) * 0.5,
          child: NoInternet(
              onPressed: () {
                _usulanDosenBloc.add(GetUsulanDosenEvent(
                    namaDosen: _usulanDosenBloc.nama,
                    tanggalLahir: _usulanDosenBloc.tglLahir,
                    idPT: _usulanDosenBloc.idPT,
                    isLogin: _usulanDosenBloc.isLogin,
                    nidn: _usulanDosenBloc.nidn));
              },
              buttonHide: false),
        );
      } else if (state is UsulanDosenNotFound) {
        return EmptyDataPage();
      } else if (state is UsulanDosenError) {
        return Container(
          color: Colors.transparent,
          height: screenHeight(context) * 0.5,
          child: ServerProblem(
              onPressed: () {
                _usulanDosenBloc.add(GetUsulanDosenEvent(
                    namaDosen: _usulanDosenBloc.nama,
                    tanggalLahir: _usulanDosenBloc.tglLahir,
                    idPT: _usulanDosenBloc.idPT,
                    isLogin: _usulanDosenBloc.isLogin,
                    nidn: _usulanDosenBloc.nidn));
              },
              buttonHide: false),
        );
      } else {
        return Container(
          color: Colors.transparent,
          height: screenHeight(context) * 0.5,
          child: ServerProblem(
              onPressed: () {
                _usulanDosenBloc.add(GetUsulanDosenEvent(
                    namaDosen: _usulanDosenBloc.nama,
                    tanggalLahir: _usulanDosenBloc.tglLahir,
                    idPT: _usulanDosenBloc.idPT,
                    isLogin: _usulanDosenBloc.isLogin,
                    nidn: _usulanDosenBloc.nidn));
              },
              buttonHide: false),
        );
      }
    }
  }
}
