import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customSliverBar.dart';
import 'package:app/presentation/component/inkEffect.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/pages/beranda/ijazahln/component/reusableWidgets/customCircularProgress.dart';
import 'package:app/presentation/pages/beranda/kedaireka/bloc/kedairekaindustri_bloc.dart';
import 'package:app/presentation/pages/beranda/kedaireka/widgetlistdraggable.dart';
import 'package:app/presentation/pages/showWebsite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IndustriKedaireka extends StatelessWidget {
  const IndustriKedaireka({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.locator<KedairekaindustriBloc>()
        ..add(FetchKedairekaindustriEvent()),
      child: Container(
        decoration: BoxDecoration(gradient: sliverBgGradient),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: BlocBuilder<KedairekaindustriBloc, KedairekaindustriState>(
            builder: (context, state) {
              if (state is KedairekaindustriLoading) {
                return Scaffold(
                  appBar: AppBar(
                    elevation: 0,
                    centerTitle: true,
                    title: Text(
                      'Kedaireka',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, letterSpacing: 1),
                    ),
                    flexibleSpace: Container(
                      decoration: BoxDecoration(
                        gradient: appBarGradient,
                      ),
                    ),
                  ),
                  body: Center(
                    child: CustomCircularProgress(),
                  ),
                );
              } else if (state is KedairekaindustriLoaded) {
                final result = state.modelKedairekaIndustri.data!.listData;
                return Scaffold(
                  backgroundColor: Colors.transparent,
                  body: CustomSliverBar(
                      expandedHeight: 280.w,
                      header: FlexibleSpaceBar(
                        background: _header(),
                      ),
                      child: SingleChildScrollView(
                        child: listDraggableIndustri(context, 2, result),
                      ),
                      appBarTitle: "Kedaireka"),
                  bottomNavigationBar: Container(
                      decoration: BoxDecoration(color: white, boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          blurRadius: 25,
                          spreadRadius: 0,
                          offset: Offset(0, 6),
                        )
                      ]),
                      child: Container(
                        height: 100.h,
                        child: Center(
                          child: InkEffect(
                            boxDecoration: BoxDecoration(
                                color: blue4,
                                borderRadius: BorderRadius.circular(4.r)),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ShowWebsite(
                                      title: "Kedaireka",
                                      link:
                                          'https://kedaireka.id/registration?tab=industry',
                                    ),
                                  ));
                            },
                            child: Container(
                              width: 358.w,
                              height: 48.sp,
                              child: Center(
                                child: Text(
                                  'Daftar Sekarang',
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )),
                );
              } else if (state is KedairekaindustriNoInternet) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text("Industri"),
                    centerTitle: true,
                    flexibleSpace: Container(
                      decoration: BoxDecoration(gradient: sliverBgGradient),
                    ),
                  ),
                  body: NoInternet(onPressed: () {}, buttonHide: true),
                );
              } else {
                return Scaffold(
                  body: Container(
                    color: white,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(gradient: beasiswaBgGradient),
      child: Stack(children: [
        Positioned(
          bottom: -8.w,
          left: 12.w,
          child: Image.asset(
            'assets/kedaireka/industri_fix.png',
            width: 367.w,
            height: 246.w,
          ),
        ),
        Positioned(
          bottom: 30.w,
          child: Container(
            width: 346.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 23.w, right: 21.w),
                  child: Container(
                    height: 30.w,
                    child: Text(
                      "Industri",
                      style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff94EF85)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12.w,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 23.w, right: 21.w),
                  child: Container(
                    height: 65.w,
                    child: Text(
                      "Dapatkan Solusi dari para Insan Perguruan Tinggi dengan membuka peluang dari ide-ide permasalahan spesifik",
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
