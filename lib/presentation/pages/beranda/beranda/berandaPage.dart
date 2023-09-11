import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/beranda/berita_section.dart';
import 'package:app/presentation/pages/beranda/beranda/bloc/beranda_bloc.dart';
import 'package:app/presentation/pages/beranda/beranda/carousel_topsection.dart';
import 'package:app/presentation/pages/beranda/beranda/component/daftar_menu.dart';
import 'package:app/presentation/pages/beranda/beranda/pengumuman_section.dart';
import 'package:app/presentation/pages/beranda/searchPage/searchPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({Key? key}) : super(key: key);

  @override
  _BerandaPageState createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  int current = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BerandaBloc, BerandaState>(
      listener: (context, state) {
        if (state is BerandaNoInternetState) {
          ScaffoldMessenger.of(context).showSnackBar(noInternet);
        }
      },
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: _refreshBeranda,
          child: Scaffold(
            backgroundColor: whiteBgPage,
            body: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Column(
                children: [
                  Stack(
                    children: [
                      carouselTopSection(context, state),
                      Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            child: Column(children: [
                              SizedBox(
                                height: 26,
                              ),
                              _searchBar()
                            ]),
                          )),
                    ],
                  ),
                  //Modul Grid
                  SizedBox(height: 48.h),
                  daftarMenu(context, state),
                  SizedBox(height: 48.h),
                  beritaSection(context, state),
                  SizedBox(height: 48.h),
                  pengumumanSection(context, state),
                  SizedBox(height: 48.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _searchBar() {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchPage(
                  isBeranda: true,
                  hintText: 'Cari informasi layanan',
                  text: 'Layanan',
                ),
              ));
        },
        child: Stack(
          alignment: AlignmentDirectional.centerEnd,
          children: [
            Container(
              color: Colors.transparent,
              child: IgnorePointer(
                  child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                    top: 4.h, bottom: 4.h, left: 24.w, right: 56.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(92, 94, 97, 0.06),
                        offset: Offset(0, 12),
                        blurRadius: 16,
                        spreadRadius: -4),
                    BoxShadow(
                        color: Color.fromRGBO(92, 94, 97, 0.03),
                        offset: Offset(0, 4),
                        blurRadius: 6,
                        spreadRadius: -2)
                  ],
                ),
                child: CupertinoTextField(
                  style: TextStyle(
                    fontSize: 14.sp,
                  ),
                  textInputAction: TextInputAction.search,
                  textAlignVertical: TextAlignVertical.center,
                  placeholder: "Cari informasi layanan",
                  placeholderStyle: TextStyle(
                      color: neutralCaption,
                      fontSize: 14.sp,
                      fontFamily: "Plus Jakarta Sans"),
                  padding:
                      EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.sp),
                    color: white,
                  ),
                ),
              )),
            ),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                // This is the back circle, which is slightly larger
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 28.w),
                  height: 55.w,
                  width: 55.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(92, 94, 97, 0.06),
                          offset: Offset(0, 12),
                          blurRadius: 16,
                          spreadRadius: -4),
                      BoxShadow(
                          color: Color.fromRGBO(92, 94, 97, 0.03),
                          offset: Offset(0, 4),
                          blurRadius: 6,
                          spreadRadius: -2)
                    ],
                  ),
                ),
                // This is the front circle
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 28.w),
                  height: 45.w,
                  width: 45.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: kedairekaInformasiBgGradient,
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/icons/search_beranda.png',
                      scale: 3.8,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }

  Future<void> _refreshBeranda() {
    BlocProvider.of<BerandaBloc>(context)
      ..add(GetRecentBeritaEvent())
      ..add(GetPopularBeritaEvent())
      ..add(GetPengungumanEvent())
      ..add(GetLayananFavoritEvent());
    return Future.delayed(Duration(seconds: 1));
  }
}
