import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/component/server_problem.dart';
import 'package:app/presentation/pages/beranda/sister/component/accordion_card.dart';
import 'package:app/presentation/pages/beranda/sister/component/data_found_card.dart';
import 'package:app/presentation/pages/beranda/sister/component/detail_card.dart';
import 'package:app/presentation/pages/beranda/sister/component/empty_data.dart';
import 'package:app/presentation/pages/beranda/sister/component/skeleton_loading_sister_tabbar.dart';
import 'package:app/presentation/pages/beranda/sister/component/tabbar_scroll.dart';
import 'package:app/presentation/pages/beranda/sister/component/tabbarviewsister.dart';
import 'package:app/presentation/pages/beranda/sister/pendidikan/bloc/pendidikan_formal_dosen/pendidikan_formal_sister_bloc.dart';
import 'package:app/presentation/pages/faq/bloc/faq_module/faqmodule_bloc.dart';
import 'package:app/presentation/pages/faq/faq_page_per_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../component/search/searchBar.dart';
import '../component/dropdown_sister.dart';

class PendidikanPage extends StatefulWidget {
  const PendidikanPage({Key? key}) : super(key: key);

  @override
  State<PendidikanPage> createState() => _PendidikanPageState();
}

class _PendidikanPageState extends State<PendidikanPage> {
  TextEditingController textEditingControllerTabdiklat =
      TextEditingController();
  TextEditingController textEditingControllerTabpengajaran =
      TextEditingController();
  TextEditingController textEditingControllerTabpembimbingan =
      TextEditingController();
  TextEditingController textEditingControllerTabpengujian =
      TextEditingController();
  int tabIndex = 0;
  String diklatSearch = "";
  String diklatSort = "";
  String pengajarSearch = "";
  String pengajarSort = "";
  String pembimbinganSearch = "";
  String pembimbinganSort = "";
  String pengujianSearch = "";
  String pengujianSort = "";
  bool searchPembimbinganis = false;
  @override
  void dispose() {
    textEditingControllerTabdiklat.dispose();
    textEditingControllerTabpembimbingan.dispose();
    textEditingControllerTabpengajaran.dispose();
    textEditingControllerTabpengujian.dispose();
    super.dispose();
  }

  late PendidikanSisterBloc _pendidikanSisterBloc;
  String? _selectedValue;
  String? _selectedValue1;
  String? _selectedValue2;
  String? _selectedValue3;

  int _currentTabIndex = 0;
  void _handleTabIndexChanged(int index) {
    setState(() {
      _currentTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PendidikanSisterBloc, PendidikanSisterState>(
      builder: (context, state) {
        _pendidikanSisterBloc = BlocProvider.of<PendidikanSisterBloc>(context);

        if (state is PendidikanNoInternetState) {
          _pendidikanSisterBloc =
              BlocProvider.of<PendidikanSisterBloc>(context);
          return _pendidikanWidgetState(context, state, state.nidn);
        } else if (state is PendidikanSisterErrorState) {
          return _pendidikanWidgetState(context, state, state.nidn);
        } else if (state is PendidikanSisterLoadedState) {
          return _pendidikanWidgetState(context, state, state.nidn);
        } else {
          return _pendidikanWidgetState(context, state, '');
        }
      },
      listener: (context, state) {
        if (state is PendidikanNoInternetState) {
          ScaffoldMessenger.of(context).showSnackBar(noInternet);
        }
      },
    );

    // return _pendidikanWidgetState(context);
  }

  Widget _pendidikanWidgetState(
      BuildContext context, PendidikanSisterState state, String nidn) {
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
        title: "Pendidikan",
      ),
      body: _body(context, state),
    );
  }

  Widget _body(BuildContext context, PendidikanSisterState state) {
    if (state is PendidikanSisterinInitial) {
      return SkeletonLoadingSisterTabBar();
    } else if (state is PendidikanSisterinLoading) {
      return SkeletonLoadingSisterTabBar();
    } else if (state is PendidikanSisterLoadedState) {
      if (state.nidn.isEmpty) {
        return SkeletonLoadingSisterTabBar();
      } else {
        return Column(
          children: [
            TabBarScroll(
              onTabIndexChanged: _handleTabIndexChanged,
              tabGO: _currentTabIndex,
              onTap: (index) {
                _selectedValue = null;
                print(_selectedValue);
                tabIndex = index;
                print("INI TABBAR KE $tabIndex");
              },
              tabs: [
                Tab(
                  child: Text("Pendidikan Formal"),
                ),
                Tab(child: Text("Diklat")),
                Tab(child: Text("Pengajaran")),
                Tab(child: Text("Pembimbingan")),
                Tab(child: Text("Pengujian")),
              ],
              tabview: [
                // pendidikan formal
                state.pendidikanFormalDosenSister.isEmpty
                    ? EmptyDataPage()
                    : SingleChildScrollView(
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.pendidikanFormalDosenSister.length,
                          itemBuilder: (context, index) {
                            return AccordionCard(
                              title: state.pendidikanFormalDosenSister[index]
                                  .jenjangDidik,
                              date: '',
                              content: [
                                {
                                  'nama': "Gelar",
                                  "info": state
                                      .pendidikanFormalDosenSister[index].gelar
                                },
                                {
                                  'nama': "Bidang Studi",
                                  "info": state
                                      .pendidikanFormalDosenSister[index]
                                      .bidangStudi
                                },
                                {
                                  'nama': "Perguruan Tinggi",
                                  "info": state
                                      .pendidikanFormalDosenSister[index]
                                      .perguruanTinggi
                                },
                                {
                                  'nama': "Tahun Lulus",
                                  "info": state
                                      .pendidikanFormalDosenSister[index]
                                      .tahunLulus
                                      .toString()
                                },
                              ],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(height: 12.h);
                          },
                        ),
                      ),

                // diklat
                state.pendidikanDiklatSister.isEmpty
                    ? ListView(
                        children: [
                          Container(
                            color: Colors.transparent,
                            child: SearchBar(
                              margin: EdgeInsets.symmetric(
                                  vertical: 4.h, horizontal: 16.w),
                              openKeyboard: true,
                              hintText: 'Cari diklat...',
                              searchType: TypeSearchBar.withClear,
                              controller: textEditingControllerTabdiklat,
                              isSubmitted: (value) {
                                diklatSearch = value;
                                _pendidikanSisterBloc.add(
                                    GetPendidikanSisterEvent(
                                        nidn: state.nidn,
                                        displayByDiklat: diklatSort,
                                        judulDIklat: value));
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          EmptyDataPage(),
                        ],
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              color: Colors.transparent,
                              child: SearchBar(
                                margin: EdgeInsets.symmetric(
                                    vertical: 4.h, horizontal: 16.w),
                                openKeyboard: true,
                                hintText: 'Cari diklat...',
                                searchType: TypeSearchBar.withClear,
                                controller: textEditingControllerTabdiklat,
                                isSubmitted: (value) {
                                  diklatSearch = value;
                                  _pendidikanSisterBloc.add(
                                      GetPendidikanSisterEvent(
                                          nidn: state.nidn,
                                          displayByDiklat: diklatSort,
                                          judulDIklat: value));
                                },
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
                                    "Nama Diklat: A-Z",
                                    "Nama Diklat: Z-A",
                                    "Jenis Diklat: A-Z",
                                    "Jenis Diklat: Z-A",
                                    "Tahun: Terkini",
                                    "Tahun: Terdahulu"
                                  ],
                                  value: _selectedValue == null
                                      ? "Nama Diklat: A-Z"
                                      : _selectedValue == ''
                                          ? "Nama Diklat: A-Z"
                                          : _selectedValue.toString(),
                                  onChanged: (value) {
                                    setState(() {
                                      diklatSort = value == "Nama Diklat: Z-A"
                                          ? "nama-desc"
                                          : value == "Jenis Diklat: A-Z"
                                              ? "jenis-asc"
                                              : value == "Jenis DIklat: Z-A"
                                                  ? "jenis-desc"
                                                  : value == "Tahun: Terkini"
                                                      ? "tahun-desc"
                                                      : value ==
                                                              "Tahun: Terdahulu"
                                                          ? "tahun-asc"
                                                          : "nama-asc";
                                      diklatSort = value.toString();
                                      _selectedValue = value as String;
                                      print(value);
                                      _pendidikanSisterBloc.add(
                                          GetPendidikanSisterEvent(
                                              nidn: state.nidn,
                                              displayByDiklat: diklatSort,
                                              judulDIklat: diklatSearch));
                                    });
                                  },
                                ),
                              ),
                            ),
                            state.pendidikanDiklatSister.isEmpty
                                ? EmptyDataPage()
                                : ListView.separated(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount:
                                        state.pendidikanDiklatSister.length,
                                    itemBuilder: (context, index) {
                                      return CardDiklat(
                                        nama: state
                                            .pendidikanDiklatSister[index].nama,
                                        jenis: state
                                            .pendidikanDiklatSister[index]
                                            .jenis,
                                        penyelenggara: state
                                            .pendidikanDiklatSister[index]
                                            .penyelenggara,
                                        date: state
                                            .pendidikanDiklatSister[index].tahun
                                            .toString(),
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return SizedBox(height: 12.h);
                                    },
                                  ),
                          ],
                        ),
                      ),

                // pengajaran
                state.pendidikanPengajaran.isEmpty
                    ? ListView(
                        children: [
                          Container(
                            color: Colors.transparent,
                            child: SearchBar(
                              isSubmitted: (value) {
                                pengajarSearch = value;
                                _pendidikanSisterBloc.add(
                                    GetPendidikanSisterEvent(
                                        nidn: state.nidn,
                                        displayByPengajaran: pengajarSort,
                                        matkulPengajaran: value));
                              },
                              controller: textEditingControllerTabpengajaran,
                              margin: EdgeInsets.symmetric(
                                  vertical: 4.h, horizontal: 16.w),
                              openKeyboard: false,
                              hintText: 'Cari pengajaran...',
                              searchType: TypeSearchBar.withClear,
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          EmptyDataPage(),
                        ],
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              color: Colors.transparent,
                              child: SearchBar(
                                isSubmitted: (value) {
                                  pengajarSearch = value;
                                  _pendidikanSisterBloc.add(
                                      GetPendidikanSisterEvent(
                                          nidn: state.nidn,
                                          displayByPengajaran: pengajarSort,
                                          matkulPengajaran: value));
                                },
                                controller: textEditingControllerTabpengajaran,
                                margin: EdgeInsets.symmetric(
                                    vertical: 4.h, horizontal: 16.w),
                                openKeyboard: false,
                                hintText: 'Cari pengajaran...',
                                searchType: TypeSearchBar.withClear,
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
                                    "Semester: Terdahulu",
                                    "Semester: Terkini",
                                    "Perguruan Tinggi: A-Z",
                                    "Perguruan Tinggi: Z-A",
                                    "Mata Kuliah: A-Z",
                                    "Mata Kuliah: Z-A",
                                    "Kelas: Angka Terkecil",
                                    "Kelas: Angka Terbesar",
                                    "Unit: A-Z",
                                    "Unit: Z-A",
                                    "Jumlah Mahasiswa: Terkecil",
                                    "Jumlah Mahasiswa: Terbesar",
                                    "SKS: Terkecil",
                                    "SKS: Terbesar",
                                  ],
                                  value: _selectedValue1 == null
                                      ? "Semester: Terkini"
                                      : _selectedValue1 == ''
                                          ? "Semester: Terkini"
                                          : _selectedValue1.toString(),
                                  onChanged: (value) {
                                    setState(() {
                                      pengajarSort = value ==
                                              "Semester: Terdahulu"
                                          ? "semester-asc"
                                          : value == "Perguruan Tinggi: A-Z"
                                              ? "perguruan-tinggi-asc"
                                              : value == "Perguruan Tinggi: Z-A"
                                                  ? "perguruan-tinggi-desc"
                                                  : value == "Mata Kuliah: A-Z"
                                                      ? "mata-kuliah-asc"
                                                      : value ==
                                                              "Mata Kuliah: Z-A"
                                                          ? "mata-kuliah-desc"
                                                          : value ==
                                                                  "Kelas: Angka Terkecil"
                                                              ? "kelas-asc"
                                                              : value ==
                                                                      "Kelas: Angka Terbesar"
                                                                  ? "kelas-desc"
                                                                  : value ==
                                                                          "Unit: A-Z"
                                                                      ? "unit-asc"
                                                                      : value ==
                                                                              "Unit: Z-A"
                                                                          ? "unit-desc"
                                                                          : value == "Jumlah Mahasiswa: Terkecil"
                                                                              ? "jml-mahasiswa-asc"
                                                                              : value == "Jumlah Mahasiswa: Terbesar"
                                                                                  ? "jml-mahasiswa-desc"
                                                                                  : value == "SKS: Terkecil"
                                                                                      ? "sks-asc"
                                                                                      : value == "SKS: Terkecil"
                                                                                          ? "sks-desc"
                                                                                          : "semester-desc";
                                      _selectedValue1 = value as String;
                                      print(value);
                                      _pendidikanSisterBloc.add(
                                          GetPendidikanSisterEvent(
                                              nidn: state.nidn,
                                              matkulPengajaran: pengajarSearch,
                                              displayByPengajaran:
                                                  pengajarSort));
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.w,
                            ),
                            ListView.separated(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: state.pendidikanPengajaran.length < 5
                                  ? state.pendidikanPengajaran.length
                                  : 5,
                              itemBuilder: (context, index) {
                                return AccordionCard(
                                  title:
                                      state.pendidikanPengajaran[index].namaMk,
                                  date: state
                                      .pendidikanPengajaran[index].semester,
                                  content: [
                                    {
                                      'nama': "Perguruan Tinggi",
                                      "info": state.pendidikanPengajaran[index]
                                          .perguruanTinggi
                                    },
                                    {
                                      'nama': "Kelas",
                                      "info": state
                                          .pendidikanPengajaran[index].kelas
                                    },
                                    {
                                      'nama': 'Unit',
                                      'info': (state.pendidikanPengajaran[index]
                                              .unit.nama) +
                                          "(" +
                                          (state.pendidikanPengajaran[index]
                                              .unit.jenjangDidik) +
                                          ")"
                                    },
                                    {
                                      'nama': 'Jumlah Mahasiswa',
                                      'info': state
                                          .pendidikanPengajaran[index].jmlMhs
                                    },
                                    {
                                      'nama': 'SKS',
                                      'info': state
                                          .pendidikanPengajaran[index].sksAjar
                                    }
                                  ],
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(height: 12.h);
                              },
                            ),
                          ],
                        ),
                      ),
                // // pembimbingan
                state.pendidikanPembimbingan.isEmpty
                    ? ListView(
                        children: [
                          Container(
                            color: Colors.transparent,
                            child: SearchBar(
                              isSubmitted: (value) {
                                pembimbinganSearch = value;
                                value == ''
                                    ? searchPembimbinganis = false
                                    : searchPembimbinganis = true;
                                _pendidikanSisterBloc.add(
                                    GetPendidikanSisterEvent(
                                        nidn: state.nidn,
                                        displayByPembimbingan: pembimbinganSort,
                                        judulPembimbingan: value));
                              },
                              controller: textEditingControllerTabpembimbingan,
                              margin: EdgeInsets.symmetric(
                                  vertical: 4.h, horizontal: 16.w),
                              openKeyboard: false,
                              hintText: 'Cari pembimbingan...',
                              searchType: TypeSearchBar.withClear,
                            ),
                          ),
                          EmptyDataPage(),
                        ],
                      )
                    : state.pendidikanPembimbingan.length == 1
                        ? ListView(
                            children: [
                              Container(
                                color: Colors.transparent,
                                child: SearchBar(
                                  isSubmitted: (value) {
                                    pembimbinganSearch = value;
                                    value == ''
                                        ? searchPembimbinganis = false
                                        : searchPembimbinganis = true;
                                    _pendidikanSisterBloc.add(
                                        GetPendidikanSisterEvent(
                                            nidn: state.nidn,
                                            displayByPembimbingan:
                                                pembimbinganSort,
                                            judulPembimbingan: value));
                                  },
                                  controller:
                                      textEditingControllerTabpembimbingan,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 4.h, horizontal: 16.w),
                                  openKeyboard: false,
                                  hintText: 'Cari pembimbingan...',
                                  searchType: TypeSearchBar.withClear,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 20.h),
                                child: DataFoundCard(
                                  judulSkripsi:
                                      state.pendidikanPembimbingan[0].judul,
                                ),
                              ),
                              TabBarViewSister(
                                data: [
                                  {
                                    'nama': 'Semester',
                                    'info': state
                                        .pendidikanPembimbingan[0].semester,
                                  },
                                  {
                                    'nama': 'Jenis Aktiivtas',
                                    'info': state.pendidikanPembimbingan[0]
                                        .jenisAktivitas,
                                  },
                                  {
                                    'nama': 'Judul',
                                    'info':
                                        state.pendidikanPembimbingan[0].judul,
                                  },
                                  {
                                    'nama': 'Lokasi',
                                    'info':
                                        state.pendidikanPembimbingan[0].lokasi,
                                  },
                                  {
                                    'nama': 'No. SK',
                                    'info': state.pendidikanPembimbingan[0]
                                                .nmrSk !=
                                            ''
                                        ? state.pendidikanPembimbingan[0].nmrSk
                                        : '-',
                                  },
                                  {
                                    'nama': 'Tanggal SK',
                                    'info':
                                        state.pendidikanPembimbingan[0].tglSk,
                                  },
                                  {
                                    'nama': 'Prodi',
                                    'info': state.pendidikanPembimbingan[0]
                                            .prodi.nama +
                                        " (${state.pendidikanPembimbingan[0].prodi.jenjangDidik})",
                                  },
                                ],
                              ),
                            ],
                          )
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  color: Colors.transparent,
                                  child: SearchBar(
                                    isSubmitted: (value) {
                                      pembimbinganSearch = value;
                                      value == ''
                                          ? searchPembimbinganis = false
                                          : searchPembimbinganis = true;
                                      _pendidikanSisterBloc.add(
                                          GetPendidikanSisterEvent(
                                              nidn: state.nidn,
                                              displayByPembimbingan:
                                                  pembimbinganSort,
                                              judulPembimbingan: value));
                                    },
                                    controller:
                                        textEditingControllerTabpembimbingan,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 4.h, horizontal: 16.w),
                                    openKeyboard: false,
                                    hintText: 'Cari pembimbingan...',
                                    searchType: TypeSearchBar.withClear,
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
                                        "Semester: Terdahulu",
                                        "Semester: Terkini",
                                        "Perguruan Tinggi: A-Z",
                                        "Perguruan Tinggi: Z-A",
                                        "Mata Kuliah: A-Z",
                                        "Mata Kuliah: Z-A",
                                        "Kelas: Angka Terkecil",
                                        "Kelas: Angka Terbesar",
                                        "Unit: A-Z",
                                        "Unit: Z-A",
                                        "Jumlah Mahasiswa: Terkecil",
                                        "Jumlah Mahasiswa: Terbesar",
                                        "SKS: Terkecil",
                                        "SKS: Terbesar",
                                      ],
                                      value: _selectedValue2 == null
                                          ? "Semester: Terkini"
                                          : _selectedValue2 == ''
                                              ? "Semester: Terkini"
                                              : _selectedValue2.toString(),
                                      onChanged: (value) {
                                        setState(() {
                                          pembimbinganSort = value ==
                                                  "Semester: Terdahulu"
                                              ? "semester-asc"
                                              : value == "Perguruan Tinggi: A-Z"
                                                  ? "perguruan-tinggi-asc"
                                                  : value ==
                                                          "Perguruan Tinggi: Z-A"
                                                      ? "perguruan-tinggi-desc"
                                                      : value ==
                                                              "Mata Kuliah: A-Z"
                                                          ? "mata-kuliah-asc"
                                                          : value ==
                                                                  "Mata Kuliah: Z-A"
                                                              ? "mata-kuliah-desc"
                                                              : value ==
                                                                      "Kelas: Angka Terkecil"
                                                                  ? "kelas-asc"
                                                                  : value ==
                                                                          "Kelas: Angka Terbesar"
                                                                      ? "kelas-desc"
                                                                      : value ==
                                                                              "Unit: A-Z"
                                                                          ? "unit-asc"
                                                                          : value == "Unit: Z-A"
                                                                              ? "unit-desc"
                                                                              : value == "Jumlah Mahasiswa: Terkecil"
                                                                                  ? "jml-mahasiswa-asc"
                                                                                  : value == "Jumlah Mahasiswa: Terbesar"
                                                                                      ? "jml-mahasiswa-desc"
                                                                                      : value == "SKS: Terkecil"
                                                                                          ? "sks-asc"
                                                                                          : value == "SKS: Terkecil"
                                                                                              ? "sks-desc"
                                                                                              : "semester-desc";
                                          _selectedValue2 = value as String;
                                          print(value);
                                          _pendidikanSisterBloc.add(
                                              GetPendidikanSisterEvent(
                                                  nidn: state.nidn,
                                                  judulPembimbingan:
                                                      pembimbinganSearch,
                                                  displayByPembimbingan:
                                                      pembimbinganSort));
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.w,
                                ),
                                ListView.separated(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount:
                                      state.pendidikanPembimbingan.length,
                                  itemBuilder: (context, index) {
                                    return AccordionCard(
                                      title: state
                                          .pendidikanPembimbingan[index].judul,
                                      date: state.pendidikanPembimbingan[index]
                                          .jenisAktivitas,
                                      content: [
                                        {
                                          'nama': 'Semester',
                                          'info': state
                                              .pendidikanPembimbingan[index]
                                              .semester
                                        },
                                        {
                                          'nama': 'Lokasi',
                                          'info': state
                                              .pendidikanPembimbingan[index]
                                              .lokasi
                                        },
                                        {
                                          'nama': 'No. SK',
                                          'info': state
                                              .pendidikanPembimbingan[index]
                                              .nmrSk
                                        },
                                        {
                                          'nama': 'Tanggal SK',
                                          'info': state
                                              .pendidikanPembimbingan[index]
                                              .tglSk
                                        },
                                        {
                                          'nama': 'Keterangan Kegiatan',
                                          'info': state
                                              .pendidikanPembimbingan[index]
                                              .ketKegiatan
                                        },
                                        {
                                          'nama': 'Kategori Kegiatan',
                                          'info': state
                                              .pendidikanPembimbingan[index]
                                              .katKegiatan
                                        },
                                        {
                                          'nama': 'Prodi',
                                          'info': (state
                                              .pendidikanPembimbingan[index]
                                              .prodi
                                              .nama)
                                        }
                                      ],
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(height: 12.h);
                                  },
                                ),
                              ],
                            ),
                          ),
                // // pengujian
                state.pendidikanPengujian.isEmpty
                    ? ListView(
                        children: [
                          Container(
                            color: Colors.transparent,
                            child: SearchBar(
                              isSubmitted: (value) {
                                pengujianSearch = value;
                                _pendidikanSisterBloc.add(
                                    GetPendidikanSisterEvent(
                                        nidn: state.nidn,
                                        displayByPengujian: pengujianSort,
                                        judulPengujian: value));
                              },
                              controller: textEditingControllerTabpengujian,
                              margin: EdgeInsets.symmetric(
                                  vertical: 4.h, horizontal: 16.w),
                              openKeyboard: false,
                              hintText: 'Cari pengujian...',
                              searchType: TypeSearchBar.withClear,
                            ),
                          ),
                          EmptyDataPage(),
                        ],
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              color: Colors.transparent,
                              child: SearchBar(
                                isSubmitted: (value) {
                                  pengujianSearch = value;
                                  _pendidikanSisterBloc.add(
                                      GetPendidikanSisterEvent(
                                          nidn: state.nidn,
                                          displayByPengujian: pengujianSort,
                                          judulPengujian: value));
                                },
                                controller: textEditingControllerTabpengujian,
                                margin: EdgeInsets.symmetric(
                                    vertical: 4.h, horizontal: 16.w),
                                openKeyboard: false,
                                hintText: 'Cari pengujian...',
                                searchType: TypeSearchBar.withClear,
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
                                    "Semester: Terdahulu",
                                    "Semester: Terkini",
                                    "Perguruan Tinggi: A-Z",
                                    "Perguruan Tinggi: Z-A",
                                    "Mata Kuliah: A-Z",
                                    "Mata Kuliah: Z-A",
                                    "Kelas: Angka Terkecil",
                                    "Kelas: Angka Terbesar",
                                    "Unit: A-Z",
                                    "Unit: Z-A",
                                    "Jumlah Mahasiswa: Terkecil",
                                    "Jumlah Mahasiswa: Terbesar",
                                    "SKS: Terkecil",
                                    "SKS: Terbesar",
                                  ],
                                  value: _selectedValue3 == null
                                      ? "Semester: Terkini"
                                      : _selectedValue3 == ''
                                          ? "Semester: Terkini"
                                          : _selectedValue3.toString(),
                                  onChanged: (value) {
                                    setState(() {
                                      pengujianSort = value ==
                                              "Semester: Terdahulu"
                                          ? "semester-asc"
                                          : value == "Perguruan Tinggi: A-Z"
                                              ? "perguruan-tinggi-asc"
                                              : value == "Perguruan Tinggi: Z-A"
                                                  ? "perguruan-tinggi-desc"
                                                  : value == "Mata Kuliah: A-Z"
                                                      ? "mata-kuliah-asc"
                                                      : value ==
                                                              "Mata Kuliah: Z-A"
                                                          ? "mata-kuliah-desc"
                                                          : value ==
                                                                  "Kelas: Angka Terkecil"
                                                              ? "kelas-asc"
                                                              : value ==
                                                                      "Kelas: Angka Terbesar"
                                                                  ? "kelas-desc"
                                                                  : value ==
                                                                          "Unit: A-Z"
                                                                      ? "unit-asc"
                                                                      : value ==
                                                                              "Unit: Z-A"
                                                                          ? "unit-desc"
                                                                          : value == "Jumlah Mahasiswa: Terkecil"
                                                                              ? "jml-mahasiswa-asc"
                                                                              : value == "Jumlah Mahasiswa: Terbesar"
                                                                                  ? "jml-mahasiswa-desc"
                                                                                  : value == "SKS: Terkecil"
                                                                                      ? "sks-asc"
                                                                                      : value == "SKS: Terkecil"
                                                                                          ? "sks-desc"
                                                                                          : "semester-desc";
                                      _selectedValue3 = value as String;
                                      print(value);
                                      _pendidikanSisterBloc
                                          .add(GetPendidikanSisterEvent(
                                        nidn: state.nidn,
                                        judulPengujian: pengujianSearch,
                                        displayByPengujian: pengujianSort,
                                      ));
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.w,
                            ),
                            state.pendidikanPengujian.isEmpty
                                ? EmptyDataPage()
                                : ListView.separated(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: state.pendidikanPengujian.length,
                                    itemBuilder: (context, index) {
                                      return AccordionCard(
                                        title: state
                                            .pendidikanPengujian[index].judul,
                                        date: state.pendidikanPengujian[index]
                                            .jenisAktivitas,
                                        content: [
                                          {
                                            'nama': 'Semester',
                                            'info': state
                                                .pendidikanPengujian[index]
                                                .semester
                                          },
                                          {
                                            'nama': 'Lokasi',
                                            'info': state
                                                .pendidikanPengujian[index]
                                                .lokasi
                                          },
                                          {
                                            'nama': 'No. SK',
                                            'info': state
                                                .pendidikanPengujian[index]
                                                .nmrSk
                                          },
                                          {
                                            'nama': 'Tanggal SK',
                                            'info': state
                                                .pendidikanPengujian[index]
                                                .tglSk
                                          },
                                          {
                                            'nama': 'Keterangan Kegiatan',
                                            'info': state
                                                .pendidikanPengujian[index]
                                                .ketKegiatan
                                          },
                                          {
                                            'nama': 'Kategori Kegiatan',
                                            'info': state
                                                .pendidikanPengujian[index]
                                                .ketKegiatan
                                          },
                                          {
                                            'nama': 'Prodi',
                                            'info': state
                                                .pendidikanPengujian[index]
                                                .prodi
                                                .nama
                                          }
                                        ],
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return SizedBox(height: 12.h);
                                    },
                                  ),
                          ],
                        ),
                      ),
              ],
            ),
          ],
        );
      }
    } else {
      if (state is PendidikanNoInternetState) {
        return Center(
          child: NoInternet(
              onPressed: () {
                _pendidikanSisterBloc.add(
                  GetPendidikanSisterEvent(nidn: state.nidn),
                );
              },
              buttonHide: false),
        );
      } else if (state is PendidikanSisterNotFoundState) {
        return Container(
          child: EmptyDataPage(),
        );
      } else if (state is PendidikanSisterErrorState) {
        return Center(
          child: ServerProblem(
              onPressed: () {
                _pendidikanSisterBloc.add(
                  GetPendidikanSisterEvent(nidn: state.nidn),
                );
              },
              buttonHide: false),
        );
      } else {
        return Center(
          child: ServerProblem(
              onPressed: () {
                _pendidikanSisterBloc.add(
                  GetPendidikanSisterEvent(nidn: _pendidikanSisterBloc.nidn),
                );
              },
              buttonHide: false),
        );
      }
    }
    // return Text(state.pendidikanSister[1].bidangStudi);
  }
}
