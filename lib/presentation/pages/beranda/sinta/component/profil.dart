import 'dart:typed_data';

import 'package:app/data/source/remote/model/profil/user_detail_information.dart';
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/inkEffect.dart';
import 'package:app/presentation/component/profile_photo.dart';
import 'package:app/presentation/pages/beranda/sinta/authors/authors_detail/authors_detail_page.dart';
import 'package:app/presentation/pages/beranda/sinta/authors/authors_detail/bloc/authors_detail_bloc.dart';
import 'package:app/presentation/pages/beranda/sinta/authors/authors_detail/bloc/authors_scopus_publication_bloc.dart';
import 'package:app/presentation/pages/profil/profilDetail/profilDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hex/hex.dart';

Widget profil(
  BuildContext context,
  UserInformationDetail userInformationDetail,
  bool isLogged,
  String avatar,
) {
  return InkEffect(
    onTap: () {},
    boxDecoration:
        BoxDecoration(color: white, borderRadius: BorderRadius.circular(10.r)),
    child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isLogged
                    ? avatar == ""
                        ? Container(
                            alignment: Alignment.center,
                            child: CircleAvatar(
                              backgroundImage: AssetImage(
                                defaultProfilePhoto(
                                  role: userInformationDetail.role!,
                                  gender: userInformationDetail.jenisKelamin!,
                                ),
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
                            ))
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
                        isLogged ? userInformationDetail.nama! : "Login",
                        style: TextStyle(
                            color: Color(0xff248DDA),
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      Text(
                        isLogged
                            ? userInformationDetail.role!
                            : "Silahkan Login terlebih dahulu",
                        style: TextStyle(
                            color: Color(0xff9B9B9B),
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 84.w),
              child: GestureDetector(
                onTap: userInformationDetail.role! == 'Dosen'
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => MultiBlocProvider(
                              providers: [
                                BlocProvider(
                                    create: (context) => di
                                        .locator<AuthorsDetailBloc>()
                                      ..add(GetAuthorsDetailEvent(
                                          nidn: userInformationDetail.nidn ??
                                              ""))),
                                BlocProvider(
                                    create: (context) => di
                                        .locator<AuthorsScopusPublicationBloc>()
                                      ..add(GetAuthorsScopusEvent(
                                          nidn: userInformationDetail.nidn ??
                                              ""))),
                              ],
                              child: AuthorsDetailpage(
                                nidn: userInformationDetail.nidn ?? "",
                              ),
                            ),
                          ),
                        );
                      }
                    : () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfilDetail(),
                            ));
                      },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      userInformationDetail.role! == 'Dosen'
                          ? "Lihat Profil Sinta"
                          : "Lihat Profil",
                      style: TextStyle(
                        color: blue2,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.navigate_next,
                      color: blue2,
                      size: 16,
                    )
                  ],
                ),
              ),
            )
          ],
        )),
  );
}
