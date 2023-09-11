import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customSliverBar.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/pages/beranda/beasiswa/beasiswaAkanDibukaLainnya.dart';
import 'package:app/presentation/pages/beranda/beasiswa/beasiswaArsipPage.dart';
import 'package:app/presentation/pages/beranda/beasiswa/beasiswaSedangDibukaLainnya.dart';
import 'package:app/presentation/pages/beranda/beasiswa/components/beasiswa_loading.dart';
import 'package:app/presentation/pages/beranda/beasiswa/components/cardBeasiswa.dart';
import 'package:app/presentation/pages/beranda/beasiswa/components/list_pagination_beasiswa/list_pagination_beasiswa_bloc.dart';
import 'package:app/presentation/pages/beranda/beasiswa/components/no_program.dart';
import 'package:app/presentation/pages/beranda/beasiswa/components/pelajariSelengkapnyaBeasiswa.dart';
import 'package:app/presentation/pages/beranda/beasiswa/components/searchbar_home_beasiswa.dart';
import 'package:app/presentation/pages/beranda/beasiswa/get_list_beasiswa_bloc/list_beasiswa_bloc.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/reusableWidgets/reusableWidgetsCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BeasiswaMainPage extends StatefulWidget {
  const BeasiswaMainPage({Key? key}) : super(key: key);

  @override
  State<BeasiswaMainPage> createState() => _BeasiswaMainPageState();
}

enum MenuItem {
  arsipBeasiswa,
}

class _BeasiswaMainPageState extends State<BeasiswaMainPage> {
  var textStyle1 = TextStyle(color: neutral50, fontSize: 14.sp);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<ListBeasiswaBloc>(context)
              .add(FetchListBeasiswaEvent());
        },
        child: Container(
          decoration: BoxDecoration(gradient: sliverBgGradient),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              body: CustomSliverBar(
                appBarTitle: "Beasiswa",
                header: FlexibleSpaceBar(
                  background: _header(),
                ),
                appBarActions: [
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => BlocProvider(
                  //               create: (context) =>
                  //                   di.locator<ListBeasiswaBloc>()
                  //                     ..add(FetchListBeasiswaEvent()),
                  //               child: BeasiswaArsipPage())),
                  //     );
                  //   },
                  //   child: Padding(
                  //       padding: EdgeInsets.only(right: 16.w),
                  //       child: Icon(Icons.more_vert)),
                  // ),
                  PopupMenuButton(
                      icon: Icon(Icons.more_vert),
                      offset: Offset(-15, 50),
                      enableFeedback: false,
                      shape: const TooltipShape(),
                      onSelected: (value) {
                        if (value == MenuItem.arsipBeasiswa) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                    create: (context) =>
                                        di.locator<ListBeasiswaBloc>()
                                          ..add(FetchListBeasiswaEvent()),
                                    child: BeasiswaArsipPage())),
                          );
                        }
                      },
                      itemBuilder: (context) => [
                            PopupMenuItem(
                                height: 35.h,
                                value: MenuItem.arsipBeasiswa,
                                child: Container(
                                  //width: 155,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.archive_outlined,
                                        color: blue3,
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text(
                                        'Arsip Beasiswa',
                                        style: TextStyle(
                                            color: blue3,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                )),
                          ])
                ],
                expandedHeight: 280.h,
                child: Column(
                  children: [
                    _scrolledContent(),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(gradient: beasiswaBgGradient),
      child: Stack(
        children: [
          Positioned(
              right: 0.w,
              bottom: -80.h,
              child: Image.asset(
                "assets/beasiswa/header_beasiswa.png",
                width: 345.w,
                height: 345.h,
                fit: BoxFit.contain,
                alignment: Alignment.bottomRight,
              )),
          Positioned(
            bottom: 50.h,
            left: 30.w,
            child: GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => PelajariSelengkapnyaBeasiswa())),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    width: 48.w,
                    height: 48.w,
                    image: AssetImage("assets/beasiswa/beasiswa_icon.png"),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Dapatkan Kemudahan\nMencari Informasi Beasiswa",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                        color: white,
                        letterSpacing: 0.08.sp),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
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
                          color: bgPelajariSelengkapnya,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Pelajari Selengkapnya",
                              style: stylePelajariSelengkapnya,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: white,
                              size: 12.sp,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _scrolledContent() {
    return Column(
      children: [
        SizedBox(height: 17.h),
        searchBarHomeBeasiswa(context),
        SizedBox(height: 20.h),
        _tabBar(),
      ],
    );
  }

  Widget _tabBar() {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Column(
        children: [
          Container(
            width: 358.w,
            height: 58.h,
            padding: EdgeInsets.symmetric(
              horizontal: 4.w,
              vertical: 5.h,
            ),
            decoration: BoxDecoration(
              color: neutral10,
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: TabBar(
              unselectedLabelColor: neutral40,
              indicator: BoxDecoration(
                color: blue4,
                borderRadius: BorderRadius.circular(4.r),
              ),
              tabs: [
                Container(
                    width: 350.w,
                    height: 50.h,
                    alignment: Alignment.center,
                    child: Text(
                      'Sedang dibuka',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
                Container(
                    width: 350.w,
                    height: 50.h,
                    alignment: Alignment.center,
                    child: Text(
                      'Akan dibuka',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          BlocConsumer<ListBeasiswaBloc, ListBeasiswaState>(
            listener: (context, state) {
              if (state is ListBeasiswaNoInternetState) {
                ScaffoldMessenger.of(context).showSnackBar(noInternet);
              }
            },
            builder: (context, state) {
              return SizedBox(
                height: 516.w,
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    _sedangDibuka(state),
                    _akanDibuka(state),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _sedangDibuka(ListBeasiswaState state) {
    if (state is ListBeasiswaLoadedState) {
      final rowCount = state.beasiswaDibukaRowCount.rowCount;
      final res = state.beasiswaDibuka;
      if (res.isEmpty) {
        return noProgram(true);
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(text: "Ada ", style: textStyle1),
                TextSpan(
                    text: "$rowCount ",
                    style: textStyle1.copyWith(fontWeight: FontWeight.bold)),
                TextSpan(text: "Program yang sedang dibuka", style: textStyle1)
              ])),
            ),
            SizedBox(
              height: 20.h,
            ),
            Flexible(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: res.length > 1
                    ? 2
                    : res.length > 0
                        ? 1
                        : 0,
                itemBuilder: (BuildContext context, index) {
                  return CardBeasiswa(
                    deskripsi: res[index].deskripsi,
                    persyaratan: res[index].persyaratan,
                    url: res[index].linkPendaftaran,
                    namaBeasiswa: res[index].nama,
                    namaInstansi: res[index].penyelenggara,
                    startDate: res[index].tanggalDibuka.toString(),
                    endDate: res[index].tanggalDitutup.toString(),
                    listTagName:
                        res[index].penerima.map((e) => e.nama).toList(),
                    isOpen: res[index].isOpen,
                    urlLampiran: res[index].lampiran!.pathFile,
                    daftar: true,
                    closed: false,
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 20.h);
                },
              ),
            ),
            SizedBox(
              height: 20.w,
            ),
            res.length > 2
                ? buttonLainnya(func: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => BlocProvider(
                                  create: (context) => di
                                      .locator<ListPaginationBeasiswaBloc>()
                                    ..add(ListPaginationBeasiswaDibukaEvent()),
                                  child: BeasiswaSedangDibukaLainnyaPage(),
                                )));
                  })
                : SizedBox(),
          ],
        );
      }
    } else if (state is ListBeasiswaErrorState) {
      return serverProblem();
    } else if (state is ListBeasiswaNoInternetState) {
      return NoInternet(onPressed: () {}, buttonHide: true);
    }
    return programBeasiswaLoading();
  }

  Widget buttonLainnya({required VoidCallback func}) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w),
      child: GestureDetector(
        onTap: func,
        child: Container(
          width: double.infinity,
          height: 48.sp,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(4.r),
            border: Border.all(color: blue4),
          ),
          child: Center(
            child: Text(
              'Lihat Lainnya',
              style: TextStyle(
                color: blue4,
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _akanDibuka(ListBeasiswaState state) {
    if (state is ListBeasiswaLoadedState) {
      final rowCount = state.beasiswaAkanDibukaRowCount.rowCount;
      final res = state.beasiswaAkanDibuka;
      if (res.isEmpty) {
        return noProgram(false);
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(text: "Ada ", style: textStyle1),
                TextSpan(
                    text: "$rowCount ",
                    style: textStyle1.copyWith(fontWeight: FontWeight.bold)),
                TextSpan(text: "Program sudah akan dibuka", style: textStyle1)
              ])),
            ),
            SizedBox(
              height: 20.h,
            ),
            Flexible(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: res.length > 1
                    ? 2
                    : res.length > 0
                        ? 1
                        : 0,
                itemBuilder: (BuildContext context, index) {
                  return CardBeasiswa(
                    deskripsi: res[index].deskripsi,
                    persyaratan: res[index].persyaratan,
                    url: res[index].linkPendaftaran,
                    namaBeasiswa: res[index].nama,
                    namaInstansi: res[index].penyelenggara,
                    startDate: res[index].tanggalDibuka.toString(),
                    endDate: res[index].tanggalDitutup.toString(),
                    listTagName:
                        res[index].penerima.map((e) => e.nama).toList(),
                    isOpen: res[index].isOpen,
                    urlLampiran: res[index].lampiran!.pathFile,
                    daftar: false,
                    closed: false,
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 20.h);
                },
              ),
            ),
            SizedBox(
              height: 20.w,
            ),
            res.length > 2
                ? buttonLainnya(func: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => BlocProvider(
                                  create: (context) => di
                                      .locator<ListPaginationBeasiswaBloc>()
                                    ..add(
                                        ListPaginationBeasiswaAkanDibukaEvent()),
                                  child: BeasiswaAkanDibukaLainnyaPage(),
                                )));
                  })
                : SizedBox(),
          ],
        );
      }
    } else if (state is ListBeasiswaErrorState) {
      return serverProblem();
    } else if (state is ListBeasiswaNoInternetState) {
      return NoInternet(onPressed: () {}, buttonHide: true);
    }
    return programBeasiswaLoading();
  }

// double _heightTab(ListBeasiswaState state) {
//   if (state is ListBeasiswaLoadedState) {
//     if (state.beasiswaDibuka.length < 2 && state.beasiswaDitutup.length < 2) {
//       return 516.h;
//     } else {
//       bool dibukaLebihBanyak =
//           state.beasiswaDibuka.length > state.beasiswaDitutup.length;
//       if (dibukaLebihBanyak) {
//         return state.beasiswaDibuka.length * 194.h + 140.h;
//       } else {
//         return state.beasiswaDitutup.length * 194.h + 140.h;
//       }
//     }
//   } else {
//     if (state is ListBeasiswaLoadingState) {
//       return 3 * 194.h + 140.h;
//     }
//     return 516.h;
//   }
// }
}

class TooltipShape extends ShapeBorder {
  const TooltipShape();

  final BorderSide _side = BorderSide.none;
  final BorderRadiusGeometry _borderRadius = BorderRadius.zero;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(_side.width);

  @override
  Path getInnerPath(
    Rect rect, {
    TextDirection? textDirection,
  }) {
    final Path path = Path();

    path.addRRect(
      _borderRadius.resolve(textDirection).toRRect(rect).deflate(_side.width),
    );

    return path;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final Path path = Path();
    final RRect rrect = _borderRadius.resolve(textDirection).toRRect(rect);

    path.moveTo(0, 8);
    path.quadraticBezierTo(0, 0, 8, 0);
    path.lineTo(rrect.width - 15, 0);
    path.lineTo(rrect.width - 10, -8);
    path.lineTo(rrect.width - 5, 0);
    path.quadraticBezierTo(rrect.width, 0, rrect.width, 8);
    path.lineTo(rrect.width, rrect.height - 8);
    path.quadraticBezierTo(
        rrect.width, rrect.height, rrect.width - 8, rrect.height);
    path.lineTo(8, rrect.height);
    path.quadraticBezierTo(0, rrect.height, 0, rrect.height - 8);

    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => RoundedRectangleBorder(
        side: _side.scale(t),
        borderRadius: _borderRadius * t,
      );
}
