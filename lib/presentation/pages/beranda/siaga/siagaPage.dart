import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/bannerSubJudul.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customSliverBar.dart';
import 'package:app/presentation/pages/beranda/siaga/bloc/siaga_bloc.dart';
import 'package:app/presentation/pages/beranda/siaga/components/text_field_siaga.dart';
import 'package:app/presentation/pages/beranda/siaga/cubit/tipe_pencarian_cubit.dart';
import 'package:app/presentation/pages/beranda/siaga/pelajariSelengkapnyaSiaga.dart';
import 'package:app/presentation/pages/beranda/siaga/pengajuanUsulan/bloc/pengajuan_usulan_bloc.dart';
import 'package:app/presentation/pages/beranda/siaga/pengajuanUsulan/bloc/pengajuan_usulan_event.dart';
import 'package:app/presentation/pages/beranda/siaga/pengajuanUsulan/statusPengajuanUsulanPage.dart';
import 'package:app/presentation/pages/faq/bloc/faq_module/faqmodule_bloc.dart';
import 'package:app/presentation/pages/faq/faq_page_per_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SiagaPage extends StatefulWidget {
  @override
  _SiagaPageState createState() => _SiagaPageState();
}

class _SiagaPageState extends State<SiagaPage> {
  final dropValue = ValueNotifier('');
  final listItem = ["Nama Perguruan Tinggi", "Nomor Tiket"];
  List<String> recentDocument = [];
  int widthCard = 579;
  TextEditingController ptTextController = TextEditingController();
  TextEditingController kataKunciTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getRecentDocument();
  }

  static Future<SharedPreferences> getPrefs() async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    return await _prefs;
  }

  void getRecentDocument() async {
    SharedPreferences prefs = await getPrefs();
    setState(() {
      if (prefs.getStringList("StatusPU")!.isNotEmpty) {
        recentDocument = [
          prefs.getStringList("StatusPU")![0],
          prefs.getStringList("StatusPU")![1],
          prefs.getStringList("StatusPU")![2],
          prefs.getStringList("StatusPU")![3]
        ];
        setWidthScreen();
      }
    });
  }

  void setWidthScreen() {
    if (recentDocument.isEmpty) {
      setState(() {
        widthCard = 579;
      });
    } else {
      setState(() {
        widthCard = 700;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: sliverBgGradient),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: CustomSliverBar(
            expandedHeight: 260.h,
            header: FlexibleSpaceBar(
              background: AppBarWidgetSiaga(),
            ),
            child: Container(
              // height: 579.h,
              height: widthCard.h,
              color: whiteBgPage,
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth(context) * (1 / 20),
                  vertical: screenHeight(context) * (1 / 50)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  recentDocument.isNotEmpty
                      ? Column(children: [
                          SizedBox(
                            height: 30.h,
                          ),
                          bannerSubJudul("Recent Document"),
                          SizedBox(
                            height: 10.h,
                          ),
                          _bannerRecentDocument(),
                          SizedBox(
                            height: 30.h,
                          ),
                        ])
                      : SizedBox(
                          height: 30.h,
                        ),
                  bannerSubJudul('Lacak Pengajuan Usulan'),
                  searchByi(),
                  kataKunci(),
                  buttonLacak(),
                  _bannerFAQ()
                ],
              ),
            ),
            appBarTitle: "SIAGA",
          )),
    );
  }

  Widget bannerSubJudul(String hintText) {
    return Column(
      children: [
        BannerSubJudul(
          subJudul: hintText,
          warna: blue3,
          edgeInsets: EdgeInsets.symmetric(horizontal: 16.w),
        ),
        SizedBox(
          height: 21.h,
        )
      ],
    );
  }

  Widget _bannerFAQ() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return BlocProvider(
                create: (context) => di.locator<FaqmoduleBloc>()
                  ..add(FetchfaqModuleEvent('silemkerma')),
                child: FAQModul(),
              );
            },
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 30.h),
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

  Widget _bannerRecentDocument() {
    return GestureDetector(
        onTap: () {
          _onClickPengajuanUsulan(
            recentDocument[3].toString(),
          );
        },
        child: Container(
          width: 358.w,
          height: 115.sp,
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                recentDocument[2],
                style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.006.sp,
                    color: Colors.black),
              ),
              SizedBox(
                height: 10.w,
              ),
              Text(
                recentDocument[1],
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.006.sp,
                    color: Colors.black),
              ),
              SizedBox(
                height: 10.w,
              ),
              Text(
                recentDocument[3],
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.006.sp,
                    color: Colors.black),
              ),
            ],
          ),
        ));
  }

  Widget searchByi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Image.asset(
                  'assets/siaga/icon_search.png',
                  width: 16.sp,
                  height: 16.sp,
                ),
              ),
              WidgetSpan(
                child: SizedBox(width: 9.w),
              ),
              TextSpan(
                text: 'Cari Berdasarkan',
                style: TextStyle(
                  color: blue4,
                  fontSize: 12.sp,
                  letterSpacing: 0.08.sp,
                ),
              ),
              TextSpan(
                text: '*',
                style: TextStyle(
                  color: red,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        typeFieldSearchBy(),
        SizedBox(height: 20.h)
      ],
    );
  }

  Widget typeFieldSearchBy() {
    return Container(
      child: ValueListenableBuilder(
        valueListenable: dropValue,
        builder: (BuildContext context, String value, _) {
          return Container(
            height: 50.h,
            width: 358.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: white, borderRadius: BorderRadius.circular(5.r)),
            padding: EdgeInsets.only(
              right: 20.w,
              left: 12.w,
            ),
            child: DropdownButtonFormField<String>(
              elevation: 1,
              icon: Image.asset('assets/siaga/icon_dropdown.png'),
              isExpanded: true,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
              hint: Text(
                'Nama Perguruan Tinggi',
                style: TextStyle(fontSize: 14.sp, color: neutral80, height: 1),
              ),
              value: (value.isEmpty) ? null : value,
              onChanged: (onchange) {
                print("onchange ${onchange.toString()}");
                dropValue.value = onchange.toString();
                context
                    .read<TipePencarianCubit>()
                    .changeTipePencarian(onchange.toString());
              },
              items: listItem
                  .map(
                    (item) => DropdownMenuItem(
                      value: item,
                      child: Text(
                        item,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: neutral80,
                          height: 1.h,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }

  Widget kataKunci() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(children: [
            WidgetSpan(
                child: Image.asset(
              'assets/siaga/icon_kata_kunci.png',
              width: 16.sp,
              height: 16.sp,
            )),
            WidgetSpan(
                child: SizedBox(
              width: 9.w,
            )),
            TextSpan(
              text: 'Kata Kunci',
              style: TextStyle(
                  color: blue4, fontSize: 12.sp, letterSpacing: 0.08.sp),
            ),
            TextSpan(text: '*', style: TextStyle(color: red, fontSize: 12.sp)),
          ]),
        ),
        SizedBox(
          height: 8.h,
        ),
        BlocBuilder<TipePencarianCubit, TipePencarianState>(
          builder: (context, state) {
            if (state is TipePencarianPT) {
              return textFieldPTSiaga(context, ptTextController);
            } else if (state is TipePencarianTiket) {
              return textFieldTicket(context, kataKunciTextController);
            } else {
              return Container(
                height: 50.h,
                width: 358.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: white, borderRadius: BorderRadius.circular(5.r)),
                child: TextFormField(
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: neutral70,
                    fontWeight: FontWeight.w400,
                  ),
                  onChanged: (value) => setState(() {}),
                  decoration: InputDecoration(
                    isDense: true,
                    // isCollapsed: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                    hintText: 'Masukkan Nomor Tiket',
                    hintStyle: TextStyle(
                      color: neutral30,
                      fontSize: 14.sp,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }

  Widget buttonLacak() {
    return BlocBuilder<SiagaBloc, SiagaState>(builder: (context, state) {
      if (state is SiagaInitialState) {
        return Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              if (kataKunciTextController.text.isNotEmpty ||
                  ptTextController.text.isNotEmpty) {
                String kataKunci = kataKunciTextController.text;
                var tipe = BlocProvider.of<TipePencarianCubit>(context).state;
                print(tipe);
                if (tipe is TipePencarianPT) {
                  _onClickPengajuanUsulan(state.pt!.ticket);
                } else {
                  _onClickPengajuanUsulan(kataKunci);
                }
                FocusManager.instance.primaryFocus?.unfocus();
              } else {
                SnackBar isiPt = SnackBar(
                  content: Text(
                    'Harap isi semua kolom terlebih dahulu',
                    style: TextStyle(fontSize: 12.sp),
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(isiPt);
              }
            },
            child: Container(
              margin: EdgeInsets.only(top: 38.h),
              width: 358.w,
              height: 50.sp,
              decoration: BoxDecoration(
                  color: biruMuda2, borderRadius: BorderRadius.circular(5.r)),
              child: Center(
                child: Text(
                  'Cari',
                  style: TextStyle(
                      color: white,
                      fontSize: 14.sp,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
        );
      }
      return Container();
    });
  }

  void _onClickPengajuanUsulan(String kataKunci) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => di.locator<PengajuanUsulanBloc>()
            ..add(LoadPengajuanUsulanEvent(kataKunci: kataKunci)),
          child: StatusPengajuanUsulanPage(
            kataKunci: kataKunci,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    ptTextController.dispose();
    kataKunciTextController.dispose();
    super.dispose();
  }
}

class AppBarWidgetSiaga extends StatelessWidget {
  const AppBarWidgetSiaga({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(gradient: sliverBgGradient),
      child: Stack(
        children: [
          Positioned(
            top: 97.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 30.w),
                  child: Container(
                    height: 28.94.h,
                    width: 72.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(3.w),
                      child: Image.asset('assets/siaga/new_logo_siaga.png'),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Padding(
                  padding: EdgeInsets.only(left: 30.w),
                  child: Container(
                      width: 199.w,
                      child: Text(
                        "Platform pengajuan\nperizinan Kelembagaan\nPerguruan Tinggi",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp,
                            height: 1.5,
                            color: white),
                      )),
                ),
                SizedBox(
                  height: 14.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30.w),
                  child: Container(
                    width: 199.w,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PelajariSelengkapnyaSiaga(),
                          ),
                        );
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 95.h,
            right: 11.w,
            left: 220.w,
            bottom: 17.h,
            child: Image.asset('assets/siaga/header_siaga.png'),
          )
        ],
      ),
    );
  }
}
