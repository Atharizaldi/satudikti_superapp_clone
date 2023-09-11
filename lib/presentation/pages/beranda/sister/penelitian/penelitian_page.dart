import 'package:app/common/dateFormat.dart';
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/component/server_problem.dart';
import 'package:app/presentation/pages/beranda/sister/component/accordion_card.dart';
import 'package:app/presentation/pages/beranda/sister/component/empty_data.dart';
import 'package:app/presentation/pages/beranda/sister/component/skeleton_loading_sister_tabbar.dart';
import 'package:app/presentation/pages/beranda/sister/component/tabbar_slider.dart';
import 'package:app/presentation/pages/beranda/sister/penelitian/bloc/penelitian_sister_bloc.dart';
import 'package:app/presentation/pages/faq/bloc/faq_module/faqmodule_bloc.dart';
import 'package:app/presentation/pages/faq/faq_page_per_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PenelitianPage extends StatefulWidget {
  const PenelitianPage({Key? key}) : super(key: key);

  @override
  State<PenelitianPage> createState() => _PenelitianPageState();
}

class _PenelitianPageState extends State<PenelitianPage> {
  late PenelitianSisterBloc _penelitianSisterBloc;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PenelitianSisterBloc, PenelitianSisterState>(
      builder: (context, state) {
        _penelitianSisterBloc = BlocProvider.of<PenelitianSisterBloc>(context);
        if (state is PenelitianSisterNoInternetState) {
          return _penelitianWidgetState(context, state, state.nidn);
        } else if (state is PenelitianSisterErrorState) {
          return _penelitianWidgetState(context, state, state.nidn);
        } else if (state is PenelitianSisterLoadedState) {
          return _penelitianWidgetState(context, state, state.nidn);
        } else {
          return _penelitianWidgetState(context, state, '');
        }
      },
      listener: (context, state) {
        if (state is PenelitianSisterNoInternetState) {
          ScaffoldMessenger.of(context).showSnackBar(noInternet);
        }
      },
    );
    // return _penelitianWidgetState(context);
  }

  Widget _penelitianWidgetState(
      BuildContext context, PenelitianSisterState state, String nidn) {
    return Container(
        child: Scaffold(
      backgroundColor: Color(0xffF9FAFE),
      appBar: CustomAppBar(
        title: "Penelitian",
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return BlocProvider(
                      create: (context) => di.locator<FaqmoduleBloc>()
                        ..add(FetchfaqModuleEvent('sister')),
                      child: FAQModul(),
                    );
                  },
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: ImageIcon(
                AssetImage("assets/icons/to_faq_icon.png"),
              ),
            ),
          ),
        ],
      ),
      body: _body(context, state),
    ));
  }

  Widget _body(BuildContext context, PenelitianSisterState state) {
    if (state is PenelitianSisterinInitial) {
      return SkeletonLoadingSisterTabBar();
    } else if (state is PenelitianSisterLoadedState) {
      if (state.penelitianData.isEmpty) {
        return EmptyDataPage();
      } else {
        return Column(
          children: [
            TabBarSlider(
              tabs: [
                Tab(
                    child: Text(
                  'Penelitian',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                )),
                Tab(
                    child: Text(
                  'Publikasi',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                )),
              ],
              tabview: [
                // TabBarViewSister(data: [
                //   {'nama': 'test', 'info': 'testing'},
                // ]),
                state.penelitianData.isEmpty
                    ? EmptyDataPage()
                    : SingleChildScrollView(
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.penelitianData.length,
                          // itemCount: widget.listFAQ.data.faq.length,
                          itemBuilder: (context, index) {
                            return AccordionCard(
                              title: state.penelitianData[index].judul
                                          .toString() !=
                                      ''
                                  ? state.penelitianData[index].judul.toString()
                                  : '-',
                              date: state.penelitianData[index]
                                          .tahunPelaksanaanKe !=
                                      0
                                  ? state
                                      .penelitianData[index].tahunPelaksanaanKe
                                      .toString()
                                  : '-',
                              content: [
                                {
                                  'nama': "Judul",
                                  "info": state.penelitianData[index].judul
                                              .toString() !=
                                          ''
                                      ? state.penelitianData[index].judul
                                          .toString()
                                      : '-'
                                },
                                {
                                  'nama': "Tahun Pelaksanaan",
                                  'info': FormatDate().formatDate2(state
                                              .penelitianData[index]
                                              .tahunPelaksanaanKe
                                              .toString()) !=
                                          ''
                                      ? FormatDate().formatDate2(state
                                          .penelitianData[index]
                                          .tahunPelaksanaanKe
                                          .toString())
                                      : '-',
                                },
                                {
                                  'nama': "Peran",
                                  'info': state.penelitianData[index].peran
                                              .toString() !=
                                          ''
                                      ? state.penelitianData[index].peran
                                          .toString()
                                      : '-',
                                },
                                {
                                  'nama': 'Lokasi Kegiatan',
                                  'info': state.penelitianData[index]
                                              .lokasiKegiatan
                                              .toString() !=
                                          ''
                                      ? state
                                          .penelitianData[index].lokasiKegiatan
                                          .toString()
                                      : '-'
                                }
                              ], // title: widget.listFAQ.data.faq[index].pertanyaan,
                              // content: widget.listFAQ.data.faq[index].jawaban,
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(height: 12.h);
                          },
                        ),
                      ),
                state.publikasi.isEmpty
                    ? EmptyDataPage()
                    : SingleChildScrollView(
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.publikasi.length,
                          // itemCount: widget.listFAQ.data.faq.length,
                          itemBuilder: (context, index) {
                            return AccordionCard(
                              title:
                                  state.publikasi[index].judul.toString() != ''
                                      ? state.publikasi[index].judul.toString()
                                      : '-',
                              date: FormatDate().formatDate2(state
                                          .publikasi[index].tanggalTerbit) !=
                                      ''
                                  ? FormatDate().formatDate2(state
                                      .publikasi[index].tanggalTerbit
                                      .toString())
                                  : '-',
                              content: [
                                {
                                  'nama': "Nama Jurnal",
                                  "info": state.publikasi[index].namaJurnal
                                              .toString() !=
                                          ''
                                      ? state.publikasi[index].namaJurnal
                                          .toString()
                                      : '-'
                                },
                                {
                                  'nama': 'Kategori Kegiatan',
                                  'info': state
                                              .publikasi[index].kategoriKegiatan
                                              .toString() !=
                                          ''
                                      ? state.publikasi[index].kategoriKegiatan
                                          .toString()
                                      : '-',
                                },
                                {
                                  'nama': 'Jenis Publikasi',
                                  'info': state.publikasi[index].jenisPublikasi
                                              .toString() !=
                                          ''
                                      ? state.publikasi[index].jenisPublikasi
                                          .toString()
                                      : '-',
                                },
                                {
                                  'nama': 'Tanggal Terbit',
                                  'info': FormatDate().formatDate2(state
                                              .publikasi[index].tanggalTerbit
                                              .toString()) !=
                                          ''
                                      ? FormatDate().formatDate2(state
                                          .publikasi[index].tanggalTerbit
                                          .toString())
                                      : '-',
                                },
                                {
                                  'nama': 'Peran',
                                  'info': state.publikasi[index].peran
                                              .toString() !=
                                          ''
                                      ? state.publikasi[index].peran.toString()
                                      : '-'
                                },
                                {
                                  'nama': 'Asal Data',
                                  'info': state.publikasi[index].asalData
                                              .toString() !=
                                          ''
                                      ? state.publikasi[index].asalData
                                          .toString()
                                      : '-'
                                }
                              ], // title: widget.listFAQ.data.faq[index].pertanyaan,
                              // content: widget.listFAQ.data.faq[index].jawaban,
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(height: 12.h);
                          },
                        ),
                      ),
              ],
            ),
          ],
        );
      }
    } else {
      if (state is PenelitianSisterNoInternetState) {
        return Center(
          child: NoInternet(
              onPressed: () {
                _penelitianSisterBloc
                    .add(GetPenelitianSisterEvent(nidn: state.nidn));
              },
              buttonHide: false),
        );
      } else if (state is PenelitianSisterNotFoundState) {
        return EmptyDataPage();
      } else if (state is PenelitianSisterNotFoundState) {
        return Center(
          child: ServerProblem(
              onPressed: () {
                _penelitianSisterBloc.add(
                    GetPenelitianSisterEvent(nidn: _penelitianSisterBloc.nidn));
              },
              buttonHide: false),
        );
      } else {
        return Center(
          child: ServerProblem(
              onPressed: () {
                _penelitianSisterBloc.add(
                    GetPenelitianSisterEvent(nidn: _penelitianSisterBloc.nidn));
              },
              buttonHide: false),
        );
      }
    }
  }
}
