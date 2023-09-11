import 'dart:typed_data';

import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/profile_photo.dart';
import 'package:app/presentation/pages/profil/bloc/profil_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hex/hex.dart';

class ProfilDetail extends StatefulWidget {
  const ProfilDetail({Key? key}) : super(key: key);

  @override
  State<ProfilDetail> createState() => _ProfilDetailState();
}

class _ProfilDetailState extends State<ProfilDetail> {
  late ProfilBloc _profilBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBgPage,
      appBar: CustomAppBar(
        title: "Data Personal",
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    _profilBloc = BlocProvider.of<ProfilBloc>(context);
    return BlocBuilder<ProfilBloc, ProfilState>(
      builder: (context, state) {
        if (state is ProfilLoadedState) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30.h),
                _profil(
                  state.userAvatar,
                  state.userInformationDetail.nama != null &&
                          state.userInformationDetail.nama != ''
                      ? state.userInformationDetail.nama!
                      : '-',
                  state.userInformationDetail.role!,
                  state.userInformationDetail.jenisKelamin!,
                  state.userInformationDetail.userID!,
                ),
                _cardAttribute(
                  30.h,
                  'assets/profil/email.png',
                  "Email",
                  state.userInformationDetail.namaPengguna != null &&
                          state.userInformationDetail.namaPengguna != ''
                      ? state.userInformationDetail.namaPengguna!
                      : '-',
                ),
                _cardAttribute(
                  12.h,
                  'assets/profil/nidn.png',
                  "NIDN",
                  state.userInformationDetail.nidn != null &&
                          state.userInformationDetail.nidn != ''
                      ? state.userInformationDetail.nidn!
                      : '-',
                ),
                _cardAttribute(
                  12.h,
                  'assets/profil/institusi.png',
                  "Institusi",
                  state.userInformationDetail.namaPT != null &&
                          state.userInformationDetail.namaPT != ''
                      ? state.userInformationDetail.namaPT!
                      : '-',
                ),
                _cardAttribute(
                  12.h,
                  'assets/profil/jabatan.png',
                  "Jabatan",
                  state.userInformationDetail.role != null &&
                          state.userInformationDetail.role != ''
                      ? state.userInformationDetail.role!
                      : '-',
                ),
                _cardAttribute(
                  12.h,
                  'assets/profil/program_studi.png',
                  "Program Studi",
                  state.userInformationDetail.namaProdi != null &&
                          state.userInformationDetail.namaProdi != ''
                      ? state.userInformationDetail.namaProdi!
                      : '-',
                ),
                _cardAttribute(
                  12.h,
                  'assets/profil/jenis_kelamin.png',
                  "Jenis Kelamin",
                  state.userInformationDetail.jenisKelamin != null &&
                          state.userInformationDetail.jenisKelamin != ''
                      ? state.userInformationDetail.jenisKelamin == "L"
                          ? "Laki-laki"
                          : "Perempuan"
                      : "-",
                ),
                SizedBox(height: 30.h),
              ],
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _profil(String image, String fullName, String role, String gender,
      String userId) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
          gradient: appBarGradient, borderRadius: BorderRadius.circular(10.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {},
              child: Stack(
                children: [
                  if (image != null)
                    GestureDetector(
                      child: Container(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            backgroundImage: MemoryImage(
                              Uint8List.fromList(HEX.decode(image)),
                            ),
                            radius: 35.w,
                          )),
                      onTap: () {
                        _profilBloc.getFromGallery(userId);
                      },
                    )
                  else
                    GestureDetector(
                      child: Container(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            backgroundImage: AssetImage(
                              defaultProfilePhoto(role: role, gender: gender),
                            ),
                            radius: 35.w,
                          )),
                      onTap: () {
                        _profilBloc.getFromGallery(userId);
                      },
                    ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        child: Image.asset(
                          'assets/profil/ic_edit.png',
                          width: 25.w,
                          height: 25.w,
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                        ),
                      )),
                ],
              ),
            ),
            SizedBox(
              width: 16.w,
            ),
            Expanded(
              flex: 1,
              child: Text(
                fullName,
                style: TextStyle(
                    color: white, fontWeight: FontWeight.w700, fontSize: 14.sp),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _cardAttribute(
      double marginTop, String image, String title, String value) {
    return Card(
      margin: EdgeInsets.only(top: marginTop, left: 16.w, right: 16.w),
      color: white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              image,
              width: 24.w,
              height: 24.w,
            ),
            SizedBox(
              width: 16.w,
            ),
            Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          color: neutral30,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      value,
                      style: TextStyle(
                          color: blue4,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
