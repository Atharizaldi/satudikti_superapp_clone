import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/search/searchBar.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/reusableWidgets/reusableWidgetsCard.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/pencarian_bloc/pencarian_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/loadingPddikti/loading_caridata_pddikti.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/searchTabPage.dart/pddiktiPencarianDosen.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/searchTabPage.dart/pddiktiPencarianMahasiswa.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/searchTabPage.dart/pddiktiPencarianPT.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/searchTabPage.dart/pddiktiPencarianProdi.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/searchTabPage.dart/pddiktiPencarianSemua.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/tabBarButton.dart';
import 'package:app/presentation/pages/beranda/pddikti/cubit/tab_bar/tab_bar_cubit.dart';
import 'package:app/presentation/pages/beranda/searchPage/component/searchNotFound.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PDDiktiSearchPage extends StatefulWidget {
  @override
  _PDDiktiSearchPageState createState() => _PDDiktiSearchPageState();
}

class _PDDiktiSearchPageState extends State<PDDiktiSearchPage>
    with SingleTickerProviderStateMixin {
  TextEditingController searchController = new TextEditingController();
  late TabController tabController;

  @override
  void initState() {
    tabController = new TabController(length: 5, vsync: this);
    tabController.addListener(() {
      BlocProvider.of<TabBarCubit>(context).changeTabIndex(tabController.index);
    });

    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBgPage,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 12.w),
          child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: abu7,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        toolbarHeight: 86.h,
        title: SearchBar(
          controller: searchController,
          openKeyboard: false,
          hintText: 'Cari data pada PDDikti',
          isSubmitted: (String field) {
            context
                .read<PencarianBloc>()
                .add(LoadPencarianEvent(keyword: field));
          },
          searchType: TypeSearchBar.withClear,
        ),
        bottom: PreferredSize(
          preferredSize:
              pddiktiTabBarButton(context, tabController).preferredSize,
          child: ColoredBox(
              color: whiteBgPage,
              child: Builder(builder: (context) {
                return pddiktiTabBarButton(context, tabController);
              })),
        ),
      ),
      body: BlocBuilder<PencarianBloc, PencarianState>(
        builder: (context, state) {
          if (state is PencarianNoInternetState) {
            return noInternetWithContainer();
          } else if (state is PencarianInitialState) {
            return SizedBox();
          } else if (state is PencarianLoadedState) {
            return TabBarView(
              controller: tabController,
              children: [
                PDDiktiPencarianSemua(
                  mahasiswaButton: () {
                    BlocProvider.of<TabBarCubit>(context).changeTabIndex(1);
                    tabController.animateTo(1);
                  },
                  perguruanTinggiButton: () {
                    BlocProvider.of<TabBarCubit>(context).changeTabIndex(2);
                    tabController.animateTo(2);
                  },
                  dosenButton: () {
                    BlocProvider.of<TabBarCubit>(context).changeTabIndex(3);
                    tabController.animateTo(3);
                  },
                  prodiButton: () {
                    BlocProvider.of<TabBarCubit>(context).changeTabIndex(4);
                    tabController.animateTo(4);
                  },
                  ptList: state.pt,
                  prodiList: state.prodi,
                  dosenList: state.dosen,
                  mahasiswaList: state.mahasiswa,
                ),
                PDDiktiPencarianMahasiswa(
                  mahasiswaList: state.mahasiswa,
                ),
                PDDiktiPencarianPT(
                  ptList: state.pt,
                ),
                PDDiktiPencarianDosen(
                  dosenList: state.dosen,
                ),
                PDDiktiPencarianProdi(
                  prodiList: state.prodi,
                ),
              ],
            );
          } else if (state is PencarianNotFoundState) {
            // return NotFound();
            return searchNotFound('Pencarian');
          } else {
            return Center(
              child: LoadingCariDataPDDikti(),
            );
          }
        },
      ),
    );
  }
}
