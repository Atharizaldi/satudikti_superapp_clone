import 'package:app/data/source/remote/model/tableau.dart';
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customSliverBar.dart';
import 'package:app/presentation/component/inkEffect.dart';
import 'package:app/presentation/component/logged_in_card.dart';
import 'package:app/presentation/component/login_card.dart';
import 'package:app/presentation/component/pop_up_alert/pop_up_alert_widgets.dart';
import 'package:app/presentation/component/search/searchBar.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/reusableWidgets/reusableWidgetsCard.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/bloc/perubahan_dosen_tendik_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/bottom_sheet_form/bottom_sheet_form_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/pencarian_bloc/pencarian_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/pencarian_spesifik_bloc/pencarian_spesifik_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/result_spesifik_bloc/result_spesifik_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/bottom_sheet_form/text_field_pddikti.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/pddiktiSearchResult/resultPencarianSpesifik.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/pddiktiSearchResult/resultPencarianSpesifikPT.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/pddiktiSearchResult/resultPencarianSpesifikProdi.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/result_directly_detail/result_directly_detail.dart';
import 'package:app/presentation/pages/beranda/pddikti/cubit/switch_form_type/switch_form_type_cubit.dart';
import 'package:app/presentation/pages/beranda/pddikti/cubit/tab_bar/tab_bar_cubit.dart';
import 'package:app/presentation/pages/beranda/pddikti/pages/cek_status_usulan_dosen/cek_status_usulan_dosen.dart';
import 'package:app/presentation/pages/beranda/pddikti/pages/perubahan_dosen_dan_tendik/daftar_ajuan_perubahan_data_page.dart';
import 'package:app/presentation/pages/beranda/pddikti/pdddiktiSearchPage.dart';
import 'package:app/presentation/pages/beranda/pddikti/pelajari_selengkapnya_pddikti.dart';
import 'package:app/presentation/pages/beranda/sivil/bloc/sivil_bloc.dart';
import 'package:app/presentation/pages/faq/bloc/faq_module/faqmodule_bloc.dart';
import 'package:app/presentation/pages/faq/faq_page_per_module.dart';
import 'package:app/presentation/pages/profil/bloc/profil_bloc.dart';
import 'package:app/presentation/pages/profil/sso/utils/sso_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class PDDiktiMainPage extends StatefulWidget {
  const PDDiktiMainPage({Key? key}) : super(key: key);

  @override
  _PDDiktiMainPageState createState() => _PDDiktiMainPageState();
}

class _PDDiktiMainPageState extends State<PDDiktiMainPage> {
  TextEditingController searchEditingController = new TextEditingController();
  TextEditingController nomorIndukController = new TextEditingController();
  TextEditingController namaController = new TextEditingController();
  TextEditingController namaPerguruanTinggiController =
      new TextEditingController();
  TextEditingController programStudiController = new TextEditingController();
  TextEditingController akreditasiController = new TextEditingController();
  TextEditingController provinsiController = new TextEditingController();
  TextEditingController tipePTController =
      new TextEditingController(text: "semua");
  List<String> kategoriList = [
    'Data Dosen',
    'Data Mahasiswa',
    'Data Perguruan Tinggi',
    'Data Prodi'
  ];

  List<String> listTipePT = ['Semua', 'Negeri', 'Swasta'];
  List<String> listJenjang = ['Semua', 'D3', 'D4', 'S1', 'S2', 'S3'];

  Tableau? tableauList;
  int statistikPT = 0;
  int statistikProdi = 0;
  int statistikDosen = 0;
  int statistikMahasiswa = 0;

  Map<String, String> hasilProvinsi = {'a': 'b'};

  String? kategoriValue;
  String? npm;
  String? namaMahasiswa;
  String? programStudiValue;
  String tipePT = "Semua";
  String tipeJenjang = "Semua";

  var ptKode;
  Map<String, String> selectedPTObject = {"kodePT": ""};
  Map<String, String> selectedProdiObject = {"kodeProdi": ""};
  Map<String, String> selectedProvinsiObject = {"kodeProvinsi": ""};
  var prodiKode;

  @override
  void initState() {
    kategoriValue = kategoriList[0];
    tipePT = listTipePT[0];
    super.initState();
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(gradient: beasiswaBgGradient),
      child: Stack(children: [
        Positioned(
          top: 100.h,
          right: -8.w,
          bottom: 14.h,
          // right: 0,
          child: Opacity(
            opacity: 0.60,
            child: Image.asset(
              'assets/sister/sister_homepage_banner.png',
              width: 214.w,
              height: 214.w,
            ),
          ),
        ),
        Positioned(
          left: 30.w,
          bottom: 40.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: AssetImage("assets/pddikti/logo_pddikti.png"),
                width: 100.w,
                height: 31.w,
              ),
              SizedBox(
                height: 12.w,
              ),
              Text(
                "Akses informasi \nData Perguruan Tinggi \ndari mana saja",
                style: TextStyle(
                  color: whiteBgPage,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                  letterSpacing: 0.08.w,
                  height: 1.5,
                ),
              ),
              SizedBox(
                height: 14.w,
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return PelajariSelengkapnyaPDDikti();
                    },
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                        width: 189.w,
                        height: 40.h,
                        padding: EdgeInsets.symmetric(
                            vertical: 6.h, horizontal: 12.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.r),
                            color: bgPelajariSelengkapnya),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Pelajari Selengkapnya",
                              style: stylePelajariSelengkapnya,
                              textAlign: TextAlign.center,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 14.h,
                            )
                          ],
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: blueLinear2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomSliverBar(
          expandedHeight: 280.w,
          header: FlexibleSpaceBar(background: _header()),
          appBarTitle: "PDDikti",
          child: BlocConsumer<PencarianSpesifikBloc, PencarianSpesifikState>(
            listener: (context, state) {
              print('state in listener');
              print(state);
              if (state is PencarianSpesifikLoadedState) {
                hasilProvinsi = BlocProvider.of<PencarianSpesifikBloc>(context)
                    .hasilProvinsi;
                tableauList =
                    BlocProvider.of<PencarianSpesifikBloc>(context).tableauList;
                List<TableauPddikti> list =
                    tableauList?.data.tableauPddikti ?? [];
                if (list.isNotEmpty) {
                  statistikPT = list
                      .firstWhere((element) => element.moduleAtribut == "pt")
                      .moduleValue;
                  statistikProdi = list
                      .firstWhere((element) => element.moduleAtribut == "prodi")
                      .moduleValue;
                  statistikDosen = list
                      .firstWhere((element) => element.moduleAtribut == "dosen")
                      .moduleValue;
                  statistikMahasiswa = list
                      .firstWhere(
                          (element) => element.moduleAtribut == "mahasiswa")
                      .moduleValue;
                  Logger().i(
                      "Statistik pt: $statistikPT, prodi: $statistikProdi, dosen: $statistikDosen, mahasiswa: $statistikMahasiswa");
                }
              } else {
                hasilProvinsi = {};
                tableauList = null;
              }
            },
            builder: (context, state) {
              if (state is PencarianSpesifikNoInternetState) {
                return Column(
                  children: [
                    noInternetWithContainer(),
                    SizedBox(height: 400.h)
                  ],
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BlocBuilder<ProfilBloc, ProfilState>(
                            builder: (context, state) {
                              if (state is ProfilLoadedState) {
                                return GestureDetector(
                                  onTap: () {
                                    if (state.userInformationDetail.role ==
                                        "Dosen") {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BlocProvider(
                                                  create: (context) => di
                                                      .locator<
                                                          ResultSpesifikBloc>()
                                                    ..add(LoadDosenResultEvent(
                                                      category: 1,
                                                      nama: state
                                                          .userInformationDetail
                                                          .nama,
                                                      nomorInduk: state
                                                          .userInformationDetail
                                                          .nidn,
                                                      kodePT: '',
                                                      kodePD: '',
                                                    )),
                                                  child:
                                                      ResultDirectlyDetailMahasiswaDosen(
                                                    category: 1,
                                                    nomorInduk: state
                                                        .userInformationDetail
                                                        .nidn,
                                                  ),
                                                )),
                                      );
                                    } else if (state
                                            .userInformationDetail.role ==
                                        "Mahasiswa") {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BlocProvider(
                                                  create: (context) => di
                                                      .locator<
                                                          ResultSpesifikBloc>()
                                                    ..add(
                                                        LoadMahasiswaResultEvent(
                                                      category: 0,
                                                      nama: state
                                                          .userInformationDetail
                                                          .nama,
                                                      nomorInduk: state
                                                          .userInformationDetail
                                                          .nim,
                                                      kodePT: '',
                                                      kodePD: '',
                                                    )),
                                                  child:
                                                      ResultDirectlyDetailMahasiswaDosen(
                                                    category: 0,
                                                    nomorInduk: state
                                                        .userInformationDetail
                                                        .nim,
                                                  ),
                                                )),
                                      );
                                    }
                                  },
                                  child: LoggedInCard(
                                    avatar: state.userAvatar,
                                    userInformationDetail:
                                        state.userInformationDetail,
                                  ),
                                );
                              } else if (state is ProfilNotLogInState) {
                                return LoginCard(isDosenOnlyModule: false);
                              } else {
                                return LoginCard(isDosenOnlyModule: false);
                              }
                            },
                          ),
                          SizedBox(
                            height: 30.sp,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 52.w,
                                  child: InkWell(
                                    onTap: () => Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return MultiBlocProvider(
                                        providers: [
                                          BlocProvider(
                                            create: (context) =>
                                                di.locator<PencarianBloc>(),
                                          ),
                                          BlocProvider(
                                            create: (context) => TabBarCubit(),
                                          ),
                                        ],
                                        child: PDDiktiSearchPage(),
                                      );
                                    })),
                                    child: IgnorePointer(
                                      child: SearchBar(
                                        controller: searchEditingController,
                                        openKeyboard: false,
                                        hintText: 'Cari data pada PDDikti',
                                        searchType: TypeSearchBar.regular,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15.w,
                              ),
                              InkWell(
                                onTap: () {
                                  bottomSheetPDDikti(context);
                                },
                                child: Container(
                                  width: 52.w,
                                  height: 52.w,
                                  padding: EdgeInsets.all(16.w),
                                  decoration: BoxDecoration(
                                      color: blue4,
                                      borderRadius: BorderRadius.circular(5.r)),
                                  child: Image.asset(
                                    "assets/icons/icon_filter.png",
                                    color: white,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30.sp,
                          ),
                          cardLayananPDDikti(
                            ontap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => BlocProvider(
                              //               create: (context) => di.locator<
                              //                   MajalahDetailGMagzBloc>()
                              //                 ..add(
                              //                     Getmajade),
                              //               child:
                              //                   CekStatusUsulanDosenPageSementaraSampeDiRevisiLagi(),
                              //             )));
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CekStatusUsulanDosen()),
                              );
                            },
                            images:
                                "assets/pddikti/icon_cek_status_usulan_dosen.png",
                            title: "Status Usulan Dosen",
                            description:
                                "Lacak dan pantau perubahan status pengajuan dosen yang telah Anda lakukan melalui SatuDikti lebih mudah dan cepat.",
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          BlocBuilder<ProfilBloc, ProfilState>(
                            builder: (context, state) {
                              if (state is ProfilLoadedState) {
                                return cardLayananPDDikti(
                                  ontap: () {
                                    print("CEK mausk?");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BlocProvider(
                                                  create: (context) => di.locator<
                                                      PerubahanDosenTendikBloc>()
                                                    ..add(FetchPerubahanDosenTendikEvent(
                                                        nidn: state
                                                            .userInformationDetail
                                                            .nidn!)),
                                                  child:
                                                      DaftarUsulanPerubahanDataPDDIKTIPage(),
                                                )));
                                  },
                                  images:
                                      "assets/pddikti/icon_perubahan_dosen_tendik.png",
                                  title: state.userInformationDetail.role ==
                                          "Dosen"
                                      ? "Perubahan Data Dosen"
                                      : "Perubahan Data Mahasiswa",
                                  description:
                                      'Lacak dan pantau status perubahan data yang telah Anda ajukan melalui SatuDikti lebih mudah dan cepat.',
                                );
                              } else if (state is ProfilNotLogInState) {
                                return cardLayananPDDikti(
                                  ontap: () {
                                    cardAlertDialogLogin(context,
                                        "Silahkan login sebagai dosen untuk dapat mengakses seluruh fitur PDDikti",
                                        title:
                                            "Anda Sedang mengakses modul PDDikti",
                                        onTapButton: () async {
                                      authorizationUrl = await createClient();
                                      showSSOLoginPage(
                                          context, authorizationUrl);
                                    });
                                  },
                                  images:
                                      "assets/pddikti/icon_perubahan_dosen_tendik.png",
                                  title: "Perubahan Data Dosen atau Tendik",
                                  description:
                                      'Lacak dan pantau status perubahan data yang telah Anda ajukan melalui SatuDikti lebih mudah dan cepat.',
                                );
                              } else if (state is ProilLoadingState) {
                                return cardLayananPDDikti(
                                  ontap: () {
                                    //no func because loading data sso
                                  },
                                  images:
                                      "assets/pddikti/icon_perubahan_dosen_tendik.png",
                                  title: "Perubahan Data Dosen atau Tendik",
                                  description:
                                      "Program Verifikasi SK penyetaraan ijazah Luar Negeri sesuai jenjang pendidikan yang berlaku di Indonesia",
                                );
                              } else {
                                return SizedBox();
                              }
                            },
                          ),
                          SizedBox(
                            height: 48.sp,
                          ),
                          Text(
                            "Data Statistik pada PDDikti",
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                              color: blue3,
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                        ],
                      ),
                    ),
                    ...rowStatistikMahasiswa(),
                    ...rowStatistikDosen(),
                    ...rowStatistikProdi(),
                    ...rowStatistikPT(),
                    _bannerFAQ(context),
                    SizedBox(
                      height: 28.h,
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _bannerFAQ(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return BlocProvider(
                create: (context) => di.locator<FaqmoduleBloc>()
                  ..add(FetchfaqModuleEvent('pddikti')),
                child: FAQModul(),
              );
            },
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 25.w, horizontal: 15.h),
        width: 358.w,
        child: Card(
          color: blueLinear1,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/faq/faq_icon.png'),
                  ),
                ),
                SizedBox(width: 20.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Butuh Informasi lainnya?",
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.006.sp,
                          color: white),
                    ),
                    SizedBox(
                      height: 10.w,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Lihat FAQ",
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.006.sp,
                              color: white),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Icon(
                          Icons.navigate_next,
                          color: white,
                          size: 16,
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> rowStatistikMahasiswa() {
    return [
      Container(
        width: double.infinity,
        height: 127.w,
        color: Color(0xffC7E7FF),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 16.w,
              child: Image.asset(
                "assets/pddikti/homepage/ilustrasi_mahasiswa.png",
                width: 124.w,
                height: 121.w,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 226.w,
              top: 37.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    statistikMahasiswa.toString() == ""
                        ? "-"
                        : NumberFormat.currency(
                                locale: 'id', decimalDigits: 0, name: '')
                            .format(statistikMahasiswa.toInt()),
                    style: TextStyle(color: Color(0xff118EEA), fontSize: 24.sp),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    "Mahasiswa",
                    style: TextStyle(
                      color: neutral60,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 8.h,
      ),
    ];
  }

  List<Widget> rowStatistikDosen() {
    return [
      Container(
        width: double.infinity,
        height: 127.w,
        color: Color(0xffDFFFF0),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              right: 16.w,
              child: Image.asset(
                "assets/pddikti/homepage/ilustrasi_dosen.png",
                width: 164.w,
                height: 120.w,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 43.w,
              top: 37.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    statistikDosen.toString() == ""
                        ? "-"
                        : NumberFormat.currency(
                                locale: 'id', decimalDigits: 0, name: '')
                            .format(statistikDosen.toInt()),
                    style: TextStyle(color: green3, fontSize: 24.sp),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    "Dosen",
                    style: TextStyle(
                        color: neutral60,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 8.h,
      ),
    ];
  }

  List<Widget> rowStatistikProdi() {
    return [
      Container(
        width: double.infinity,
        height: 127.w,
        color: Color(0x33F0D805),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 16.w,
              child: Image.asset(
                "assets/pddikti/homepage/ilustrasi_prodi.png",
                width: 131.w,
                height: 121.w,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 226.w,
              top: 37.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    statistikProdi.toString() == ""
                        ? "-"
                        : NumberFormat.currency(
                                locale: 'id', decimalDigits: 0, name: '')
                            .format(statistikProdi.toInt()),
                    style: TextStyle(color: Color(0xffFF9800), fontSize: 24.sp),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    "Program Studi",
                    style: TextStyle(
                        color: neutral60,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 8.h,
      ),
    ];
  }

  List<Widget> rowStatistikPT() {
    return [
      Container(
        width: double.infinity,
        height: 127.w,
        color: Color(0xffFFD6CF),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              right: 16.w,
              child: Image.asset(
                "assets/pddikti/homepage/ilustrasi_pt.png",
                width: 171.w,
                height: 116.w,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 43.w,
              top: 37.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    statistikPT.toString() == ""
                        ? "-"
                        : NumberFormat.currency(
                                locale: 'id', decimalDigits: 0, name: '')
                            .format(statistikPT.toInt()),
                    style: TextStyle(
                      color: Color(0xffF66951),
                      fontSize: 24.sp,
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    "Perguruan Tinggi",
                    style: TextStyle(
                        color: neutral60,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 8.h,
      ),
    ];
  }

  double maxChildSize = 0.72;

  Future<dynamic> bottomSheetPDDikti(BuildContext context) {
    return showModalBottomSheet(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12.r))),
        // backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            child: BlocProvider(
              create: (context) => SwitchFormTypeCubit(),
              child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter stateSetter) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(12.r)),
                  ),
                  child: DraggableScrollableSheet(
                      expand: false,
                      initialChildSize: maxChildSize,
                      maxChildSize: 0.95,
                      minChildSize: 0.55,
                      builder: (context, scrollController) {
                        return Scaffold(
                          backgroundColor: whiteBgPage,
                          resizeToAvoidBottomInset: true,
                          body: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            controller: scrollController,
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                horizontal: 36.w,
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 8.sp,
                                  ),
                                  greyIconBar(),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 30.sp,
                                      ),

                                      Text(
                                        "Pencarian Spesifik",
                                        style: TextStyle(
                                          color: blue3,
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 31.5.sp,
                                      ),
                                      // kategori pencarian

                                      rowLabel(
                                        asset:
                                            "assets/icons/pddikti/icon_kategori_pencarian.png",
                                        keterangan: "Kategori Pencarian",
                                        isRequired: true,
                                      ),

                                      BlocBuilder<SwitchFormTypeCubit,
                                          SwitchFormTypeState>(
                                        builder: (context, state) {
                                          return Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    screenWidth(context) *
                                                        (1 / 30)),
                                            margin: EdgeInsets.only(
                                                top: screenHeight(context) *
                                                    (1 / 90)),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: abu6, width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: DropdownButton<String>(
                                              items: kategoriList
                                                  .map(buildMenuItem)
                                                  .toList(),
                                              onChanged: (value) => {
                                                print("VALUE $value"),
                                                BlocProvider.of<
                                                            SwitchFormTypeCubit>(
                                                        context)
                                                    .changeType(value!),
                                                setState(() {
                                                  this.kategoriValue = value;
                                                  namaController.clear();
                                                  nomorIndukController.clear();
                                                  namaPerguruanTinggiController
                                                      .clear();
                                                  programStudiController
                                                      .clear();
                                                  selectedPTObject["kodePT"] =
                                                      "";
                                                  selectedProvinsiObject[
                                                      "kodeProvinsi"] = "";
                                                  selectedProdiObject[
                                                      "kodeProdi"] = "";
                                                }),
                                                di.locator<SivilBloc>()
                                                  ..add(ClearEvent()),
                                                di.locator<
                                                    BottomSheetFormBloc>()
                                                  ..add(ClearProvinsiEvent()),
                                                print(this.kategoriValue)
                                              },
                                              isExpanded: true,
                                              value: this.kategoriValue,
                                              underline: Container(),
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        height:
                                            screenHeight(context) * (1 / 60),
                                      ),
                                      BlocBuilder<SwitchFormTypeCubit,
                                          SwitchFormTypeState>(
                                        builder: (context, state) {
                                          print("State curr $state");
                                          return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: switchForm(
                                                  state, stateSetter));
                                        },
                                      ),
                                      BlocBuilder<SwitchFormTypeCubit,
                                          SwitchFormTypeState>(
                                        builder: (context, state) {
                                          return GestureDetector(
                                            onTap: () {
                                              if (state
                                                  is SwitchFormTypeMahasiswa) {
                                                if (nomorIndukController
                                                        .text.isNotEmpty &&
                                                    namaController
                                                        .text.isNotEmpty &&
                                                    kategoriValue ==
                                                        kategoriList[1]) {
                                                  print(
                                                      "ONTAPCARI MAHASISWA ${selectedPTObject["kodePT"]}");
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                    return BlocProvider(
                                                      create: (context) => di
                                                          .locator<
                                                              ResultSpesifikBloc>()
                                                        ..add(
                                                            LoadMahasiswaResultEvent(
                                                          category:
                                                              switchCategoryToInt(
                                                                  this.kategoriValue!),
                                                          nama: namaController
                                                              .text,
                                                          nomorInduk:
                                                              nomorIndukController
                                                                  .text,
                                                          kodePT: selectedPTObject[
                                                                      "kodePT"] ==
                                                                  null
                                                              ? ''
                                                              : selectedPTObject[
                                                                  "kodePT"],
                                                          kodePD: selectedProdiObject[
                                                                      "kodeProdi"] ==
                                                                  null
                                                              ? ''
                                                              : selectedProdiObject[
                                                                  "kodeProdi"],
                                                        )),
                                                      child:
                                                          ResultPencarianMahasiswaDosen(
                                                        category:
                                                            switchCategoryToInt(
                                                                this.kategoriValue!),
                                                        nama:
                                                            namaController.text,
                                                        nomorInduk:
                                                            nomorIndukController
                                                                .text,
                                                        kodePT: selectedPTObject[
                                                                    "kodePT"] ==
                                                                null
                                                            ? ''
                                                            : selectedPTObject[
                                                                "kodePT"],
                                                        kodePD: selectedProdiObject[
                                                                    "kodeProdi"] ==
                                                                null
                                                            ? ''
                                                            : selectedProdiObject[
                                                                "kodeProdi"],
                                                      ),
                                                    );
                                                  })).then((value) {
                                                    namaController.clear();
                                                    nomorIndukController
                                                        .clear();
                                                    namaPerguruanTinggiController
                                                        .clear();
                                                    programStudiController
                                                        .clear();
                                                    ptKode = null;
                                                    prodiKode = null;
                                                    selectedPTObject["kodePT"] =
                                                        "";
                                                    selectedProdiObject[
                                                        "kodeProdi"] = "";
                                                    di.locator<SivilBloc>()
                                                      ..add(ClearEvent());
                                                    stateSetter(() {});
                                                  });
                                                } else {
                                                  print('ada yang kosong');
                                                }
                                              } else if (state
                                                  is SwitchFormTypeDosen) {
                                                if (nomorIndukController
                                                        .text.isNotEmpty &&
                                                    namaController
                                                        .text.isNotEmpty &&
                                                    kategoriValue ==
                                                        kategoriList[0]) {
                                                  print(
                                                      "tap cari on SwitchFormTypeDosen");
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                    return BlocProvider(
                                                      create: (context) => di
                                                          .locator<
                                                              ResultSpesifikBloc>()
                                                        ..add(
                                                            LoadDosenResultEvent(
                                                          category:
                                                              switchCategoryToInt(
                                                                  this.kategoriValue!),
                                                          nama: namaController
                                                              .text,
                                                          nomorInduk:
                                                              nomorIndukController
                                                                  .text,
                                                          kodePT: ptKode == null
                                                              ? ''
                                                              : selectedPTObject[
                                                                  "kodePT"],
                                                          kodePD: selectedProdiObject[
                                                                      "kodeProdi"] ==
                                                                  null
                                                              ? ''
                                                              : selectedProdiObject[
                                                                  "kodeProdi"],
                                                        )),
                                                      child:
                                                          ResultPencarianMahasiswaDosen(
                                                        category:
                                                            switchCategoryToInt(
                                                                this.kategoriValue!),
                                                        nama:
                                                            namaController.text,
                                                        nomorInduk:
                                                            nomorIndukController
                                                                .text,
                                                        kodePT: selectedPTObject[
                                                                    "kodePT"] ==
                                                                null
                                                            ? ''
                                                            : selectedPTObject[
                                                                "kodePT"],
                                                        kodePD: selectedProdiObject[
                                                                    "kodeProdi"] ==
                                                                null
                                                            ? ''
                                                            : selectedProdiObject[
                                                                "kodeProdi"],
                                                      ),
                                                    );
                                                  })).then((value) {
                                                    namaController.clear();
                                                    nomorIndukController
                                                        .clear();
                                                    namaPerguruanTinggiController
                                                        .clear();
                                                    programStudiController
                                                        .clear();
                                                    ptKode = null;
                                                    prodiKode = null;
                                                    selectedPTObject["kodePT"] =
                                                        "";
                                                    selectedProdiObject[
                                                        "kodeProdi"] = "";
                                                    di.locator<SivilBloc>()
                                                      ..add(ClearEvent());
                                                    stateSetter(() {});
                                                  });
                                                } else {
                                                  print('ada yang kosong');
                                                }
                                              } else if (state
                                                  is SwitchFormTypePT) {
                                                if (selectedProvinsiObject[
                                                        "kodeProvinsi"] !=
                                                    "") {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                    return BlocProvider(
                                                      create: (context) => di
                                                          .locator<
                                                              ResultSpesifikBloc>()
                                                        ..add(LoadPTResultEvent(
                                                          kodePT:
                                                              selectedPTObject[
                                                                      "kodePT"] ??
                                                                  "",
                                                          kodeProvinsi:
                                                              selectedProvinsiObject[
                                                                      "kodeProvinsi"] ??
                                                                  "",
                                                          tipePT: tipePT,
                                                        )),
                                                      child: ResultPencarianPT(
                                                        kodePT:
                                                            selectedPTObject[
                                                                    "kodePT"] ??
                                                                "",
                                                        kodeProvinsi:
                                                            selectedProvinsiObject[
                                                                    "kodeProvinsi"] ??
                                                                "",
                                                        tipePT: tipePT,
                                                      ),
                                                    );
                                                  })).then((value) {
                                                    namaPerguruanTinggiController
                                                        .clear();
                                                    provinsiController.clear();
                                                    tipePTController.clear();
                                                    ptKode = null;
                                                    selectedPTObject["kodePT"] =
                                                        "";
                                                    selectedProvinsiObject[
                                                        "kodeProvinsi"] = "";
                                                    di.locator<SivilBloc>()
                                                      ..add(ClearEvent());
                                                    di.locator<
                                                        BottomSheetFormBloc>()
                                                      ..add(
                                                          ClearProvinsiEvent());
                                                    stateSetter(() {});
                                                  });
                                                } else {
                                                  print('ada yang kosong');
                                                }
                                              } else if (state
                                                  is SwitchFormTypeProdi) {
                                                if (programStudiController
                                                    .text.isNotEmpty) {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                    builder: (context) {
                                                      return BlocProvider(
                                                        create: (context) => di
                                                            .locator<
                                                                ResultSpesifikBloc>()
                                                          ..add(
                                                              LoadProdiResultEvent(
                                                            namaProdi:
                                                                programStudiController
                                                                    .text,
                                                            kodePT: selectedPTObject[
                                                                        "kodePT"] ==
                                                                    null
                                                                ? ''
                                                                : selectedPTObject[
                                                                    "kodePT"],
                                                            akreditasi:
                                                                akreditasiController
                                                                    .text,
                                                            jenjang:
                                                                (tipeJenjang ==
                                                                        "Semua")
                                                                    ? ""
                                                                    : tipeJenjang,
                                                          )),
                                                        child: ResultPencarianProdi(
                                                            namaProdi:
                                                                programStudiController
                                                                    .text,
                                                            kodePT: selectedPTObject[
                                                                        "kodePT"] ==
                                                                    null
                                                                ? ''
                                                                : selectedPTObject[
                                                                    "kodePT"],
                                                            akreditasi:
                                                                akreditasiController
                                                                    .text,
                                                            jenjang:
                                                                (tipeJenjang ==
                                                                        "Semua")
                                                                    ? ""
                                                                    : tipeJenjang),
                                                      );
                                                    },
                                                  )).then((value) {
                                                    programStudiController
                                                        .clear();
                                                    namaPerguruanTinggiController
                                                        .clear();
                                                    akreditasiController
                                                        .clear();

                                                    ptKode = null;
                                                    selectedPTObject["kodePT"] =
                                                        "";
                                                    di.locator<SivilBloc>()
                                                      ..add(ClearEvent());
                                                    stateSetter(() {});
                                                  });
                                                }
                                              }

                                              // formkey.currentState!.save();
                                            },
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    top: screenHeight(context) *
                                                        (1 / 50)),
                                                height: screenHeight(context) *
                                                    (1 / 17),
                                                width: screenWidth(context) *
                                                    (1 / 2.5),
                                                decoration: BoxDecoration(
                                                    color: switchButtonColor(
                                                      state,
                                                      blue2,
                                                      buttonDisable,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.r)),
                                                child: Center(
                                                  child: Text(
                                                    'Cari',
                                                    style: TextStyle(
                                                        color:
                                                            switchButtonColor(
                                                          state,
                                                          white,
                                                          textButtonDisable,
                                                        ),
                                                        fontSize: 12.sp,
                                                        letterSpacing: 1,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        height: 30.sp,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                );
              }),
            ),
          );
        }).whenComplete(() {
      kategoriValue = kategoriList[0];
      namaPerguruanTinggiController.clear();
      nomorIndukController.clear();
      namaController.clear();
      programStudiController.clear();
      nomorIndukController.clear();

      akreditasiController.clear();
      provinsiController.clear();
      tipePTController.clear();
      di.locator<SivilBloc>()..add(ClearEvent());
    });
  }

  Color switchButtonColor(
      SwitchFormTypeState state, Color active, Color passive) {
    if ((state is SwitchFormTypeMahasiswa || state is SwitchFormTypeDosen) &&
        nomorIndukController.text.isNotEmpty &&
        namaController.text.isNotEmpty) {
      return active;
    } else if (state is SwitchFormTypePT &&
        provinsiController.text.isNotEmpty) {
      return active;
    } else if (state is SwitchFormTypeProdi &&
        programStudiController.text.isNotEmpty) {
      return active;
    } else {
      return passive;
    }
  }

  Text rowLabel({
    required String asset,
    required String keterangan,
    bool isRequired = false,
  }) {
    return Text.rich(
      TextSpan(children: [
        WidgetSpan(
          child: Image.asset(
            asset,
            width: 16.sp,
            height: 16.sp,
          ),
        ),
        WidgetSpan(
          child: SizedBox(
            width: 8.sp,
          ),
        ),
        TextSpan(text: '$keterangan ', style: subtitleForm, children: [
          isRequired ? asterisk() : WidgetSpan(child: SizedBox()),
        ])
      ]),
      textAlign: TextAlign.center,
    );
  }

  Widget cardLayananPDDikti(
      {required String title,
      required String description,
      required dynamic images,
      required VoidCallback ontap}) {
    return InkEffect(
      boxDecoration: BoxDecoration(
          color: white, borderRadius: BorderRadius.circular(10.r)),
      onTap: ontap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.sp),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            decoration: BoxDecoration(
              color: abuCerah,
              borderRadius: BorderRadius.circular(8.r),
            ),
            width: 64.w,
            height: 64.h,
            padding: EdgeInsets.only(
                left: 16.w, right: 16.w, top: 12.h, bottom: 12.h),
            alignment: Alignment.center,
            child: Image.asset(images),
          ),
          SizedBox(
            width: 20.w,
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: blue4,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 6.sp,
                ),
                Text(
                  description,
                  style: TextStyle(
                      color: teksAbuCerah4,
                      fontSize: 12.sp,
                      letterSpacing: 0.08,
                      height: 1.5),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String e) {
    return DropdownMenuItem(
        value: e,
        child: Text(
          e,
          style: TextStyle(
            fontSize: 14.sp,
          ),
        ));
  }

  dynamic switchCategoryToInt(String kategoriValue) {
    switch (kategoriValue) {
      case 'Data Mahasiswa':
        return 0;
      case 'Data Dosen':
        return 1;
      case 'Data Perguruan Tinggi':
        return 2;
      case 'Data Prodi':
        return 3;
      default:
    }
  }

  dynamic switchForm(SwitchFormTypeState state, StateSetter stateSetter) {
    if (state is SwitchFormTypeMahasiswa) {
      return [
        // NPM
        rowLabel(
          asset: "assets/icons/pddikti/icon_npm.png",
          keterangan: "NPM/NIM",
          isRequired: true,
        ),

        SizedBox(
          height: 13.h,
        ),
        formField(
            "Tuliskan NPM/NIM Anda",
            nomorIndukController,
            (value) => {
                  stateSetter(() {
                    this.npm = value;
                  })
                }),
        SizedBox(
          height: screenHeight(context) * (1 / 60),
        ),

        // nama mahasiswa
        rowLabel(
          asset: "assets/icons/pddikti/icon_mahasiswa.png",
          keterangan: "Nama Mahasiswa",
          isRequired: true,
        ),
        SizedBox(
          height: 13.h,
        ),
        formField(
            'Nama Lengkap',
            namaController,
            (value) => {
                  stateSetter(() {
                    this.namaMahasiswa = value;
                  })
                }),
        SizedBox(
          height: screenHeight(context) * (1 / 60),
        ),

        BlocProvider(
          create: (context) => di.locator<SivilBloc>(),
          child: Builder(builder: (context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // perguruan tinggi
                rowLabel(
                  asset: "assets/icons/ijazahln/icon_pt.png",
                  keterangan: "Nama Perguruan Tinggi",
                ),
                SizedBox(
                  height: 13.h,
                ),
                textFieldPTPDDikti(
                    context, namaPerguruanTinggiController, selectedPTObject),
                SizedBox(
                  height: screenHeight(context) * (1 / 60),
                ),

                // program studi
                rowLabel(
                  asset: "assets/icons/pddikti/icon_prodi.png",
                  keterangan: "Nama Program Studi",
                ),
                SizedBox(
                  height: 13.h,
                ),
                textFieldProdiPDDikti(
                    context, programStudiController, selectedProdiObject),
              ],
            );
          }),
        ),
      ];
    } else if (state is SwitchFormTypeDosen) {
      return [
        // NPM
        rowLabel(
            asset: "assets/icons/pddikti/icon_nidn.png",
            keterangan: "NIDN/NIDK/NUP",
            isRequired: true),

        SizedBox(
          height: 13.h,
        ),
        formField(
            'Tuliskan NIDN/NIDK/NUP Anda',
            nomorIndukController,
            (value) => {
                  stateSetter(() {
                    this.npm = value;
                  }),
                }),
        SizedBox(
          height: screenHeight(context) * (1 / 60),
        ),

        // nama mahasiswa
        rowLabel(
          asset: "assets/icons/pddikti/icon_dosen.png",
          keterangan: "Nama Dosen",
          isRequired: true,
        ),
        SizedBox(
          height: 13.h,
        ),
        formField(
            'Nama Lengkap',
            namaController,
            (value) => {
                  stateSetter(() {
                    this.namaMahasiswa = value;
                  })
                }),
        SizedBox(
          height: screenHeight(context) * (1 / 60),
        ),

        // perguruan tinggi
        BlocProvider(
          create: (context) => di.locator<SivilBloc>(),
          child: Builder(builder: (context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // perguruan tinggi
                rowLabel(
                  asset: "assets/icons/ijazahln/icon_pt.png",
                  keterangan: "Nama Perguruan Tinggi",
                ),
                SizedBox(
                  height: 13.h,
                ),
                textFieldPTPDDikti(
                    context, namaPerguruanTinggiController, selectedPTObject),
              ],
            );
          }),
        ),
      ];
    } else if (state is SwitchFormTypePT) {
      return [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // program studi
            rowLabel(
              asset: "assets/icons/pddikti/icon_provinsi.png",
              keterangan: "Provinsi",
              isRequired: true,
            ),
            SizedBox(
              height: 13.h,
            ),
            // textFieldProdiPDDikti(context, provinsiController),
            BlocProvider(
              create: (context) => di.locator<BottomSheetFormBloc>(),
              child: Builder(builder: (context) {
                return textFieldProvinsi(context, provinsiController,
                    hasilProvinsi, selectedProvinsiObject);
              }),
            ),
            SizedBox(
              height: screenHeight(context) * (1 / 60),
            ),

            // perguruan tinggi
            rowLabel(
              asset: "assets/icons/ijazahln/icon_pt.png",
              keterangan: "Nama Perguruan Tinggi",
            ),
            SizedBox(
              height: 13.h,
            ),
            BlocProvider(
              create: (context) => di.locator<SivilBloc>(),
              child: Builder(builder: (context) {
                return textFieldPTPDDikti(
                    context, namaPerguruanTinggiController, selectedPTObject);
              }),
            ),
          ],
        ),
        SizedBox(
          height: 13.h,
        ),
        rowLabel(
          asset: "assets/icons/pddikti/icon_tipe_pt.png",
          keterangan: "Tipe",
        ),
        Container(
          padding:
              EdgeInsets.symmetric(horizontal: screenWidth(context) * (1 / 30)),
          margin: EdgeInsets.only(top: 13.h),
          decoration: BoxDecoration(
              border: Border.all(color: abu6, width: 1),
              borderRadius: BorderRadius.circular(8)),
          child: DropdownButton<String>(
            items: listTipePT.map(buildMenuItem).toList(),
            onChanged: (value) => {
              if (value != null)
                {
                  stateSetter(() {
                    tipePT = value;
                  }),
                  print("tipePT $tipePT"),
                }
            },
            isExpanded: true,
            hint: Text('--Tipe PT--'),
            value: tipePT,
            underline: Container(),
          ),
        ),
        SizedBox(
          height: 13.h,
        ),
      ];
    } else if (state is SwitchFormTypeProdi) {
      return [
        // nama prodi
        rowLabel(
          asset: "assets/icons/pddikti/icon_prodi.png",
          keterangan: "Nama Program Studi",
          isRequired: true,
        ),

        SizedBox(
          height: 13.h,
        ),
        formField('Program Studi', programStudiController, (value) {
          stateSetter(() {
            this.programStudiValue = value;
          });
        }),

        SizedBox(
          height: 13.h,
        ),
        // jenjang
        rowLabel(
          asset: "assets/icons/pddikti/icon_jenjang.png",
          keterangan: "Jenjang",
        ),

        SizedBox(
          height: 13.h,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: BoxDecoration(
              border: Border.all(color: abu6, width: 1),
              borderRadius: BorderRadius.circular(8.r)),
          child: DropdownButton<String>(
            items: listJenjang.map(buildMenuItem).toList(),
            onChanged: (value) => {
              if (value != null)
                {
                  stateSetter(() {
                    tipeJenjang = value;
                  }),
                  print("tipeJenjang $tipeJenjang"),
                }
            },
            isExpanded: true,
            hint: Text('--S1--'),
            value: tipeJenjang,
            underline: Container(),
          ),
        ),
        // typeField('--S1--', jenjangController, jenjangController.text, 4, true,
        //     onJenjangSearch),
        SizedBox(
          height: 13.h,
        ),

        // perguruan tinggi
        rowLabel(
          asset: "assets/icons/ijazahln/icon_pt.png",
          keterangan: "Nama Perguruan Tinggi",
        ),
        SizedBox(
          height: 13.h,
        ),

        BlocProvider(
          create: (context) => di.locator<SivilBloc>(),
          child: Builder(builder: (context) {
            return textFieldPTPDDikti(
                context, namaPerguruanTinggiController, selectedPTObject);
          }),
        ),
        // rowLabel(
        //   asset: "assets/icons/ijazahln/icon_pt.png",
        //   keterangan: "Nama Perguruan Tinggi",
        // ),
        // Container(
        //   margin: EdgeInsets.only(top: 13.h),
        //   child: typeField(
        //       '--Perguruan Tinggi--',
        //       namaPerguruanTinggiController,
        //       perguruanTinggiValue,
        //       2,
        //       true,
        //       onPTSearch),
        // ),
        SizedBox(
          height: screenHeight(context) * (1 / 60),
        ),
      ];
    }
  }
}

TextSpan asterisk() {
  return TextSpan(
      text: '*',
      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold));
}

//=============================================

Widget formField(String hint, TextEditingController controller,
    void Function(dynamic) onChange) {
  return TextFormField(
    style: TextStyle(
      color: neutral80,
      fontSize: 14.sp,
    ),
    controller: controller,
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        color: abu6,
        fontSize: 14.sp,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.r),
        borderSide: BorderSide(color: abu6, style: BorderStyle.solid, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.r),
        borderSide:
            BorderSide(color: blueLinear1, style: BorderStyle.solid, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.r),
        borderSide:
            BorderSide(color: abu6, style: BorderStyle.solid, width: 1.2),
      ),
      isDense: true,
    ),
    onChanged: (value) => onChange(value),
    // onSaved: (value) => npm = value,
  );
}

bool switchStatusForm(text) {
  if (text == '') {
    return false;
  } else {
    return true;
  }
}

Future<dynamic> refreshScreen(BuildContext context) {
  return Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => di.locator<PencarianSpesifikBloc>()
            ..add(InitPencarianSpesifikEvent()),
          child: PDDiktiMainPage(),
        ),
      ));
}

class OnSearch {
  bool onSearch;

  OnSearch([this.onSearch = false]);
}
