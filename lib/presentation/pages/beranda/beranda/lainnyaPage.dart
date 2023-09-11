import 'dart:collection';

import 'package:app/data/source/local/model/menuItems.dart';
import 'package:app/data/source/remote/model/profil/user_detail_information.dart';
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/beasiswa/beasiswaMainPage.dart';
import 'package:app/presentation/pages/beranda/beasiswa/get_list_beasiswa_bloc/list_beasiswa_bloc.dart';
import 'package:app/presentation/pages/beranda/beranda/bloc/lainnya_bloc.dart';
import 'package:app/presentation/pages/beranda/garuda/garudaMainPage.dart';
import 'package:app/presentation/pages/beranda/gmagz/bloc/detailmajalah/majalah_detail_gmagz_bloc.dart';
import 'package:app/presentation/pages/beranda/gmagz/gmagz_page.dart';
import 'package:app/presentation/pages/beranda/ijazahln/ijazahlnMainPage.dart';
import 'package:app/presentation/pages/beranda/kampusMerdeka/bloc/kampus_merdeka/kampusmerdeka_bloc.dart';
import 'package:app/presentation/pages/beranda/kampusMerdeka/kampus_merdeka_page.dart';
import 'package:app/presentation/pages/beranda/kedaireka/kedairekaMainPage.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/bloc/list_tawaran_program/list_tawaran_program_bloc.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/bloc/login_kd/login_kd_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/pencarian_spesifik_bloc/pencarian_spesifik_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/pddiktiMainPage.dart';
import 'package:app/presentation/pages/beranda/selancarPAK/loggedInPage/bloc/selancarloggedin_bloc.dart';
import 'package:app/presentation/pages/beranda/selancarPAK/loggedInPage/selancar_PAK_logged_in_page.dart';
import 'package:app/presentation/pages/beranda/selancarPAK/selancar_PAK_page.dart';
import 'package:app/presentation/pages/beranda/siaga/bloc/siaga_bloc.dart';
import 'package:app/presentation/pages/beranda/siaga/cubit/tipe_pencarian_cubit.dart';
import 'package:app/presentation/pages/beranda/siaga/siagaPage.dart';
import 'package:app/presentation/pages/beranda/sinta/sintaPage.dart';
import 'package:app/presentation/pages/beranda/sister/logged_in_page/bloc/sister_logged_in_bloc.dart';
import 'package:app/presentation/pages/beranda/sister/logged_in_page/sister_logged_in_page.dart';
import 'package:app/presentation/pages/beranda/sister/sister_page.dart';
import 'package:app/presentation/pages/beranda/sivil/bloc/sivil_bloc.dart';
import 'package:app/presentation/pages/beranda/sivil/sivilMainPage.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/tracer_study_page.dart';
import 'package:app/presentation/pages/profil/bloc/profil_bloc.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../kompetensiDosen/kompetensiDosenPage.dart';

class LainnyaPage extends StatefulWidget {
  final List<MenuItems> listMenuFavorit;
  final List<MenuItems> listMenuLainnya;

  const LainnyaPage(
      {Key? key, required this.listMenuFavorit, required this.listMenuLainnya})
      : super(key: key);

  @override
  State<LainnyaPage> createState() => _LainnyaPageState();
}

List<MenuItems> cloneList(List<MenuItems> list, List<MenuItems> targetList) {
  for (MenuItems menu in list) {
    targetList.add(MenuItems(
        menuName: menu.menuName,
        menuImage: menu.menuImage,
        imageScale: menu.imageScale));
  }
  return targetList;
}

class _LainnyaPageState extends State<LainnyaPage> {
  bool isEdit = false;
  Queue<int> queueIndexBlank = new Queue();
  List<MenuItems> listMenuFavorit = [];
  List<MenuItems> listMenuLainnya = [];
  double maxChildSize = 0.72;
  ScrollController scrollController = ScrollController();
  SharedPreferences? prefs;
  List<String>? recentDocument;

  @override
  void initState() {
    super.initState();
    setSharedPrefernces();
    getRecentDocument();
  }

  void setSharedPrefernces() async {
    prefs = await SharedPreferences.getInstance();
  }

  void getRecentDocument() {
    recentDocument = prefs?.getStringList("Sivil") ?? [];
  }

  @override
  Widget build(BuildContext context) {
    // Prevent list to be reset when minus/plus button pressed
    if (listMenuFavorit.isEmpty && listMenuLainnya.isEmpty) {
      listMenuFavorit = cloneList(widget.listMenuFavorit, []);
      listMenuLainnya = cloneList(widget.listMenuLainnya, []);
    }

    return Container(
      decoration: BoxDecoration(
        color: whiteBgPage,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
      ),
      child: SingleChildScrollView(
        controller: scrollController,
        physics: ClampingScrollPhysics(),
        child: BlocBuilder<LainnyaBloc, LainnyaState>(
          builder: (context, state) {
            if (state is LainnyaInitial || state is LainnyaSavingState) {
              return _lainnyaPageState(false, state);
            } else if (state is LainnyaEditingState) {
              return _lainnyaPageState(true, state);
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }

  Widget _lainnyaPageState(bool isEdit, state) {
    return Column(
      children: [
        SizedBox(height: 8.w),
        Container(
          width: 28.w,
          height: 4.w,
          decoration: BoxDecoration(
            color: neutral30,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.w),
          child: ListView(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              ..._daftarLayanan(listMenuFavorit, isEdit, true, state),
              SizedBox(height: 8.w),
              ..._daftarLayanan(listMenuLainnya, isEdit, false, state)
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _daftarLayanan(
      List<MenuItems> list, bool isEdit, bool isLayananFavorit, var state) {
    return [
      Text(
        isLayananFavorit ? 'Favorite Services' : 'Other Services',
        style: TextStyle(
          color: blue3,
          fontWeight: FontWeight.bold,
          fontSize: 20.sp,
        ),
      ),
      SizedBox(height: 12.w),
      AlignedGridView.count(
        crossAxisCount: 4,
        mainAxisSpacing: 20,
        crossAxisSpacing: 0.8,
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 8.w),
        physics: NeverScrollableScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (context, index) {
          if (index < list.length) {
            final MenuItems menuItems = list[index];
            if (menuItems.menuName == "skeleton") {
              return skeletonLayanan();
            } else if (isLayananFavorit) {
              return _layananFavorit(menuItems, isEdit, state, index);
            } else {
              return _layananLainnya(menuItems, state, isEdit);
            }
          } else {
            return skeletonLayanan();
          }
        },
      ),
    ];
  }

  Column skeletonLayanan() {
    var skeletonText = Container(
      width: 60.sp,
      height: 10.sp,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r), color: neutral10),
    );
    return Column(children: [
      Container(
        width: 52.r,
        height: 52.r,
        alignment: Alignment.center,
        child: Container(
          height: 30.sp,
          width: 31.sp,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r), color: neutral10),
        ),
      ),
      SizedBox(height: 14.r),
      skeletonText,
      SizedBox(
        height: 4.5.r,
      ),
      skeletonText
    ]);
  }

  Column _layananLainnya(MenuItems menuItems, state, bool isEdit) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: MediaQuery.of(context).size.width > 600 ? 70.r : 52.r,
              width: MediaQuery.of(context).size.width > 600 ? 70.r : 52.r,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  color: Colors.black,
                  boxShadow: shadow3),
              child: InkWell(
                onTap: () => isEdit
                    ? actionAddMenu(menuItems, state)
                    : menus(menuItems, state),
                child: Image.asset(
                  menuItems.menuImage,
                  scale: MediaQuery.of(context).size.width > 600
                      ? 1.7
                      : menuItems.imageScale,
                ),
              ),
            ),
            if (isEdit)
              (Positioned(
                left: -5.w,
                top: -5.h,
                child: GestureDetector(
                  onTap: () {
                    actionAddMenu(menuItems, state);
                  },
                  child: Image.asset(
                    'assets/icons/plus.png',
                    width: 15.w,
                    height: 15.w,
                    color: queueIndexBlank.isEmpty ? neutral30 : null,
                  ),
                ),
              ))
          ],
        ),
        SizedBox(height: 10.w),
        Text(
          menuItems.menuName,
          style: TextStyle(
            color: neutral40,
            fontSize: MediaQuery.of(context).size.width > 600 ? 16.sp : 11.sp,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Column _layananFavorit(MenuItems menuItems, bool isEdit, state, int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: MediaQuery.of(context).size.width > 600 ? 70.r : 52.r,
              width: MediaQuery.of(context).size.width > 600 ? 70.r : 52.r,
              decoration: BoxDecoration(
                  color: (menuItems.menuName == 'Lainnya')
                      ? isEdit
                          ? (queueIndexBlank.isEmpty)
                              ? green3
                              : neutral20
                          : blue4
                      : white,
                  borderRadius: BorderRadius.circular(4.r),
                  boxShadow: shadow3),
              child: InkWell(
                  onTap: () => isEdit
                      ? actionRemoveMenu(menuItems, index, state)
                      : menus(menuItems, state),
                  child: Image.asset(
                    menuItems.menuName == "Lainnya"
                        ? isEdit
                            ? 'assets/icons/save.png'
                            : 'assets/icons/edit.png'
                        : menuItems.menuImage,
                    scale: MediaQuery.of(context).size.width > 600
                        ? 1.7
                        : menuItems.imageScale,
                  )),
            ),
            if (menuItems.menuName != 'Lainnya' && isEdit)
              Positioned(
                left: -5.w,
                top: -5.h,
                child: GestureDetector(
                  onTap: (() {
                    actionRemoveMenu(menuItems, index, state);
                  }),
                  child: Image.asset(
                    'assets/icons/minus.png',
                    width: 15.w,
                    height: 15.w,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 10.w),
        Text(
          (menuItems.menuName == 'Lainnya')
              ? isEdit
                  ? 'Simpan'
                  : 'Edit'
              : menuItems.menuName,
          style: TextStyle(
            color: neutral40,
            fontSize: MediaQuery.of(context).size.width > 600 ? 16.sp : 11.sp,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  void actionAddMenu(MenuItems menuItems, state) {
    if (queueIndexBlank.isNotEmpty) {
      listMenuFavorit[queueIndexBlank.removeFirst()] = menuItems;
      listMenuLainnya
          .removeWhere((menu) => menu.menuName == menuItems.menuName);

      setState(() {});
    }
  }

  void actionRemoveMenu(MenuItems menuItems, int index, state) {
    if (menuItems.menuName == "Lainnya") {
      actionSaveEdit(menuItems, state);
    } else {
      queueIndexBlank.add(index);
      listMenuFavorit[index] = MenuItems(menuName: "skeleton");
      listMenuLainnya.add(menuItems);

      setState(() {});
    }
  }

  void actionSaveEdit(menuItems, state) {
    if (queueIndexBlank.isEmpty) {
      if (state is LainnyaSavingState || state is LainnyaInitial) {
        context.read<LainnyaBloc>().add(LainnyaEditEvent());
      } else if (state is LainnyaEditingState) {
        context.read<LainnyaBloc>().add(LainnyaSaveEvent(
            listMenuFavorit: listMenuFavorit,
            listMenuLainnya: listMenuLainnya));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(comingSoon);
      }
    }
  }

  void menus(menuItems, state) async {
    print(menuItems.menuName);
    switch (menuItems.menuName) {
      case "Kampus Merdeka":
        {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                  create: (context) =>
                      di.locator<KampusmerdekaBloc>()..add(GetKMListEvent()),
                  child: KampusMerdekaPage()),
            ),
          );

          await FirebaseAnalytics.instance.logScreenView(
            screenClass: "Kampus Merdeka",
            screenName: "Kampus Merdeka",
          );
        }
        break;

      case "Beasiswa":
        {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BlocProvider(
                    create: (context) => di.locator<ListBeasiswaBloc>()
                      ..add(FetchListBeasiswaEvent()),
                    child: BeasiswaMainPage())),
          );

          await FirebaseAnalytics.instance.logScreenView(
            screenClass: "Beasiswa",
            screenName: "Beasiswa",
          );
        }
        break;

      case "PDDikti":
        {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => di.locator<PencarianSpesifikBloc>()
                  ..add(InitPencarianSpesifikEvent()),
                child: PDDiktiMainPage(),
              ),
            ),
          );

          await FirebaseAnalytics.instance.logScreenView(
            screenClass: "PDDikti",
            screenName: "PDDikti",
          );
        }
        break;

      case "Ijazah LN":
        {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => IjazahLNMainPage(),
            ),
          );

          await FirebaseAnalytics.instance.logScreenView(
            screenClass: "Ijazah LN",
            screenName: "Ijazah LN",
          );
        }
        break;

      case "Selancar\nPAK":
        {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocBuilder<ProfilBloc, ProfilState>(
                  builder: (context, state) {
                if (state is ProfilLoadedState) {
                  UserInformationDetail? _userInfoDetail =
                      state.userInformationDetail;
                  if (_userInfoDetail.role == 'Dosen') {
                    return BlocProvider(
                      create: (context) => di.locator<SelancarloggedinBloc>()
                        ..add(
                          SelancarGetProfileEvent(nidn: _userInfoDetail.nidn!),
                        ),
                      child: SelancarPAKLoggedInPage(
                        avatar: state.userAvatar,
                        userInfoDetail: _userInfoDetail,
                      ),
                    );
                  } else {
                    return SelancarPAKPage();
                  }
                } else {
                  return SelancarPAKPage();
                }
              }),
            ),
          );

          await FirebaseAnalytics.instance.logScreenView(
            screenClass: "Selancar PAK",
            screenName: "Selancar PAK",
          );
        }
        break;

      case "SIVIL":
        {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => di.locator<SivilBloc>(),
                child: SivilMainPage(),
              ),
            ),
          );

          await FirebaseAnalytics.instance.logScreenView(
            screenClass: "SIVIL",
            screenName: "SIVIL",
          );
        }
        break;

      case "Garuda":
        {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GarudaMainPage()),
          );

          await FirebaseAnalytics.instance.logScreenView(
            screenClass: "Garuda",
            screenName: "Garuda",
          );
        }
        break;

      case "Kedaireka":
        {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => KedairekaMainPage(),
            ),
          );

          await FirebaseAnalytics.instance.logScreenView(
            screenClass: "Kedaireka",
            screenName: "Kedaireka",
          );
        }
        break;

      case "Sinta":
        {
          Navigator.push(
              context, MaterialPageRoute(builder: (builder) => SintaPage()));

          await FirebaseAnalytics.instance.logScreenView(
            screenClass: "Sinta",
            screenName: "Sinta",
          );
        }
        break;

      case "Siaga":
        {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => di.locator<SiagaBloc>(),
                  ),
                  BlocProvider(
                    create: (context) => TipePencarianCubit(),
                  ),
                ],
                child: SiagaPage(),
              ),
            ),
          );

          await FirebaseAnalytics.instance.logScreenView(
            screenClass: "Siaga",
            screenName: "Siaga",
          );
        }
        break;

      case "Kompetensi Dosen":
        {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => di.locator<ListTawaranProgramBloc>()
                      ..add(GetListTawaranProgramEvent()),
                  ),
                  BlocProvider(
                    create: (context) => di.locator<LoginKdBloc>(),
                  ),
                ],
                child: KompetensiDosenPage(
                  parentContext: context,
                ),
              ),
            ),
          );

          await FirebaseAnalytics.instance.logScreenView(
            screenClass: "Kompetensi Dosen",
            screenName: "Kompetensi Dosen",
          );
        }
        break;

      case "Tracer Study":
        {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TracerStudyPage(),
            ),
          );

          await FirebaseAnalytics.instance.logScreenView(
            screenClass: "Tracer Study",
            screenName: "Tracer Study",
          );
        }
        break;

      case "SISTER":
        {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocBuilder<ProfilBloc, ProfilState>(
                  builder: (context, state) {
                if (state is ProfilLoadedState) {
                  // return SisterLoggedInPage();
                  UserInformationDetail? _userInfoDetail =
                      state.userInformationDetail;
                  if (_userInfoDetail.role == 'Dosen') {
                    return BlocProvider(
                      create: (context) => di.locator<SisterLoggedinBloc>()
                        ..add(SisterGetProfileEvent(nidn: _userInfoDetail.nidn!)
                            // SisterLoggedinEvent(nidn: _userInfoDetail.nidn!),
                            ),
                      child: SisterLoggedInPage(
                        avatar: state.userAvatar,
                        userInfoDetail: _userInfoDetail,
                      ),
                    );
                  } else {
                    return SisterPage();
                  }
                } else {
                  return SisterPage();
                }
              }),
            ),
          );
          await FirebaseAnalytics.instance.logScreenView(
            screenClass: "SISTER",
            screenName: "SISTER",
          );
        }
        break;

      case "G-Magz":
        {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                      create: (context) =>
                          di.locator<MajalahDetailGMagzBloc>()),
                  // BlocProvider(
                  //   create: (context) => di.locator<LoginKdBloc>(),
                  // ),
                ],
                child: GMagzPage(),
              ),
            ),
          );
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => GMagzPage(),
          //   ),
          // );

          await FirebaseAnalytics.instance.logScreenView(
            screenClass: "G-Magz",
            screenName: "G-Magz",
          );
        }
        break;

      // case "BIMA":
      //   {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) => BlocBuilder<ProfilBloc, ProfilState>(
      //                   builder: (context, state) {
      //                 if (state is ProfilLoadedState) {
      //                   UserInformationDetail? _userInfoDetail =
      //                       state.userInformationDetail;
      //                   if (_userInfoDetail.role == 'Dosen') {
      //                     return BlocProvider(
      //                       create: (context) => //BimaLoggedinBlogkh
      //                           di.locator<SisterLoggedinBloc>()
      //                             ..add(
      //                               SisterGetProfileEvent(
      //                                   nidn: _userInfoDetail.nidn!),
      //                             ),
      //                       child: BimaLoggedInProfilePage(),
      //                     );
      //                   } else {
      //                     return BimaPage();
      //                   }
      //                 } else {
      //                   return BimaPage();
      //                 }
      //               })),
      //     );
      //
      //     await FirebaseAnalytics.instance.logScreenView(
      //       screenClass: "BIMA",
      //       screenName: "BIMA",
      //     );
      //   }
      //   break;

      case "Lainnya":
        {
          actionSaveEdit(menuItems, state);
        }
        break;

      default:
        {
          ScaffoldMessenger.of(context).showSnackBar(comingSoon);
        }
        break;
    }
  }
}
