import 'package:app/common/dateFormat.dart';
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/component/server_problem.dart';
import 'package:app/presentation/pages/beranda/sister/component/accordion_card.dart';
import 'package:app/presentation/pages/beranda/sister/component/empty_data.dart';
import 'package:app/presentation/pages/beranda/sister/component/skeleton_loading_sister_tabbar.dart';
import 'package:app/presentation/pages/beranda/sister/component/tabbar_scroll.dart';
import 'package:app/presentation/pages/beranda/sister/component/tabbarviewsister.dart';
import 'package:app/presentation/pages/beranda/sister/penempatan/bloc/penempatan_sister_bloc.dart';
import 'package:app/presentation/pages/faq/bloc/faq_module/faqmodule_bloc.dart';
import 'package:app/presentation/pages/faq/faq_page_per_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//aasdfasfasfas
class Penempatan extends StatefulWidget {
  const Penempatan({Key? key}) : super(key: key);

  @override
  State<Penempatan> createState() => _PenempatanState();
}

class _PenempatanState extends State<Penempatan> {
  // List _item = [];

  // Future<void> readJson() async {
  //   final String response =
  //       await rootBundle.loadString('assets/sister/penempatan.json');
  //   final data = await json.decode(response);
  //   print(data['data']["penempatan_dosen"]);
  //   setState(() {
  //     // _item = data["data"];
  //     // return _item['penempatan_dosen'];
  //     // // .map((data) => Job.fromJson(data)).toList();
  //     // print("=========== INI _item ===========");
  //     // print(_item);
  //   });
  // }

  late PenempatanSisterBloc _penempatanSisterBloc;

  @override
  void initState() {
    super.initState();
    // readJson();
  }

  @override
  Widget build(BuildContext context) {
    print("========================= MASUK KE BUILD======================");
    return BlocConsumer<PenempatanSisterBloc, PenempatanSisterState>(
        listener: (context, state) {
      print("========================= MASUK KE BLOC======================");

      if (state is PenempatanSisterNoInternetState) {
        print("========================= MASUK KE LOG======================");

        ScaffoldMessenger.of(context).showSnackBar(noInternet);
      }
    }, builder: (context, state) {
      _penempatanSisterBloc = BlocProvider.of<PenempatanSisterBloc>(context);
      if (state is PenempatanSisterNoInternetState) {
        // return Text("NO internet");
        return _penempatanWidgetState(context, state, state.nidn);
      } else if (state is PenempatanSisterErrorState) {
        // return Text("tes1");
        return _penempatanWidgetState(context, state, state.nidn);
      } else if (state is PenempatanSisterLoadedState) {
        // return Text("ted2");
        return _penempatanWidgetState(context, state, state.nidn);
      } else {
        // return Text("ASDSASAD");
        return _penempatanWidgetState(context, state, ''); // Temporary case
      }
    });
  }

  Widget _penempatanWidgetState(
    BuildContext context,
    PenempatanSisterState state,
    String nidn,
  ) {
    return Scaffold(
        backgroundColor: Color(0xFFF9FAFE),
        appBar: CustomAppBar(
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
                  size: 20.sp,
                ),
              ),
            ),
          ],
          title: "Penempatan",
        ),
        body: _tabBar(context, state));
  }

  Widget _tabBar(
    BuildContext context,
    PenempatanSisterState state,
  ) {
    if (state is PenempatanSisterinInitial) {
      return SkeletonLoadingSisterTabBar();
    } else if (state is PenempatanSisterLoadedState) {
      if (state.penempatanSister.penempatan.isEmpty) {
        return EmptyDataPage();
      } else {
        return Column(
          children: [
            TabBarScroll(
              tabs: [
                Tab(child: Text("Penempatan")),
                Tab(child: Text("Jabatan Fungsional")),
                Tab(child: Text("Kepangkatan")),
                Tab(child: Text("Inpassing")),
              ],
              tabview: [
                state.penempatanSister.penempatan.length == 1
                    ? TabBarViewSister(data: [
                        {
                          'nama': 'NIDN/NIDK',
                          'info': state.penempatanSister.penempatan[0].nidn
                        },
                        {
                          'nama': 'Status',
                          'info': state
                              .penempatanSister.penempatan[0].statusKepegawaian
                        },
                        {
                          'nama': 'Ikatan Kerja',
                          'info':
                              state.penempatanSister.penempatan[0].ikatanKerja
                        },
                        {
                          'nama': 'Jenjang Pendidikan',
                          'info':
                              state.penempatanSister.penempatan[0].jenjangDidik
                        },
                        {
                          'nama': 'Unit Kerja',
                          'info': state.penempatanSister.penempatan[0].unitProdi
                        },
                        {
                          'nama': 'Perguruan Tinggi',
                          'info': state
                              .penempatanSister.penempatan[0].perguruanTinggi
                        },
                        {
                          'nama': 'Tanggal Mulai',
                          'info': FormatDate().formatDate2(state
                              .penempatanSister.penempatan[0].tmtSkPenugasan)
                        },
                        {
                          'nama': 'Tanggal Keluar',
                          'info': FormatDate().formatDate2(state
                              .penempatanSister.penempatan[0].tanggalKeluar)
                        },
                        {
                          'nama': 'Jenis Keluar',
                          'info':
                              state.penempatanSister.penempatan[0].jenisKeluar
                        },
                        // {
                        //   'nama': 'Homebase',
                        //   'info': state.penempatanSister.penempatan[index].apakah_homebase ==
                        //           true
                        //       ? "Ya"
                        //       : "Tidak"
                        // },
                      ])
                    : SingleChildScrollView(
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.penempatanSister.penempatan.length,
                          itemBuilder: (context, index) {
                            return AccordionCard(
                              title:
                                  "${state.penempatanSister.penempatan[index].ikatanKerja} | ${state.penempatanSister.penempatan[index].perguruanTinggi}",
                              date: '',
                              content: [
                                {
                                  'nama': 'NIDN/NIDK',
                                  'info': state
                                      .penempatanSister.penempatan[index].nidn
                                },
                                {
                                  'nama': 'Status',
                                  'info': state.penempatanSister
                                      .penempatan[index].statusKepegawaian
                                },
                                {
                                  'nama': 'Jenjang Pendidikan',
                                  'info': state.penempatanSister
                                      .penempatan[index].jenjangDidik
                                },
                                {
                                  'nama': 'Unit Kerja',
                                  'info': state.penempatanSister
                                      .penempatan[index].unitProdi
                                },
                                {
                                  'nama': 'Tanggal Mulai',
                                  'info': FormatDate().formatDate2(state
                                      .penempatanSister
                                      .penempatan[index]
                                      .tmtSkPenugasan)
                                },
                                {
                                  'nama': 'Tanggal Keluar',
                                  'info': FormatDate().formatDate2(state
                                      .penempatanSister
                                      .penempatan[index]
                                      .tanggalKeluar)
                                },
                                {
                                  'nama': 'Jenis Keluar',
                                  'info': state.penempatanSister
                                      .penempatan[index].jenisKeluar
                                },
                              ],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(height: 12.h);
                          },
                        ),
                      ),
                // jabfung
                state.penempatanSister.jabFung.length == 1
                    ? TabBarViewSister(data: [
                        {
                          'nama': 'Jabatan Fungsional',
                          'info': state.penempatanSister.jabFung[0].jabfung
                        },
                        {
                          'nama': 'Nomor SK',
                          'info': state.penempatanSister.jabFung[0].skJabfung
                        },
                        {
                          'nama': 'Tanggal Mulai',
                          'info': FormatDate().formatDate2(
                              state.penempatanSister.jabFung[0].tanggalMulai)
                        },
                      ])
                    : SingleChildScrollView(
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.penempatanSister.jabFung.length,
                          itemBuilder: (BuildContext context, index) {
                            return AccordionCard(
                                title: state
                                    .penempatanSister.jabFung[index].skJabfung,
                                date: '',
                                content: [
                                  {
                                    'nama': 'Nomor SK',
                                    'info': state.penempatanSister
                                        .jabFung[index].skJabfung
                                  },
                                  {
                                    'nama': 'Tanggal Mulai',
                                    'info': FormatDate().formatDate2(state
                                        .penempatanSister
                                        .jabFung[index]
                                        .tanggalMulai)
                                  },
                                ]);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(height: 12.h);
                          },
                        ),
                      ),
                // kepangkatan
                state.penempatanSister.kepangkatan.length == 1
                    ? TabBarViewSister(data: [
                        {
                          'nama': 'Golongan/Pangkat',
                          // 'info': golongan + " " + pangkat
                          'info':
                              "${state.penempatanSister.kepangkatan[0].golongan} (${state.penempatanSister.kepangkatan[0].pangkat})"
                        },
                        {
                          'nama': 'Nomor SK',
                          'info': state.penempatanSister.kepangkatan[0].nomorSK
                        },
                        {
                          'nama': 'Tanggal Mulai',
                          'info': FormatDate().formatDate2(
                              state.penempatanSister.kepangkatan[0].tglMulai)
                        },
                      ])
                    : SingleChildScrollView(
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.penempatanSister.kepangkatan.length,
                          itemBuilder: (BuildContext context, index) {
                            return AccordionCard(
                                title:
                                    "${state.penempatanSister.kepangkatan[index].pangkat} (${state.penempatanSister.kepangkatan[index].golongan})",
                                date: '',
                                content: [
                                  {
                                    'nama': 'Nomor SK',
                                    'info': state.penempatanSister
                                        .kepangkatan[index].nomorSK
                                  },
                                  {
                                    'nama': 'Tanggal Mulai',
                                    'info': FormatDate().formatDate2(state
                                        .penempatanSister
                                        .kepangkatan[index]
                                        .tglMulai)
                                  },
                                ]);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(height: 12.h);
                          },
                        ),
                      ),
                // inpassing
                state.penempatanSister.inpassing.length == 1
                    ? TabBarViewSister(data: [
                        {
                          'nama': 'Golongan/Pangkat',
                          'info':
                              "${state.penempatanSister.inpassing[0].pangkat} (${state.penempatanSister.inpassing[0].golongan})"
                        },
                        {
                          'nama': 'Nomor SK',
                          'info':
                              state.penempatanSister.inpassing[0].nomorInpassing
                        },
                        {
                          'nama': 'Tanggal SK',
                          'info': FormatDate().formatDate2(state
                              .penempatanSister.inpassing[0].tglSkInpassing)
                        },
                        {
                          'nama': 'Tanggal Mulai',
                          'info': FormatDate().formatDate2(state
                              .penempatanSister.inpassing[0].tglMulaiInpassing)
                        },
                      ])
                    : SingleChildScrollView(
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.penempatanSister.inpassing.length,
                          itemBuilder: (BuildContext context, index) {
                            return AccordionCard(
                                date: '',
                                title:
                                    "${state.penempatanSister.inpassing[index].pangkat} (${state.penempatanSister.inpassing[index].golongan})",
                                content: [
                                  {
                                    'nama': 'Nomor SK',
                                    'info': state.penempatanSister
                                        .inpassing[index].nomorInpassing
                                  },
                                  {
                                    'nama': 'Tanggal SK',
                                    'info': FormatDate().formatDate2(state
                                        .penempatanSister
                                        .inpassing[index]
                                        .tglSkInpassing)
                                  },
                                  {
                                    'nama': 'Tanggal Mulai',
                                    'info': FormatDate().formatDate2(state
                                        .penempatanSister
                                        .inpassing[index]
                                        .tglMulaiInpassing)
                                  },
                                ]);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(height: 12.h);
                          },
                        ),
                      )
              ],
            ),
          ],
        );
      }
    } else {
      print("INI STATEEEEEEEEEEEEEEEEEE $state");
      if (state is PenempatanSisterNoInternetState) {
        return Center(
          child: NoInternet(
              onPressed: () {
                _penempatanSisterBloc
                    .add(GetPenempatanSisterEvent(nidn: state.nidn));
              },
              buttonHide: false),
        );
      } else if (state is PenempatanSisterNotFoundState) {
        return Container(
          child: Text("INI PENEMPATAN SISTER NOT FOUND"),
        );
      } else if (state is PenempatanSisterErrorState) {
        return Center(
          child: ServerProblem(
              onPressed: () {
                _penempatanSisterBloc
                    .add(GetPenempatanSisterEvent(nidn: state.nidn));
              },
              buttonHide: false),
        );
      } else {
        return Center(
          child: ServerProblem(
              onPressed: () {
                _penempatanSisterBloc.add(
                    GetPenempatanSisterEvent(nidn: _penempatanSisterBloc.nidn));
              },
              buttonHide: false),
        );
      }
    }
  }
}
