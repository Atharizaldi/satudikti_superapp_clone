import 'dart:typed_data';

import 'package:app/common/dateFormat.dart';
import 'package:app/data/source/remote/model/profil/user_detail_information.dart';
import 'package:app/data/source/remote/model/selancar/usulan_detail.dart';
import 'package:app/data/source/remote/model/selancar/usulan_list.dart';
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/SkeletonLoading.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customPercentIndicator.dart';
import 'package:app/presentation/component/customSliverBar.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/component/no_data_in_page.dart';
import 'package:app/presentation/component/profile_photo.dart';
import 'package:app/presentation/component/server_problem.dart';
import 'package:app/presentation/pages/beranda/selancarPAK/component/header_PAK.dart';
import 'package:app/presentation/pages/beranda/selancarPAK/component/informasi_mutakhir_PAK.dart';
import 'package:app/presentation/pages/beranda/selancarPAK/component/skeleton_loading_PAK.dart';
import 'package:app/presentation/pages/beranda/selancarPAK/loggedInPage/bloc/selancarloggedin_bloc.dart';
import 'package:app/presentation/pages/beranda/selancarPAK/riwayat_usulan/daftar_usulan/bloc/daftar_riwayatusulan_bloc.dart';
import 'package:app/presentation/pages/beranda/selancarPAK/riwayat_usulan/daftar_usulan/daftar_riwayat_usulan_page.dart';
import 'package:app/presentation/pages/beranda/selancarPAK/riwayat_usulan/detail_usulan/detail_riwayat_usulan_page.dart';
import 'package:app/presentation/pages/faq/bloc/faq_module/faqmodule_bloc.dart';
import 'package:app/presentation/pages/faq/faq_page_per_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hex/hex.dart';

class SelancarPAKLoggedInPage extends StatelessWidget {
  final UserInformationDetail userInfoDetail;
  final String avatar;
  const SelancarPAKLoggedInPage(
      {Key? key, required this.avatar, required this.userInfoDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SelancarloggedinBloc, SelancarloggedinState>(
        listener: (context, state) {
      if (state is SelancarLoggedInNoInternetState) {
        ScaffoldMessenger.of(context).showSnackBar(noInternet);
      }
    }, builder: (context, state) {
      if (state is SelancarLoggedInNoInternetState) {
        return _selancarPAKLoggedInState(context, state, state.nidn);
      } else if (state is SelancarLoggedInErrorState) {
        return _selancarPAKLoggedInState(context, state, state.nidn);
      } else if (state is SelancarLoggedInLoadedState) {
        return _selancarPAKLoggedInState(context, state, state.nidn);
      } else {
        return _selancarPAKLoggedInState(context, state, ''); // Temporary case
      }
    });
  }

  Widget _selancarPAKLoggedInState(
    BuildContext context,
    SelancarloggedinState state,
    String nidn,
  ) {
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<SelancarloggedinBloc>(context)
          ..add(SelancarGetProfileEvent(nidn: nidn));
        return Future.delayed(Duration(seconds: 1));
      },
      child: Container(
        decoration: BoxDecoration(gradient: sliverBgGradient),
        child: Scaffold(
          backgroundColor: Color.fromARGB(0, 71, 16, 16),
          body: CustomSliverBar(
            appBarTitle: 'Selancar PAK',
            header: headerPAK(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 20.h,
                    horizontal: 16.w,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 20.h,
                    horizontal: 20.w,
                  ),
                  decoration: BoxDecoration(
                    color: white,
                    boxShadow: shadow1,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: _loggedInProfileCard(context, state),
                ),
                SizedBox(height: 8.h),
                Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w),
                  child: Text(
                    "Informasi Mutakhir Selancar PAK",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: blue3,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                state is SelancarloggedinInitial
                    ? Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 17.w, right: 18.w),
                            child: SkeletonLoading(
                              width: double.infinity,
                              height: 135.h,
                              cornerRadius: 4.r,
                            ),
                          ),
                          SizedBox(height: 28.h),
                        ],
                      )
                    : informasiMutakhir(context),
                _bannerFAQ(context),
                SizedBox(height: 20.h),
              ],
            ),
          ),
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
                  ..add(FetchfaqModuleEvent('pak-dosen')),
                child: FAQModul(),
              );
            },
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 25.w, horizontal: 15.h),
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
                Container(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/faq/faq_icon.png'),
                  ),
                ),
                SizedBox(width: 20.w),
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
                        SizedBox(
                          width: 2,
                        ),
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

  Widget _loggedInProfileCard(
    BuildContext context,
    SelancarloggedinState state,
  ) {
    if (state is SelancarloggedinInitial) {
      return SkeletonLoadingPAK();
    } else if (state is SelancarLoggedInLoadedState) {
      if (state.profileDetail.data.nama.isEmpty ||
          state.usulanList.isEmpty ||
          state.usulanDetail.message == '') {
        return SkeletonLoadingPAK();
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                avatar == ""
                    ? Container(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          backgroundImage: AssetImage(
                            defaultProfilePhoto(
                                role: userInfoDetail.role!,
                                gender: userInfoDetail.jenisKelamin!),
                          ),
                          radius: 32.w,
                        ))
                    : Container(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          backgroundImage: MemoryImage(
                            Uint8List.fromList(HEX.decode(avatar)),
                          ),
                          radius: 32.w,
                        )),
                SizedBox(width: 20.w),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => ProfilDetail(),
                      //   ),
                      // );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.profileDetail.data.nama,
                          style: TextStyle(
                            color: blue4,
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 48.h),
            Text(
              "Pengajuan Baru",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: blue3,
              ),
            ),
            SizedBox(height: 20.h),
            _lastUsulan(context, state),
            SizedBox(height: 20.h),
            _daftarUsulanPageButton(context, state),
          ],
        );
      }
    } else {
      if (state is SelancarLoggedInNoInternetState) {
        return Container(
          color: Colors.transparent,
          height: screenHeight(context) * 0.5,
          child: NoInternet(onPressed: () {}, buttonHide: true),
        );
      } else if (state is SelancarLoggedInNotFoundState) {
        return Column(
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
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => ProfilDetail(),
                      //   ),
                      // );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.profilePAKDetail == null
                              ? userInfoDetail.nama!
                              : state.profilePAKDetail!.data.nama,
                          style: TextStyle(
                            color: blue4,
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 48.h),
            Text(
              "Pengajuan Baru",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: blue3,
              ),
            ),
            SizedBox(height: 20.h),
            NoDataInPage(
              text: "Anda saat ini tidak memliki ajuan Penilaian Angka Kredit",
            ),
            SizedBox(height: 20.h),
          ],
        );
      } else if (state is SelancarLoggedInErrorState) {
        // return ServerProblem(onPressed: () {}, buttonHide: true);
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

  void _navigateToDetailRiwayat(
    BuildContext context,
    String nama,
    String nidn,
    Usulan last,
    UsulanDetail usulanDetail,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailRiwayatUsulanPage(
          nama: nama,
          nidn: nidn,
          usulanList: last,
          usulanDetail: usulanDetail,
        ),
      ),
    );
  }

  Widget _lastUsulan(BuildContext context, SelancarLoggedInLoadedState state) {
    FormatDate formatDate = FormatDate();
    return GestureDetector(
      onTap: () {
        _navigateToDetailRiwayat(
          context,
          state.profileDetail.data.nama,
          state.profileDetail.data.nidn,
          state.usulanList.last,
          state.usulanDetail,
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 20.h,
        ),
        decoration: BoxDecoration(
          color: whiteBgPage,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText(
                  state.usulanList.last.namaUsulan, //jabatan
                  onTap: () {
                    _navigateToDetailRiwayat(
                      context,
                      state.profileDetail.data.nama,
                      state.profileDetail.data.nidn,
                      state.usulanList.last,
                      state.usulanDetail,
                    );
                  },
                  enableInteractiveSelection: false,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14.sp,
                    color: blue4,
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  height: 21.h,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: green3),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: SelectableText(
                    state.usulanList.last.jenisPengajuan, //jenisPengajuan
                    onTap: () {
                      _navigateToDetailRiwayat(
                        context,
                        state.profileDetail.data.nama,
                        state.profileDetail.data.nidn,
                        state.usulanList.last,
                        state.usulanDetail,
                      );
                    },
                    enableInteractiveSelection: false,
                    style: TextStyle(
                      color: green3,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                SelectableText(
                  state.usulanList.last.nomorSurat, //nomorSurat
                  onTap: () {
                    _navigateToDetailRiwayat(
                      context,
                      state.profileDetail.data.nama,
                      state.profileDetail.data.nidn,
                      state.usulanList.last,
                      state.usulanDetail,
                    );
                  },
                  enableInteractiveSelection: false,
                  style: TextStyle(
                    color: neutral50,
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                SelectableText(
                  formatDate.formatDate(
                    state.usulanList.last.tanggalSurat, //tanggalSurat
                  ),
                  onTap: () {
                    _navigateToDetailRiwayat(
                      context,
                      state.profileDetail.data.nama,
                      state.profileDetail.data.nidn,
                      state.usulanList.last,
                      state.usulanDetail,
                    );
                  },
                  enableInteractiveSelection: false,
                  style: TextStyle(
                    color: neutral30,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
            Spacer(),
            CustomPercentIndicator(
              progressPercentage: state.usulanDetail.progressPercentage,
              containerColor:
                  state.usulanDetail.detailUsulan.last.kelas == 'danger'
                      ? red
                      : green3,
              progressColor:
                  state.usulanDetail.detailUsulan.last.kelas == 'danger'
                      ? red
                      : green3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _daftarUsulanPageButton(
    BuildContext context,
    SelancarLoggedInLoadedState state,
  ) {
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => di.locator<DaftarRiwayatusulanBloc>()
                  ..add(
                    FetchDetailUsulanEvent(
                      nidn: state.profileDetail.data.nidn,
                      usulanList: state.usulanList,
                    ),
                  ),
                child: DaftarRiwayatUsulanPage(
                  nama: state.profileDetail.data.nama,
                  nidn: state.profileDetail.data.nidn,
                  usulanList: state.usulanList,
                ),
              ),
            ),
          );
        },
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
              'Lihat Pengajuan Lainnya',
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
}
