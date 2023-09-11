import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customSliverBar.dart';
import 'package:app/presentation/pages/beranda/garuda/bloc/garuda_journal/garuda_bloc.dart';
import 'package:app/presentation/pages/beranda/garuda/bloc/statistik_garuda/statistik_garuda_bloc.dart';
import 'package:app/presentation/pages/beranda/garuda/tujuangaruda.dart';
import 'package:app/presentation/pages/beranda/garuda/widgetSlidingUpGaruda.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/injection.dart' as di;

class GarudaMainPage extends StatelessWidget {
  const GarudaMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              di.locator<GarudaBloc>()..add(SearchGarudaJournalRefreshEvent()),
        ),
        BlocProvider(
          create: (context) => di.locator<StatistikGarudaBloc>()
            ..add(StatistikGarudaMainEvent()),
        ),
      ],
      child: Builder(builder: (context) {
        return Container(
          decoration: BoxDecoration(gradient: sliverBgGradient),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: RefreshIndicator(
              onRefresh: () async {
                context.read<GarudaBloc>()
                  ..add(SearchGarudaJournalRefreshEvent());
                context.read<StatistikGarudaBloc>()
                  ..add(StatistikGarudaMainEvent());
              },
              child: CustomSliverBar(
                  expandedHeight: 280.w,
                  header: FlexibleSpaceBar(
                    background: AppBarWidgetGaruda(),
                  ),
                  child: SingleChildScrollView(
                    child: listDraggableGarudaHome(context),
                  ),
                  appBarTitle: "Garuda"),
            ),
          ),
        );
      }),
    );
  }
}

class AppBarWidgetGaruda extends StatelessWidget {
  const AppBarWidgetGaruda({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: sliverBgGradient),
      child: Stack(
        children: [
          Positioned(
            right: -23.w,
            bottom: -50.w,
            child: Opacity(
              opacity: 0.98,
              child: Image.asset(
                'assets/garuda/headergaruda2.png',
                width: 299.w,
                height: 299.w,
              ),
            ),
          ),
          Positioned(
            bottom: 40.w,
            left: 30.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  image: AssetImage("assets/garuda/logo_garudav2.png"),
                  width: 58.w,
                  height: 55.w,
                ),
                SizedBox(
                  height: 12.w,
                ),
                Container(
                    width: 220.w,
                    child: Text(
                      "Akses publikasi berbagai ilmu pengetahuan lebih mudah dengan Garuda.",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                          color: white),
                    )),
                SizedBox(
                  height: 14.w,
                ),
                Container(
                    width: 220.w,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TujuanGaruda(),
                            ));
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              width: 189.w,
                              height: 40.h,
                              padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.r),
                                  color: bgPelajariSelengkapnya
                              ),
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

                                ],)
                          ),
                          SizedBox(width: 8.w),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
