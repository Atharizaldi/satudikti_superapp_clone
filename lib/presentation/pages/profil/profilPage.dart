import 'dart:io' show Platform;
import 'dart:typed_data';

import 'package:app/common/launchUrl.dart';
import 'package:app/data/source/remote/model/profil/user_detail_information.dart';
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/inkEffect.dart';
import 'package:app/presentation/component/profile_photo.dart';
import 'package:app/presentation/pages/beranda/sister/biodata/Biodata_page.dart';
import 'package:app/presentation/pages/beranda/sister/biodata/bloc/biodata_sister_bloc.dart';
import 'package:app/presentation/pages/hubungiKamiPage.dart';
import 'package:app/presentation/pages/profil/bloc/profil_bloc.dart';
import 'package:app/presentation/pages/profil/notification/notificationSettings.dart';
import 'package:app/presentation/pages/profil/sso/utils/sso_utils.dart';
import 'package:app/presentation/pages/profil/tentangKami/tentangKami.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hex/hex.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  late ProfilBloc _profilBloc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBgPage,
      appBar: _appBar(),
      body: _body(context),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        'Profil',
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.sp),
      ),
      flexibleSpace: Container(
          decoration: BoxDecoration(
        gradient: appBarGradient,
      )),
      centerTitle: true,
      elevation: 0,
    );
  }

  Widget _body(BuildContext context) {
    _profilBloc = BlocProvider.of<ProfilBloc>(context);

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 30.h,
          ),
          _profil(),
          SizedBox(
            height: 30.h,
          ),
          _settings(context),
        ],
      ),
    );
  }

  Widget _profil() {
    return BlocBuilder<ProfilBloc, ProfilState>(builder: (context, state) {
      if (state is ProfilLoadedState) {
        print('ini userAvatar ${state.userAvatar}');
        return _cardProfil(
          context: context,
          name: state.userInformationDetail.nama!,
          role: state.userInformationDetail.role!,
          universitas: state.userInformationDetail.namaPT!,
          nidn: state.userInformationDetail.nidn!,
          gender: state.userInformationDetail.jenisKelamin!,
          avatar: state.userAvatar,
          isLoggedIn: true,
          isDosenOnlyModule: false,
          userId: state.userInformationDetail.userID!,
        );
      } else if (state is ProfilNotLogInState) {
        return _cardProfil(
            context: context, isLoggedIn: false, isDosenOnlyModule: false);
      } else {
        return _cardProfil(
            context: context, isLoggedIn: false, isDosenOnlyModule: false);

        // return Center(
        //   child: CircularProgressIndicator(
        //     color: blueLinear1,
        //   ),
        // );
      }
    });
  }

  Widget _cardProfil(
      {required BuildContext context,
      required bool isDosenOnlyModule,
      String name = "Login",
      String role = "",
      String universitas = "Silahkan login terlebih dahulu",
      String nidn = "",
      String gender = "L",
      String avatar = "",
      bool isLoggedIn = false,
      String? userId}) {
    // return InkEffect(
    // margin: EdgeInsets.symmetric(horizontal: 16.w),
    // boxDecoration: BoxDecoration(
    //   color: Colors.white,
    //   borderRadius: BorderRadius.circular(10.r),
    // ),
    // onTap: () {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => BlocProvider(
    //         create: (context) =>
    //           di.locator<BiodataSisterBloc>()
    //           ..add(GetBiodataSisterEvent(nidn: nidn)),
    //         child: Biodata(),
    //       )));},
    return InkEffect(
      boxDecoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      onTap: () async {
        if (isLoggedIn) {
          Navigator.push(
            context,
            // MaterialPageRoute(
            //   builder: (context) => DataPribadiProfile(),
            // )
            MaterialPageRoute(
              builder: (context) => BlocBuilder<ProfilBloc, ProfilState>(
                builder: (context, state) {
                  if (state is ProfilLoadedState) {
                    UserInformationDetail? _userInformationDetail =
                        state.userInformationDetail;
                    if (_userInformationDetail.role == 'Dosen') {
                      return BlocProvider(
                        create: (context) => di.locator<BiodataSisterBloc>()
                          ..add(
                            GetBiodataSisterEvent(
                              nidn: _userInformationDetail.nidn!,
                            ),
                          ),
                        child: Biodata(),
                      );
                    } else {
                      return ProfilPage();
                    }
                  } else {
                    return ProfilPage();
                  }
                },
              ),
            ),
          );
        } else {
          authorizationUrl = await createClient();
          print("AUTHORIZATIONURL $authorizationUrl");
          showSSOLoginPage(context, authorizationUrl);
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isLoggedIn
                ? avatar == ""
                    ? Container(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          backgroundImage: AssetImage(
                            defaultProfilePhoto(role: role, gender: gender),
                          ),
                          radius: 32.w,
                        ))
                    : GestureDetector(
                        onTap: () {
                          _profilBloc.getFromGallery(userId!);
                        },
                        child: Stack(
                          children: [
                            Container(
                                alignment: Alignment.center,
                                child: CircleAvatar(
                                  backgroundImage: MemoryImage(
                                    Uint8List.fromList(HEX.decode(avatar)),
                                  ),
                                  radius: 32.w,
                                )),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 25.w,
                                    height: 25.h,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(25 / 2.r),
                                      color: Colors.grey.withOpacity(0.5),
                                    ),
                                  ),
                                  Image.asset('assets/edit_icon.png',
                                      width: 12.w,
                                      height: 12.h,
                                      fit: BoxFit.contain,
                                      alignment: Alignment.center)
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                : Image.asset(
                    'assets/profil/general.png',
                    width: 64.w,
                    height: 64.w,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
            SizedBox(
              width: 20.w,
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isLoggedIn ? name : "Anda belum login",
                    style: TextStyle(
                      color: blue4,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    universitas,
                    style: TextStyle(
                        color: isLoggedIn ? Colors.black : teksAbuCerah4,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    isLoggedIn ? 'NIDN/NIP/NIDK: $nidn' : "",
                    style: TextStyle(
                        color: teksAbuCerah4,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp),
                  ),
                  SizedBox(
                    height: 6.sp,
                  ),
                  SizedBox(height: 20.sp),
                  isLoggedIn
                      ? Container()
                      : Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: 70.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: blue4,
                            ),
                            child: Center(
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    // );
  }

  Widget _settings(BuildContext context) {
    return Column(
      children: [
        Container(
          // margin: EdgeInsets.symmetric(horizontal: 16.w),
          alignment: Alignment.centerLeft,
          child: Text(
            "Pengaturan",
            style: TextStyle(
                color: blue3, fontWeight: FontWeight.w700, fontSize: 20.sp),
          ),
        ),
        _cardSetting(20.h, 'assets/profil/notif.png', "Pengaturan Notifikasi",
            () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NotificationSettings(),
              ));
        }),
        _cardSetting(
            12.h, 'assets/profil/tentang_satudikti.png', "Tentang Satudikti",
            () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TentangKami()));
        }, 22.sp, 22.sp),
        _cardSetting(12.h, 'assets/profil/ulasan.png', "Beri Ulasan Satudikti",
            () {
          if (Platform.isAndroid) {
            launchURL(
                'https://play.google.com/store/apps/details?id=id.satudikti.app');
          } else if (Platform.isIOS) {
            launchURL(
                'https://apps.apple.com/id/app/satudikti/id1602908796?l=id');
          }
        }),
        _cardSetting(12.h, 'assets/profil/hubungikami.png', "Hubungi Kami", () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HubungiKamiPage()));
        }, 22.sp, 22.sp),
        BlocBuilder<ProfilBloc, ProfilState>(
          builder: (context, state) {
            if (state is ProfilLoadedState) {
              return _cardSetting(12.h, 'assets/profil/logout.png', "Log out",
                  () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        insetPadding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.r))),
                        title: Text(
                          "Keluar akun",
                          style: TextStyle(
                              color: blue2,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        content: Text(
                          "Apakah anda ingin keluar dari akun saat ini?",
                          style: TextStyle(color: neutral90, fontSize: 16.sp),
                          textAlign: TextAlign.center,
                        ),
                        actions: [
                          Padding(
                              padding: EdgeInsets.only(bottom: 16.h),
                              child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                            width: 155.w,
                                            height: 42.h,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('Batal',
                                                  style:
                                                      TextStyle(color: blue2)),
                                              style: ElevatedButton.styleFrom(
                                                  side:
                                                      BorderSide(color: blue2),
                                                  primary: Colors.white,
                                                  shadowColor:
                                                      Colors.transparent),
                                            )),
                                        SizedBox(
                                          width: 16.w,
                                        ),
                                        SizedBox(
                                            width: 155.w,
                                            height: 42.h,
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                await showSSOLogoutPage(
                                                    context);
                                                BlocProvider.of<ProfilBloc>(
                                                    context)
                                                  ..add(LogOutEvent());

                                                print("CLIEC");
                                                Navigator.pop(context);
                                              },
                                              child: Text('Keluar'),
                                              style: ElevatedButton.styleFrom(
                                                  primary: blue2,
                                                  shadowColor:
                                                      Colors.transparent),
                                            ))
                                      ])))
                        ],
                      );
                    });
              }, 22.sp, 22.sp, 10.w, red);
            } else {
              return SizedBox();
            }
          },
        ),
      ],
    );
  }

  Widget _cardSetting(
      double marginTop, String image, String title, VoidCallback onTap,
      [iconWidth, iconHeight, iconPaddingRight, fontColor]) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.only(top: marginTop),
        color: white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: biruMuda3,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: Image.asset(
                    image,
                    width: iconWidth ?? 24.sp,
                    height: iconHeight ?? 24.sp,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              SizedBox(
                width: iconPaddingRight ?? 10.w,
              ),
              Expanded(
                flex: 1,
                child: Text(
                  title,
                  style: TextStyle(
                    color: fontColor ?? blue2,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              Icon(
                Icons.navigate_next,
                color: Colors.blue,
                size: 24.sp,
              )
            ],
          ),
        ),
      ),
    );
  }
}
