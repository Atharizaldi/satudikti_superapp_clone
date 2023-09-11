import 'package:app/data/source/remote/model/profil/user_detail_information.dart';
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/inkEffect.dart';
import 'package:app/presentation/pages/beranda/sister/biodata/Biodata_page.dart';
import 'package:app/presentation/pages/beranda/sister/biodata/bloc/biodata_sister_bloc.dart';
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
import 'package:app/presentation/pages/profil/bloc/profil_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DataPribadiProfile extends StatelessWidget {
  const DataPribadiProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF9FAFE),
        appBar: CustomAppBar(
          title: 'Data Pribadi',
        ),
        body: _body(context));
  }

  Widget _body(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          serviceCard(
            'Biodata',
            'Data identitas diri secara keseluruhan',
            () {
              Navigator.push(
                context,
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
                          return DataPribadiProfile();
                        }
                      } else {
                        return DataPribadiProfile();
                      }
                    },
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
            'Penempatan',
            'Data penempatan, jabatan fungsional, kepangkatan, dan inpassing',
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocBuilder<ProfilBloc, ProfilState>(
                    builder: (context, state) {
                      if (state is ProfilLoadedState) {
                        UserInformationDetail? _userInformationDetail =
                            state.userInformationDetail;
                        if (_userInformationDetail.role == 'Dosen') {
                          return BlocProvider(
                            create: (context) =>
                                di.locator<PenempatanSisterBloc>()
                                  ..add(
                                    GetPenempatanSisterEvent(
                                      nidn: _userInformationDetail.nidn!,
                                    ),
                                  ),
                            child: Penempatan(),
                          );
                        } else {
                          return DataPribadiProfile();
                        }
                      } else {
                        return DataPribadiProfile();
                      }
                    },
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
                  builder: (context) => BlocBuilder<ProfilBloc, ProfilState>(
                    builder: (context, state) {
                      if (state is ProfilLoadedState) {
                        UserInformationDetail? _userInformationDetail =
                            state.userInformationDetail;
                        if (_userInformationDetail.role == 'Dosen') {
                          return BlocProvider(
                            create: (context) =>
                                di.locator<PendidikanSisterBloc>()
                                  ..add(
                                    GetPendidikanSisterEvent(
                                      nidn: _userInformationDetail.nidn!,
                                    ),
                                  ),
                            child: PendidikanPage(),
                          );
                        } else {
                          return DataPribadiProfile();
                        }
                      } else {
                        return DataPribadiProfile();
                      }
                    },
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
                  builder: (context) => BlocBuilder<ProfilBloc, ProfilState>(
                    builder: (context, state) {
                      if (state is ProfilLoadedState) {
                        UserInformationDetail? _userInformationDetail =
                            state.userInformationDetail;
                        if (_userInformationDetail.role == 'Dosen') {
                          return BlocProvider(
                            create: (context) =>
                                di.locator<PenelitianSisterBloc>()
                                  ..add(
                                    GetPenelitianSisterEvent(
                                      nidn: _userInformationDetail.nidn!,
                                    ),
                                  ),
                            child: PenelitianPage(),
                          );
                        } else {
                          return DataPribadiProfile();
                        }
                      } else {
                        return DataPribadiProfile();
                      }
                    },
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
                  builder: (context) => BlocBuilder<ProfilBloc, ProfilState>(
                    builder: (context, state) {
                      if (state is ProfilLoadedState) {
                        UserInformationDetail? _userInformationDetail =
                            state.userInformationDetail;
                        if (_userInformationDetail.role == 'Dosen') {
                          return BlocProvider(
                            create: (context) =>
                                di.locator<PengabdianSisterBloc>()
                                  ..add(
                                    GetPengabdianSisterEvent(
                                      nidn: _userInformationDetail.nidn!,
                                    ),
                                  ),
                            child: PengabdianPage(),
                          );
                        } else {
                          return DataPribadiProfile();
                        }
                      } else {
                        return DataPribadiProfile();
                      }
                    },
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
                  builder: (context) => BlocBuilder<ProfilBloc, ProfilState>(
                    builder: (context, state) {
                      if (state is ProfilLoadedState) {
                        UserInformationDetail? _userInformationDetail =
                            state.userInformationDetail;
                        if (_userInformationDetail.role == 'Dosen') {
                          return BlocProvider(
                            create: (context) =>
                                di.locator<PraktisiSisterBloc>()
                                  ..add(
                                    GetPraktisiSisterEvent(
                                      nidn: _userInformationDetail.nidn!,
                                    ),
                                  ),
                            child: PraktisiPage(),
                          );
                        } else {
                          return DataPribadiProfile();
                        }
                      } else {
                        return DataPribadiProfile();
                      }
                    },
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
        ],
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
}
