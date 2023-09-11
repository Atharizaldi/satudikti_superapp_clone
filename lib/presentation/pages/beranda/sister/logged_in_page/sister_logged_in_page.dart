import 'dart:typed_data';

import 'package:app/data/source/remote/model/profil/user_detail_information.dart';
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/SkeletonLoading.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customSliverBar.dart';
import 'package:app/presentation/component/inkEffect.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/component/profile_photo.dart';
import 'package:app/presentation/component/server_problem.dart';
import 'package:app/presentation/pages/beranda/sister/biodata/Biodata_page.dart';
import 'package:app/presentation/pages/beranda/sister/biodata/bloc/biodata_sister_bloc.dart';
import 'package:app/presentation/pages/beranda/sister/bkd/bkd_page.dart';
import 'package:app/presentation/pages/beranda/sister/bkd/bloc/bkd_bloc.dart';
import 'package:app/presentation/pages/beranda/sister/component/header_sister.dart';
import 'package:app/presentation/pages/beranda/sister/component/skeleton_loading_sister.dart';
import 'package:app/presentation/pages/beranda/sister/logged_in_page/bloc/sister_logged_in_bloc.dart';
import 'package:app/presentation/pages/beranda/sister/pendidikan/bloc/pendidikan_formal_dosen/pendidikan_formal_sister_bloc.dart';
import 'package:app/presentation/pages/beranda/sister/pendidikan/pendidikan_page.dart';
import 'package:app/presentation/pages/beranda/sister/penelitian/bloc/penelitian_sister_bloc.dart';
import 'package:app/presentation/pages/beranda/sister/penelitian/penelitian_page.dart';
import 'package:app/presentation/pages/beranda/sister/penempatan/bloc/penempatan_sister_bloc.dart';
import 'package:app/presentation/pages/beranda/sister/penempatan/penempatan_page.dart';
import 'package:app/presentation/pages/beranda/sister/pengabdian/bloc/pengabdian_sister_bloc.dart';
import 'package:app/presentation/pages/beranda/sister/pengabdian/pengabdian_page.dart';
import 'package:app/presentation/pages/beranda/sister/praktisi/bloc/praktisi_bloc.dart';
import 'package:app/presentation/pages/beranda/sister/praktisi/praktisi_page.dart';
import 'package:app/presentation/pages/faq/bloc/faq_module/faqmodule_bloc.dart';
import 'package:app/presentation/pages/faq/faq_page_per_module.dart';
import 'package:app/presentation/pages/profil/bloc/profil_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hex/hex.dart';

import '../sister_page.dart';

class SisterLoggedInPage extends StatelessWidget {
  final UserInformationDetail userInfoDetail;
  final String avatar;

  const SisterLoggedInPage({
    Key? key,
    required this.avatar,
    required this.userInfoDetail,
  }) : super(key: key);

  // const SisterLoggedInPage();

  @override
  Widget build(BuildContext context) {
    print("========================= MASUK KE BUILD======================");
    return BlocConsumer<SisterLoggedinBloc, SisterLoggedinState>(
        listener: (context, state) {
      print("========================= MASUK KE BLOC======================");

      if (state is SisterLoggedInNoInternetState) {
        print("========================= MASUK KE LOG======================");

        ScaffoldMessenger.of(context).showSnackBar(noInternet);
      }
    }, builder: (context, state) {
      if (state is SisterLoggedInNoInternetState) {
        // return Text("NO internet");
        return _sisterLoggedInState(context, state, state.nidn);
      } else if (state is SisterLoggedInErrorState) {
        // return Text("tes1");
        return _sisterLoggedInState(context, state, state.nidn);
      } else if (state is SisterLoggedInLoadedState) {
        // return Text("ted2");
        return _sisterLoggedInState(context, state, state.nidn);
      } else {
        // return Text("ASDSASAD");
        return _sisterLoggedInState(context, state, ''); // Temporary case
      }
    });
    // return Material(
    //   child: _sisterLoggedInState(context),
    // );
  }

  Widget _sisterLoggedInState(
    BuildContext context,
    SisterLoggedinState state,
    String nidn,
    // state = SisterLoggedinInitial,
  ) {
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<SisterLoggedinBloc>(context)
          ..add(SisterGetProfileEvent(nidn: nidn));
        return Future.delayed(Duration(seconds: 1));
      },
      child: Container(
        decoration: BoxDecoration(gradient: sliverBgGradient),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: CustomSliverBar(
              expandedHeight: 250.h,
              appBarTitle: 'SISTER',
              header: FlexibleSpaceBar(
                background: headerSister(context),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    left: 16.w, right: 16.w, bottom: 20.h, top: 30.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    state is SisterLoggedinInitial
                        ? Column(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 17.w, right: 18.w),
                                child: SkeletonLoading(
                                  width: double.infinity,
                                  height: 135.h,
                                  cornerRadius: 4.r,
                                ),
                              ),
                              SizedBox(height: 28.h),
                            ],
                          )
                        : Text(
                            "Profil Saya",
                            style: TextStyle(
                              color: blue3,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: _loggedInProfileCard(context, state, () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (builder) => BlocProvider(
                        //       create: (create) => di
                        //         .locator<BiodataSisterBloc>()
                        //         ..add(GetBiodataSisterEvent(nidn: nidn)),
                        //         child: Biodata(),
                        //     ),
                        //   ),
                        // );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                BlocBuilder<ProfilBloc, ProfilState>(
                              builder: (context, state) {
                                if (state is ProfilLoadedState) {
                                  // return SisterLoggedInPage();
                                  UserInformationDetail? _userInfoDetail =
                                      state.userInformationDetail;
                                  if (_userInfoDetail.role == 'Dosen') {
                                    return BlocProvider(
                                      create: (context) =>
                                          di.locator<BiodataSisterBloc>()
                                            ..add(GetBiodataSisterEvent(
                                                nidn: _userInfoDetail.nidn!)),
                                      // SisterLoggedinEvent(nidn: _userInfoDetail.nidn!),
                                      child: Biodata(),
                                    );
                                  } else {
                                    return SisterPage();
                                  }
                                } else {
                                  return SisterPage();
                                }
                              },
                            ),
                          ),
                        );
                      }, nidn),
                    ),
                    state is SisterLoggedinInitial
                        ? Column(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 17.w, right: 18.w),
                                child: SkeletonLoading(
                                  width: double.infinity,
                                  height: 135.h,
                                  cornerRadius: 4.r,
                                ),
                              ),
                              SizedBox(height: 28.h),
                            ],
                          )
                        : Text(
                            "Cek Data Saya",
                            style: TextStyle(
                              color: blue3,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                    SizedBox(height: 20.h),

                    state is SisterLoggedinInitial
                        ? Column(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 17.w, right: 18.w),
                                child: SkeletonLoading(
                                  width: double.infinity,
                                  height: 135.h,
                                  cornerRadius: 4.r,
                                ),
                              ),
                              SizedBox(height: 28.h),
                            ],
                          )
                        : Column(
                            children: [
                              SizedBox(height: 12.h),
                              serviceCard(
                                'Penempatan',
                                'Data penempatan, jabatan fungsional, kepangkatan, dan inpassing',
                                () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (builder) => BlocProvider(
                                        create: (create) =>
                                            di.locator<PenempatanSisterBloc>()
                                              ..add(
                                                GetPenempatanSisterEvent(
                                                  nidn: nidn,
                                                ),
                                              ),
                                        child: Penempatan(),
                                      ),
                                    ),
                                  );
                                },
                                Image.asset(
                                  "assets/sister/penempatan_logo.png",
                                  width: 18.w,
                                  height: 20.h,
                                  alignment: Alignment.center,
                                ),
                              ),
                              SizedBox(height: 12.h),
                              serviceCard(
                                'Pendidikan',
                                'Data pendidikan formal, diklat, pengajaran, pembimbingan, dan pengujian',
                                () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (builder) => BlocProvider(
                                        create: (context) =>
                                            di.locator<PendidikanSisterBloc>()
                                              ..add(
                                                GetPendidikanSisterEvent(
                                                  nidn: nidn,
                                                ),
                                              ),
                                        child: PendidikanPage(),
                                      ),
                                    ),
                                  );
                                },
                                Image.asset(
                                  "assets/sister/pendidikan_logo.png",
                                  width: 18.w,
                                  height: 20.h,
                                  alignment: Alignment.center,
                                ),
                              ),
                              SizedBox(height: 12.h),
                              serviceCard(
                                'Penelitian',
                                'Data penelitian dan publikasi',
                                () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (builder) => BlocProvider(
                                        create: (context) =>
                                            di.locator<PenelitianSisterBloc>()
                                              ..add(
                                                GetPenelitianSisterEvent(
                                                  nidn: nidn,
                                                ),
                                              ),
                                        child: PenelitianPage(),
                                      ),
                                    ),
                                  );
                                },
                                Image.asset(
                                  "assets/sister/penelitian_logo.png",
                                  width: 18.w,
                                  height: 20.h,
                                  alignment: Alignment.center,
                                ),
                              ),
                              SizedBox(height: 12.h),
                              serviceCard(
                                'Pengabdian',
                                'Data pengabdian',
                                () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (builder) => BlocProvider(
                                        create: (context) =>
                                            di.locator<PengabdianSisterBloc>()
                                              ..add(
                                                GetPengabdianSisterEvent(
                                                  nidn: nidn,
                                                ),
                                              ),
                                        child: PengabdianPage(),
                                      ),
                                    ),
                                  );
                                },
                                Image.asset(
                                  "assets/sister/pengabdian_logo.png",
                                  width: 18.w,
                                  height: 20.h,
                                  alignment: Alignment.center,
                                ),
                              ),
                              SizedBox(height: 12.h),
                              serviceCard(
                                'Praktisi',
                                'Data praktisi',
                                () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (builder) => BlocProvider(
                                        create: (context) =>
                                            di.locator<PraktisiSisterBloc>()
                                              ..add(
                                                GetPraktisiSisterEvent(
                                                  nidn: nidn,
                                                ),
                                              ),
                                        child: PraktisiPage(),
                                      ),
                                    ),
                                  );
                                },
                                Image.asset(
                                  "assets/sister/praktisi_logo.png",
                                  width: 18.w,
                                  height: 20.h,
                                  // fit: BoxFit.fill,
                                  alignment: Alignment.center,
                                ),
                              ),
                              SizedBox(height: 12.h),
                              serviceCard(
                                'Beban Kerja Dosen (BKD)',
                                'Rekrutmen asesor BKD dan penilaian asesor BKD',
                                () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (builder) => BlocProvider(
                                        create: (context) =>
                                            di.locator<BKDSisterBloc>()
                                              ..add(
                                                GetBKDSisterEvent(
                                                    nidn: nidn,
                                                    judul: "",
                                                    sortBy: ""),
                                              ),
                                        child: BKDPage(),
                                      ),
                                    ),
                                  );
                                },
                                Image.asset(
                                  "assets/sister/bkd_logo.png",
                                  width: 20.w,
                                  height: 20.h,
                                  // fit: BoxFit.fill,
                                  alignment: Alignment.center,
                                ),
                              ),
                            ],
                          ),

                    SizedBox(height: 20.h),
                    // state is SisterLoggedinInitial
                    //     ? Column(
                    //         children: [
                    //           Padding(
                    //             padding: EdgeInsets.only(left: 17.w, right: 18.w),
                    //             child: SkeletonLoading(
                    //               width: double.infinity,
                    //               height: 135.h,
                    //               cornerRadius: 4.r,
                    //             ),
                    //           ),
                    //           SizedBox(height: 28.h),
                    //         ],
                    //       )
                    //     : informasiMutakhir(context),
                    state is SisterLoggedinInitial
                        ? Column(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 17.w, right: 18.w),
                                child: SkeletonLoading(
                                  width: double.infinity,
                                  height: 135.h,
                                  cornerRadius: 4.r,
                                ),
                              ),
                              SizedBox(height: 28.h),
                            ],
                          )
                        : _bannerFAQ(context),
                    SizedBox(height: 20.h),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Widget serviceCard(
      String title, String subTitle, VoidCallback onTap, Widget centerImage) {
    return InkEffect(
      onTap: onTap,
      boxDecoration: BoxDecoration(
          color: white, borderRadius: BorderRadius.circular(10.r)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                color: biruMuda3,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(child: centerImage),
            ),
            SizedBox(width: 20.w),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: blue4,
                        fontWeight: FontWeight.w600,
                        fontSize: 15.sp),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subTitle,
                    // textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: blue5,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 15.w),
            Icon(
              Icons.navigate_next,
              color: blue4,
              size: 24.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _bannerFAQ(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return BlocProvider(
                create: (context) => di.locator<FaqmoduleBloc>()
                  ..add(FetchfaqModuleEvent('sister')),
                child: FAQModul(),
              );
            },
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.w, horizontal: 0.h),
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
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 50.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          // borderRadius: BorderRadius.circular(25.r)),
                          shape: BoxShape.circle),
                    ),
                    Image.asset(
                      'assets/faq/sister_lihat_faq.png',
                      width: 34.w,
                      height: 41.h,
                      scale: 2.0,
                    ),
                  ],
                ),
                SizedBox(width: 15.w),
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
                        SizedBox(width: 2.w),
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

  Widget _loggedInProfileCard(BuildContext context, SisterLoggedinState state,
      VoidCallback onTap, String nidn) {
    if (state is SisterLoggedinInitial) {
      return SkeletonLoadingSISTER();
    } else if (state is SisterLoggedInLoadedState) {
      if (state.profileDetail.data.nama.isEmpty) {
        return SkeletonLoadingSISTER();
      } else {
        return InkEffect(
            onTap: onTap,
            boxDecoration: BoxDecoration(
                color: white, borderRadius: BorderRadius.circular(10.r)),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image.network(
                  //   //state.profileDetail.data.avatar
                  //   // 'assets/profil/general.png',
                  //   state.avatarPhoto,
                  //   width: 64.sp,
                  //   height: 64.sp,
                  //   fit: BoxFit.cover,
                  //   alignment: Alignment.topCenter,
                  // ),
                  CircleAvatar(
                    backgroundImage: MemoryImage(
                      Uint8List.fromList(HEX.decode(state.dataDosen[1])),
                    ),
                    radius: 32.w,
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.profileDetail.data.nama,
                          style: TextStyle(
                            color: blue4,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        // Text(
                        //   state.profileDetail.data.universitas,
                        //   style: TextStyle(
                        //       color: Colors.Black,
                        //       fontWeight: FontWeight.w500,
                        //       fontSize: 12.sp),
                        // ),
                        SizedBox(height: 4.h),

                        Text(
                          // 'NIDN/NIP/NIDK: ' + state.profileDetail.data.nidn,
                          state.dataDosen[2],
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          // 'NIDN/NIP/NIDK: ' + state.profileDetail.data.nidn,
                          "NIDN/NIP/NIDK: ${state.dataDosen[3]}",
                          style: TextStyle(
                              color: teksAbuCerah4,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp),
                        ),
                        SizedBox(height: 20.h),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                            width: 125.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: biruMuda4,
                            ),
                            child: Center(
                              child: Text(
                                'Lihat Biodata',
                                style: TextStyle(
                                  color: blue4,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
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
            ));
      }
    } else {
      if (state is SisterLoggedInNoInternetState) {
        return Container(
          color: Colors.transparent,
          height: screenHeight(context) * 0.5,
          child: NoInternet(onPressed: () {}, buttonHide: true),
        );
      } else if (state is SisterLoggedInNotFoundState) {
        // return SkeletonLoadingSISTER();

        return InkEffect(
          boxDecoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BlocProvider(
                          create: (context) => di.locator<BiodataSisterBloc>()
                            ..add(GetBiodataSisterEvent(nidn: nidn)),
                          child: Biodata(),
                        )));
          },
          child: Container(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      defaultProfilePhoto(
                        role: userInfoDetail.role!,
                        gender: userInfoDetail.jenisKelamin!,
                      ),
                      width: 64.w,
                      height: 64.w,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                    SizedBox(width: 20.w),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                        create: (context) =>
                                            di.locator<BiodataSisterBloc>()
                                              ..add(GetBiodataSisterEvent(
                                                  nidn: nidn)),
                                        child: Biodata(),
                                      )));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.profileSisterDetail == null
                                  ? userInfoDetail.nama!
                                  : state.profileSisterDetail!.data.nama,
                              style: TextStyle(
                                color: blue4,
                                fontWeight: FontWeight.w700,
                                fontSize: 14.sp,
                              ),
                            ),
                            Text(state.profileSisterDetail == null
                                ? userInfoDetail.role!
                                : state.profileSisterDetail!.data.nama),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 20.w),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: InkEffect(
                        boxDecoration: BoxDecoration(
                          color: biruMuda3,
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                        create: (context) =>
                                            di.locator<BiodataSisterBloc>()
                                              ..add(GetBiodataSisterEvent(
                                                  nidn: nidn)),
                                        child: Biodata(),
                                      )));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 10.w),
                          child: Text(
                            "Lihat Biodata",
                            style: TextStyle(
                                color: blue4,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        )),
                  ),
                )
              ],
            ),
          ),
        );
      } else if (state is SisterLoggedInErrorState) {
        return Container(
          color: Colors.transparent,
          height: screenHeight(context) * 0.5,
          child: ServerProblem(onPressed: () {}, buttonHide: true),
        );
      } else {
        return Container(
          color: Colors.transparent,
          height: screenHeight(context) * 0.5,
          child: ServerProblem(onPressed: () {}, buttonHide: true),
        );
      }
    }
  }
}
