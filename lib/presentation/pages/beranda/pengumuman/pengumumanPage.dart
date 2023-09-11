import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/tabBarButton.dart';
import 'package:app/presentation/pages/beranda/pddikti/cubit/tab_bar/tab_bar_cubit.dart';
import 'package:app/presentation/pages/beranda/pengumuman/kelembagaan/bloc/pengumuman_kelembagaan_bloc.dart';
import 'package:app/presentation/pages/beranda/pengumuman/kelembagaan/pengumumanKelembagaanListPage.dart';
import 'package:app/presentation/pages/beranda/pengumuman/pembelajaranDanMahasiswa/bloc/pengumuman_pembelajaran_bloc.dart';
import 'package:app/presentation/pages/beranda/pengumuman/pembelajaranDanMahasiswa/pengumumanPembelajaranListPage.dart';
import 'package:app/presentation/pages/beranda/pengumuman/sumberDaya/bloc/pengumuman_sumber_daya_bloc.dart';
import 'package:app/presentation/pages/beranda/pengumuman/sumberDaya/pengumumanSumberDayaListPage.dart';
import 'package:app/presentation/pages/beranda/pengumuman/umum/bloc/pengumuman_umum_bloc.dart';
import 'package:app/presentation/pages/beranda/pengumuman/umum/pengumumanUmumListPage.dart';
import 'package:app/presentation/pages/beranda/searchPage/searchPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PengumumanPage extends StatefulWidget {
  const PengumumanPage({Key? key}) : super(key: key);

  @override
  _PengumumanPageState createState() => _PengumumanPageState();
}

class _PengumumanPageState extends State<PengumumanPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = new TabController(length: 4, vsync: this);
    tabController.addListener(() {
      BlocProvider.of<TabBarCubit>(context).changeTabIndex(tabController.index);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //multiBlocProvider
    return MultiBlocProvider(
      providers: [
        BlocProvider<PengumumanUmumBloc>(
          create: (BuildContext context) =>
              di.locator<PengumumanUmumBloc>()..add(GetPengumumanEvent()),
        ),
        BlocProvider<PengumumanSumberDayaBloc>(
          create: (BuildContext context) =>
              di.locator<PengumumanSumberDayaBloc>()
                ..add(GetPengumumanSumberDayaEvent()),
        ),
        BlocProvider<PengumumanKelembagaanBloc>(
          create: (BuildContext context) =>
              di.locator<PengumumanKelembagaanBloc>()
                ..add(GetPengumumanKelembagaanEvent()),
        ),
        BlocProvider<PengumumanPembelajaranBloc>(
          create: (BuildContext context) =>
              di.locator<PengumumanPembelajaranBloc>()
                ..add(GetPengumumanPembelajaranEvent()),
        )
      ],
      child: Scaffold(
        appBar: pengumumanPageAppBar(),
        body: Container(
          margin: EdgeInsets.only(top: 30.h),
          child: Scaffold(
            backgroundColor: whiteBgPage,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(90.h),
              child: pengumumanTabBar(
                context: context,
                tabController: tabController,
              ),
            ),
            body: Container(
              child: TabBarView(
                controller: tabController,
                children: [
                  //umum = kategori1, pembelajaran = kategori4
                  // sumber daya = kategori2 and kelembagaan = kategori 3 not exist = 20
                  PengumumanUmumListPage(),
                  PengumumanSumberDayaListPage(),
                  PengumumanKelembagaanListPage(),
                  PengumumanPembelajaranListPage(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar pengumumanPageAppBar() {
    return AppBar(
      backgroundColor: whiteBgPage,
      title: Text(
        'Pengumuman',
        style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 1),
      ),
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(bottom: 0.5),
        child: Container(
            decoration: BoxDecoration(
          gradient: appBarGradient,
        )),
      ),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchPage(
                        isPengumuman: true,
                        hintText: 'Cari pengumuman',
                        text: 'Pengumuman'),
                  ));
            },
            icon: Image.asset(
              'assets/icons/search_inactive.png',
              scale: 2,
            ))
      ],
      elevation: 0,
    );
  }
}
