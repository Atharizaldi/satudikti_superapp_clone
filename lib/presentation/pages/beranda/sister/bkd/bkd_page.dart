import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/component/search/searchBar.dart';
import 'package:app/presentation/component/server_problem.dart';
import 'package:app/presentation/pages/beranda/sister/bkd/bloc/bkd_bloc.dart';
import 'package:app/presentation/pages/beranda/sister/component/accordion_card.dart';
import 'package:app/presentation/pages/beranda/sister/component/dropdown_sister.dart';
import 'package:app/presentation/pages/beranda/sister/component/empty_data.dart';
import 'package:app/presentation/pages/beranda/sister/component/skeleton_loading_sister_tabbar.dart';
import 'package:app/presentation/pages/beranda/sister/component/tabbar_slider.dart';
import 'package:app/presentation/pages/faq/bloc/faq_module/faqmodule_bloc.dart';
import 'package:app/presentation/pages/faq/faq_page_per_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BKDPage extends StatefulWidget {
  const BKDPage({Key? key}) : super(key: key);

  @override
  State<BKDPage> createState() => _BKDPageState();
}

class _BKDPageState extends State<BKDPage> {
  String? _selectedValue;
  TextEditingController textEditingController = TextEditingController();
  String sort = '';
  String search = '';
  int tabIndex = 0;

  late BKDSisterBloc _bkdSisterBloc;
  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  int _currentTabIndex = 0;
  void _handleTabIndexChanged(int index) {
    setState(() {
      _currentTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BKDSisterBloc, BKDSisterState>(
      builder: (context, state) {
        _bkdSisterBloc = BlocProvider.of<BKDSisterBloc>(context);
        if (state is BKDSisterNoInternetState) {
          return _bkdWidgetState(context, state, state.nidn);
        } else if (state is BKDSisterErrorState) {
          return _bkdWidgetState(context, state, state.nidn);
        } else if (state is BKDSisterLoadedState) {
          return _bkdWidgetState(context, state, state.nidn);
        } else {
          return _bkdWidgetState(context, state, '');
        }
      },
      listener: (context, state) {
        if (state is BKDSisterNoInternetState) {
          ScaffoldMessenger.of(context).showSnackBar(noInternet);
        }
      },
    );
  }

  Widget _bkdWidgetState(
      BuildContext context, BKDSisterState state, String nidn) {
    return Container(
        child: Scaffold(
      backgroundColor: Color(0xffF9FAFE),
      appBar: CustomAppBar(
        title: "BKD",
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
      body: _bkdBody(context, state),
    ));
  }

  Widget _bkdBody(BuildContext context, BKDSisterState state) {
    if (state is BKDSisterInitial) {
      return SkeletonLoadingSisterTabBar();
    } else if (state is BKDSisterLoading) {
      return SkeletonLoadingSisterTabBar();
    } else if (state is BKDSisterLoadedState) {
      if (state.nidn.isEmpty) {
        return SkeletonLoadingSisterTabBar();
      } else {
        return Column(
          children: [
            TabBarSlider(
              onTabIndexChanged: _handleTabIndexChanged,
              tabGO: _currentTabIndex,
              onTap: (index) {
                _selectedValue = null;
                print("CEKKKKKKKK $index");

                tabIndex = index;
              },
              tabs: [
                Tab(
                    child: Text(
                  'Rekrutmen Asesor BKD',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                )),
                Tab(
                    child: Text(
                  'Penilaian Asesor BKD',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                )),
              ],
              tabview: [
                state.bkdRekrutmenData.isEmpty
                    ? EmptyDataPage()
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            ListView.separated(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: state.bkdRekrutmenData.length,
                              itemBuilder: (context, i) {
                                return AccordionCard(
                                  // onTapButton: () {
                                  //   state.bkdRekrutmenData[i].cetak == '-'
                                  //       ? ScaffoldMessenger.of(context)
                                  //           .showSnackBar(SnackBar(
                                  //           width: 160,
                                  //           content: Text(
                                  //             'Sertifikat Belum Tersedia',
                                  //             textAlign: TextAlign.center,
                                  //             style: TextStyle(fontSize: 10.sp),
                                  //           ),
                                  //           behavior: SnackBarBehavior.floating,
                                  //         ))
                                  //       : ScaffoldMessenger.of(context)
                                  //           .showSnackBar(SnackBar(
                                  //           width: 160,
                                  //           content: Text(
                                  //             'Sertifikat Tersedia',
                                  //             textAlign: TextAlign.center,
                                  //             style: TextStyle(fontSize: 10.sp),
                                  //           ),
                                  //           behavior: SnackBarBehavior.floating,
                                  //         ));
                                  // },
                                  // isButton: true,
                                  title: state.bkdRekrutmenData[i].nama,
                                  date: state.bkdRekrutmenData[i].tglAwal
                                              .toString() !=
                                          ''
                                      ? state.bkdRekrutmenData[i].tglAwal
                                          .toString()
                                      : '-',
                                  content: [
                                    {
                                      'nama': "Nama Kegiatan",
                                      "info": state.bkdRekrutmenData[i].nama
                                                  .toString() !=
                                              ''
                                          ? state.bkdRekrutmenData[i].nama
                                              .toString()
                                          : '-'
                                    },
                                    {
                                      'nama': "Tanggal Awal",
                                      "info": state.bkdRekrutmenData[i].tglAwal
                                                  .toString() !=
                                              ''
                                          ? state.bkdRekrutmenData[i].tglAwal
                                              .toString()
                                          : '-'
                                    },
                                    {
                                      'nama': "Tanggal Akhir",
                                      "info": state.bkdRekrutmenData[i].tglAkhir
                                                  .toString() !=
                                              ''
                                          ? state.bkdRekrutmenData[i].tglAkhir
                                              .toString()
                                          : '-'
                                    },
                                    {
                                      'nama': "Komp",
                                      "info": '-',
                                    },
                                    {
                                      'nama': "Ketr",
                                      "info": state
                                          .bkdRekrutmenData[i].nilaiKeterangan
                                          .toString(),
                                    },
                                    {
                                      'nama': "Serdik",
                                      "info": state.bkdRekrutmenData[i].serdik
                                                  .toString() !=
                                              ''
                                          ? state.bkdRekrutmenData[i].serdik
                                              .toString()
                                          : '-'
                                    },
                                    {
                                      'nama': "NIRA",
                                      "info": state.bkdRekrutmenData[i].nira
                                                  .toString() !=
                                              ''
                                          ? state.bkdRekrutmenData[i].nira
                                              .toString()
                                          : '-'
                                    },
                                    // {
                                    //   'nama': "Dokumen",
                                    //   "info":
                                    //       state.bkdRekrutmenData[i].cetak == '-'
                                    //           ? 'Sertifikat Belum Tersedia'
                                    //           : "Sertifikat Tersedia"
                                    // },
                                  ],
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(height: 12.h);
                              },
                            ),
                            SizedBox(
                              height: 20.h,
                            )
                          ],
                        ),
                      ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        color: Colors.transparent,
                        child: SearchBar(
                          isSubmitted: (value) {
                            search = value;
                            _bkdSisterBloc.add(GetBKDSisterEvent(
                                nidn: state.nidn, judul: value, sortBy: sort));
                          },
                          controller: textEditingController,
                          margin: EdgeInsets.symmetric(
                              vertical: 4.h, horizontal: 16.w),
                          openKeyboard: true,
                          hintText: 'Cari Penilaian...',
                          searchType: TypeSearchBar.regular,
                        ),
                      ),
                      SizedBox(
                        height: 20.w,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 16.w),
                          child: DropDownSister(
                            items: [
                              "Periode: Ganjil",
                              "Periode: Genap",
                              "Nama: A-Z",
                              "Nama: Z-A",
                              "Perguruan Tinggi: A-Z",
                              "Perguruan Tinggi: Z-A",

                              "Prodi: A-Z",
                              "Prodi: Z-A",
                              // "Urutan Asesor: ke-1",
                              // "Urutan Asesor: ke-2",
                              "Sudah dinilai",
                              "Belum dinilai"
                            ],
                            value: _selectedValue == null
                                ? "Nama: A-Z"
                                : _selectedValue == ''
                                    ? "Nama: A-Z"
                                    : _selectedValue.toString(),
                            onChanged: (value) {
                              setState(() {
                                sort = value == 'Periode: Ganjil'
                                    ? 'periode-ganjil'
                                    : value == 'Periode: Genap'
                                        ? 'periode-genap'
                                        : value == 'Nama: Z-A'
                                            ? 'nama-desc'
                                            : value == 'Perguruan Tinggi: A-Z'
                                                ? 'perguruan-tinggi-asc'
                                                : value ==
                                                        'Perguruan Tinggi: Z-A'
                                                    ? 'perguruan-tinggi-desc'
                                                    : value == 'Prodi: A-Z'
                                                        ? 'prodi-asc'
                                                        : value == 'Prodi: Z-A'
                                                            ? 'prodi-desc'
                                                            : value ==
                                                                    'Sudah dinilai'
                                                                ? 'sudah-dinilai'
                                                                : value ==
                                                                        'Belum dinilai'
                                                                    ? 'belum-dinilai'
                                                                    : 'nama-asc';
                                _selectedValue = value as String;

                                print(value);
                                _bkdSisterBloc.add(GetBKDSisterEvent(
                                    nidn: state.nidn,
                                    judul: search,
                                    sortBy: sort.toString()));
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.w,
                      ),
                      state.bkdPenilaianData.isEmpty
                          ? EmptyDataPage()
                          : ListView.separated(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: state.bkdPenilaianData.length < 10
                                  ? state.bkdPenilaianData.length
                                  : 10,
                              itemBuilder: (context, i) {
                                return AccordionCard(
                                  title: state.bkdPenilaianData[i].namaNidn
                                              .toString() !=
                                          ''
                                      ? state.bkdPenilaianData[i].namaNidn
                                          .toString()
                                      : '-',
                                  date: state.bkdPenilaianData[i].semester
                                              .toString() !=
                                          ''
                                      ? state.bkdPenilaianData[i].semester
                                          .toString()
                                      : '-',
                                  content: [
                                    {
                                      'nama': "Periode",
                                      "info": state.bkdPenilaianData[i].semester
                                                  .toString() !=
                                              ''
                                          ? state.bkdPenilaianData[i].semester
                                              .toString()
                                          : '-'
                                    },
                                    {
                                      'nama': "Nama/NIDN",
                                      "info": state.bkdPenilaianData[i].namaNidn
                                                  .toString() !=
                                              ''
                                          ? state.bkdPenilaianData[i].namaNidn
                                              .toString()
                                          : '-'
                                    },
                                    {
                                      'nama': "Perguruan Tinggi",
                                      "info": state.bkdPenilaianData[i].namaPt
                                                  .toString() !=
                                              ''
                                          ? state.bkdPenilaianData[i].namaPt
                                              .toString()
                                          : '-'
                                    },
                                    {
                                      'nama': "Prodi",
                                      "info": state
                                                  .bkdPenilaianData[i].namaProdi
                                                  .toString() !=
                                              ''
                                          ? state.bkdPenilaianData[i].namaProdi
                                              .toString()
                                          : '-'
                                    },
                                    {
                                      'nama': "Urutan Asesor",
                                      "info": state.bkdPenilaianData[i].urutan
                                                  .toString() !=
                                              ''
                                          ? state.bkdPenilaianData[i].urutan
                                              .toString()
                                          : '-'
                                    },
                                    {
                                      'nama': "Status Penilaian",
                                      "info": 'Belum Dinilai'
                                    },
                                  ],
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(height: 12.h);
                              },
                            ),
                      SizedBox(height: 20.h)
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      }
    } else {
      if (state is BKDSisterNoInternetState) {
        return Container(
          color: Colors.transparent,
          height: screenHeight(context) * 0.5,
          child: NoInternet(
              onPressed: () {
                _bkdSisterBloc.add(GetBKDSisterEvent(
                    nidn: state.nidn, judul: search, sortBy: sort));
              },
              buttonHide: false),
        );
      } else if (state is BKDSisterNotFoundState) {
        return EmptyDataPage();
      } else if (state is BKDSisterErrorState) {
        return Container(
          color: Colors.transparent,
          height: screenHeight(context) * 0.5,
          child: ServerProblem(
              onPressed: () {
                _bkdSisterBloc.add(GetBKDSisterEvent(
                    nidn: state.nidn, judul: search, sortBy: sort));
              },
              buttonHide: false),
        );
      } else {
        return Container(
          color: Colors.transparent,
          height: screenHeight(context) * 0.5,
          child: ServerProblem(
              onPressed: () {
                _bkdSisterBloc.add(GetBKDSisterEvent(
                    nidn: _bkdSisterBloc.nidn, judul: search, sortBy: sort));
              },
              buttonHide: false),
        );
      }
    }
  }
}
