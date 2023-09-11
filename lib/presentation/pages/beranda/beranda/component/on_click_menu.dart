import 'package:app/data/source/local/model/menuItems.dart';
import 'package:app/data/source/remote/model/profil/user_detail_information.dart';
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/beasiswa/beasiswaMainPage.dart';
import 'package:app/presentation/pages/beranda/beasiswa/get_list_beasiswa_bloc/list_beasiswa_bloc.dart';
import 'package:app/presentation/pages/beranda/beranda/bloc/beranda_bloc.dart';
import 'package:app/presentation/pages/beranda/beranda/bloc/lainnya_bloc.dart';
import 'package:app/presentation/pages/beranda/beranda/lainnyaPage.dart';
import 'package:app/presentation/pages/beranda/garuda/garudaMainPage.dart';
import 'package:app/presentation/pages/beranda/gmagz/gmagz_page.dart';
import 'package:app/presentation/pages/beranda/ijazahln/ijazahlnMainPage.dart';
import 'package:app/presentation/pages/beranda/kampusMerdeka/bloc/kampus_merdeka/kampusmerdeka_bloc.dart';
import 'package:app/presentation/pages/beranda/kampusMerdeka/kampus_merdeka_page.dart';
import 'package:app/presentation/pages/beranda/kedaireka/kedairekaMainPage.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/bloc/list_tawaran_program/list_tawaran_program_bloc.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/bloc/login_kd/login_kd_bloc.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/kompetensiDosenPage.dart';
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
import 'package:app/presentation/pages/beranda/tracerStudy/bloc/tracer_bloc.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/tracer_study_page.dart';
import 'package:app/presentation/pages/profil/bloc/profil_bloc.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//should use enum not hardcode string for every case
void onClickMenu(BuildContext context, MenuItems menuItems, state) async {
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
            builder: (context) =>
                BlocBuilder<ProfilBloc, ProfilState>(builder: (context, state) {
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
              builder: (context) => BlocProvider(
                create: ((context) => di.locator<TracerBloc>()
                  ..add(TracerConfigEvent(
                    moduleId: 14,
                  ))),
                child: TracerStudyPage(),
              ),
            ));

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
            builder: (context) =>
                BlocBuilder<ProfilBloc, ProfilState>(builder: (context, state) {
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
            context, MaterialPageRoute(builder: (builder) => GMagzPage()));

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
    //     await FirebaseAnalytics.instance.logScreenView(
    //       screenClass: "BIMA",
    //       screenName: "BIMA",
    //     );
    //   }
    //   break;

    case "Lainnya":
      {
        print('Lain button');
        showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) {
            if (state is BerandaLoadedState) {
              return BlocProvider(
                create: (context) => di.locator<LainnyaBloc>(),
                child: LainnyaPage(
                    listMenuFavorit: state.listMenuFavorit,
                    listMenuLainnya: state.listMenuLainnya),
              );
            } else {
              return Container();
            }
          },
        ).whenComplete(() {
          BlocProvider.of<BerandaBloc>(context)..add(GetLayananFavoritEvent());
        });
      }
      break;

    default:
      {
        ScaffoldMessenger.of(context).showSnackBar(comingSoon);
      }
      break;
  }
}
