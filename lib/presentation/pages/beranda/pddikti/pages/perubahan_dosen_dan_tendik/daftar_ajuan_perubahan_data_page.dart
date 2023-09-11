import 'package:app/common/dateFormat.dart';
import 'package:app/data/source/local/sharedpreferences.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/component/server_problem.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/bloc/perubahan_dosen_tendik_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/card/card_ajuan_perubahan.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/detail_ajuan_perubahan_data_page.dart';
import 'package:app/presentation/pages/beranda/sister/component/empty_data.dart';
import 'package:app/presentation/pages/beranda/sister/component/skeleton_loading_sister_tabbar.dart';
import 'package:app/presentation/pages/beranda/sister/component/tabbar_scroll.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DaftarUsulanPerubahanDataPDDIKTIPage extends StatefulWidget {
  const DaftarUsulanPerubahanDataPDDIKTIPage({Key? key}) : super(key: key);

  @override
  State<DaftarUsulanPerubahanDataPDDIKTIPage> createState() =>
      _DaftarUsulanPerubahanDataPDDIKTIPageState();
}

class _DaftarUsulanPerubahanDataPDDIKTIPageState
    extends State<DaftarUsulanPerubahanDataPDDIKTIPage> {
  late PerubahanDosenTendikBloc _perubahanDosenTendikBloc;
  ScrollController _scrollController = ScrollController();
  String namaDosen = '';

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    List<String> dataDosen = Prefs.getDataDosen() ?? ['null'];
    namaDosen = dataDosen[0];
    print("INI NAMA DOSEN DARI PREF $namaDosen");
  }

  void onScroll(BuildContext context) {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;

    if (currentScroll == maxScroll) {
      print("MENTOK");
      _perubahanDosenTendikBloc.add(
          FetchPerubahanDosenTendikEvent(nidn: _perubahanDosenTendikBloc.nidn));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PerubahanDosenTendikBloc, PerubahanDosenTendikState>(
        builder: (context, state) {
      _perubahanDosenTendikBloc =
          BlocProvider.of<PerubahanDosenTendikBloc>(context);
      _scrollController.addListener(() {
        onScroll(context);
      });
      if (state is PerubahanNoInternetState) {
        return _perubahanWidget(context, state);
      } else if (state is PerubahanErrorState) {
        return _perubahanWidget(context, state);
      } else if (state is PerubahanDosenTendikLoaded) {
        return _perubahanWidget(context, state);
      } else {
        return _perubahanWidget(context, state);
      }
    }, listener: (context, state) {
      if (state is PerubahanNoInternetState) {
        ScaffoldMessenger.of(context).showSnackBar(noInternet);
      }
    });
    // return _perubahanWidget();
  }

  Scaffold _perubahanWidget(
      BuildContext context, PerubahanDosenTendikState state) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: true,
        title: 'Daftar Usulan Perubahan',
      ),
      // backgroundColor: Colors.amber,
      backgroundColor: whiteBgPage,
      body: _body(context, state),
    );
  }

  Widget _body(BuildContext context, PerubahanDosenTendikState state) {
    int page = 0;
    if (state is PerubahanDosenTendikInitial) {
      return SkeletonLoadingSisterTabBar();
    } else if (state is PerubahanDosenTendikLoading) {
      return SkeletonLoadingSisterTabBar();
    } else if (state is PerubahanDosenTendikLoaded) {
      if (state.listSemua.isEmpty) {
        return EmptyDataPage();
      } else {
        return Column(
          children: [
            TabBarScroll(
              onTap: (p0) {
                setState(() {
                  page = state.listDraft.length;
                  print("CEK INI KE $p0");
                  print("Berapa panjang semua ${state.listDitolak.length} $p0");
                });
              },
              tabs: [
                Tab(child: Text('Semua')),
                Tab(child: Text('Draft')),
                Tab(child: Text('Diusulkan')),
                Tab(child: Text('Disetujui')),
                Tab(child: Text('Ditolak')),
              ],
              tabview: [
                // semua
                ListView(
                  controller: _scrollController,
                  children: [
                    ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.listSemua.length < 10
                          ? state.listSemua.length
                          : (state.hasReached)
                              ? state.listSemua.length
                              : state.listSemua.length + 1,
                      itemBuilder: (context, index) {
                        if (index < state.listSemua.length) {
                          return CardAjuanPerubahan(
                            nama: state.listSemua[index].jenis.toString(),
                            categoriesKey: state
                                .listSemua[index].namaStatusUsulan
                                .toString(),
                            date: state.listSemua[index].tanggalPengajuan
                                .toString(),
                            descriptionData: '',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailRiwayatUsulanPDDIKTIPage(
                                    status: state
                                        .listSemua[index].namaStatusUsulan
                                        .toString(),
                                    dokumenValid: state
                                        .listSemua[index].dokumenValid
                                        .toString(),
                                    jenis:
                                        state.listSemua[index].jenis.toString(),
                                    ket: state.listSemua[index].catatan!
                                                .trim() ==
                                            ""
                                        ? '-'
                                        : state.listSemua[index].catatan
                                            .toString(),
                                    nama: state.listSemua[index].nama
                                                .toString() !=
                                            ''
                                        ? state.listSemua[index].nama.toString()
                                        : namaDosen,
                                    tglUpdate: FormatDate.formatDateIdID(state
                                        .listSemua[index].tUpdateTime
                                        .toString()),
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return Center(
                            child: SizedBox(
                              width: 30,
                              height: 30,
                              child:
                                  CircularProgressIndicator(color: blueLinear1),
                            ),
                          );
                        }
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 12.h,
                        );
                      },
                    ),
                  ],
                ),
                // draft
                state.listDraft.length != 0
                    ? ListView(
                        controller: _scrollController,
                        children: [
                          ListView.separated(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: state.listDraft.length < 10
                                ? state.listDraft.length
                                : (state.hasReached)
                                    ? state.listDraft.length
                                    : state.listDraft.length + 1,
                            itemBuilder: (context, index) {
                              if (index < state.listDraft.length) {
                                return CardAjuanPerubahan(
                                  nama: state.listDraft[index].jenis.toString(),
                                  categoriesKey: state
                                      .listDraft[index].namaStatusUsulan
                                      .toString(),
                                  date: state.listDraft[index].tanggalPengajuan
                                      .toString(),
                                  descriptionData: '',
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailRiwayatUsulanPDDIKTIPage(
                                          status: state
                                              .listDraft[index].namaStatusUsulan
                                              .toString(),
                                          dokumenValid: state
                                              .listDraft[index].dokumenValid
                                              .toString(),
                                          jenis: state.listDraft[index].jenis
                                              .toString(),
                                          ket: state.listDraft[index].catatan!
                                                      .trim() ==
                                                  ""
                                              ? '-'
                                              : state.listDraft[index].catatan
                                                  .toString(),
                                          nama: state.listDraft[index].nama
                                                      .toString() !=
                                                  ''
                                              ? state.listDraft[index].nama
                                                  .toString()
                                              : namaDosen,
                                          tglUpdate: FormatDate.formatDateIdID(
                                              state.listDraft[index].tUpdateTime
                                                  .toString()),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return Center(
                                  child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: CircularProgressIndicator(
                                        color: blueLinear1),
                                  ),
                                );
                              }
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                height: 12.h,
                              );
                            },
                          ),
                        ],
                      )
                    : EmptyDataPage(),

                // diusulkan
                state.listDiusulkan.length != 0
                    ? ListView(
                        controller: _scrollController,
                        children: [
                          ListView.separated(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: state.listDiusulkan.length < 10
                                ? state.listDiusulkan.length
                                : (state.hasReached)
                                    ? state.listDiusulkan.length
                                    : state.listDiusulkan.length + 1,
                            itemBuilder: (context, index) {
                              if (index < state.listDiusulkan.length) {
                                return CardAjuanPerubahan(
                                  nama: state.listDiusulkan[index].jenis
                                      .toString(),
                                  categoriesKey: state
                                      .listDiusulkan[index].namaStatusUsulan
                                      .toString(),
                                  date: state
                                      .listDiusulkan[index].tanggalPengajuan
                                      .toString(),
                                  descriptionData: '',
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailRiwayatUsulanPDDIKTIPage(
                                          status: state.listDiusulkan[index]
                                              .namaStatusUsulan
                                              .toString(),
                                          dokumenValid: state
                                              .listDiusulkan[index].dokumenValid
                                              .toString(),
                                          jenis: state
                                              .listDiusulkan[index].jenis
                                              .toString(),
                                          ket: state.listDiusulkan[index]
                                                      .catatan!
                                                      .trim() ==
                                                  ""
                                              ? '-'
                                              : state
                                                  .listDiusulkan[index].catatan
                                                  .toString(),
                                          nama: state.listDiusulkan[index].nama
                                                      .toString() !=
                                                  ''
                                              ? state.listDiusulkan[index].nama
                                                  .toString()
                                              : namaDosen,
                                          tglUpdate: FormatDate.formatDateIdID(
                                              state.listDiusulkan[index]
                                                  .tUpdateTime
                                                  .toString()),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return Center(
                                  child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: CircularProgressIndicator(
                                        color: blueLinear1),
                                  ),
                                );
                              }
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                height: 12.h,
                              );
                            },
                          ),
                        ],
                      )
                    : EmptyDataPage(),

                // disetujui
                state.listDisetujui.length != 0
                    ? ListView(
                        controller: _scrollController,
                        children: [
                          ListView.separated(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: state.listDisetujui.length < 10
                                ? state.listDisetujui.length
                                : (state.hasReached)
                                    ? state.listDisetujui.length
                                    : state.listDisetujui.length + 1,
                            itemBuilder: (context, index) {
                              if (index < state.listDisetujui.length) {
                                return CardAjuanPerubahan(
                                  nama: state.listDisetujui[index].jenis
                                      .toString(),
                                  categoriesKey: state
                                      .listDisetujui[index].namaStatusUsulan
                                      .toString(),
                                  date: state
                                      .listDisetujui[index].tanggalPengajuan
                                      .toString(),
                                  descriptionData: '',
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailRiwayatUsulanPDDIKTIPage(
                                          status: state.listDisetujui[index]
                                              .namaStatusUsulan
                                              .toString(),
                                          dokumenValid: state
                                              .listDisetujui[index].dokumenValid
                                              .toString(),
                                          jenis: state
                                              .listDisetujui[index].jenis
                                              .toString(),
                                          ket: state.listDisetujui[index]
                                                      .catatan!
                                                      .trim() ==
                                                  ""
                                              ? '-'
                                              : state
                                                  .listDisetujui[index].catatan
                                                  .toString(),
                                          nama: state.listDisetujui[index].nama
                                                      .toString() !=
                                                  ''
                                              ? state.listDisetujui[index].nama
                                                  .toString()
                                              : namaDosen,
                                          tglUpdate: FormatDate.formatDateIdID(
                                              state.listDisetujui[index]
                                                  .tUpdateTime
                                                  .toString()),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return Center(
                                  child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: CircularProgressIndicator(
                                        color: blueLinear1),
                                  ),
                                );
                              }
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                height: 12.h,
                              );
                            },
                          ),
                        ],
                      )
                    : EmptyDataPage(),

                // ditolak
                state.listDitolak.length != 0
                    ? ListView(
                        controller: _scrollController,
                        children: [
                          ListView.separated(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: state.listDitolak.length < 10
                                ? state.listDitolak.length
                                : (state.hasReached)
                                    ? state.listDitolak.length
                                    : state.listDitolak.length + 1,
                            itemBuilder: (context, index) {
                              if (index < state.listDitolak.length) {
                                return CardAjuanPerubahan(
                                  nama:
                                      state.listDitolak[index].jenis.toString(),
                                  categoriesKey: state
                                      .listDitolak[index].namaStatusUsulan
                                      .toString(),
                                  date: state
                                      .listDitolak[index].tanggalPengajuan
                                      .toString(),
                                  descriptionData: '',
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailRiwayatUsulanPDDIKTIPage(
                                          status: state.listDitolak[index]
                                              .namaStatusUsulan
                                              .toString(),
                                          dokumenValid: state
                                              .listDitolak[index].dokumenValid
                                              .toString(),
                                          jenis: state.listDitolak[index].jenis
                                              .toString(),
                                          ket: state.listDitolak[index].catatan!
                                                      .trim() ==
                                                  ""
                                              ? '-'
                                              : state.listDitolak[index].catatan
                                                  .toString(),
                                          nama: state.listDitolak[index].nama
                                                      .toString() !=
                                                  ''
                                              ? state.listDitolak[index].nama
                                                  .toString()
                                              : namaDosen,
                                          tglUpdate: FormatDate.formatDateIdID(
                                              state.listDitolak[index]
                                                  .tUpdateTime
                                                  .toString()),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return Center(
                                  child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: CircularProgressIndicator(
                                        color: blueLinear1),
                                  ),
                                );
                              }
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                height: 12.h,
                              );
                            },
                          ),
                        ],
                      )
                    : EmptyDataPage(),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        );
      }
    } else {
      if (state is PerubahanNoInternetState) {
        return Center(
          child: NoInternet(onPressed: () {}, buttonHide: true),
        );
      } else if (state is PerubahanErrorState) {
        return Center(
          child: ServerProblem(onPressed: () {}, buttonHide: true),
        );
      } else {
        return Center(
          child: ServerProblem(onPressed: () {}, buttonHide: true),
        );
      }
    }
  }
}
