import 'dart:typed_data';

import 'package:app/data/source/remote/model/profil/user_detail_information.dart';
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customSliverBar.dart';
import 'package:app/presentation/component/inkEffect.dart';
import 'package:app/presentation/component/login_card.dart';
import 'package:app/presentation/component/no_data_in_page.dart';
import 'package:app/presentation/component/pop_up_alert/show_pop_up_alert.dart';
import 'package:app/presentation/component/profile_photo.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/bloc/file_list/file_list_bloc.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/bloc/list_tawaran_program/list_tawaran_program_bloc.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/bloc/penilaian_dosen/penilaian_dosen_bloc.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/bloc/program_terdaftar/program_terdaftar_bloc.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/components/daftarUnduhan/daftarUnduhan.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/components/jenisProgram/jenisProgramKD.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/components/mainPageKD/cardKD.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/components/mainPageKD/skeleton_card_kd.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/components/mainPageKD/skeleton_loading_kd.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/components/mainPageKD/skeleton_main_program_terdaftar.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/components/programTerdaftar/cardProgramTerdaftar.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/components/programTerdaftar/detailProgramTerdaftar/detailProgramTerdaftar.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/components/programTerdaftar/programTerdaftarKD.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/components/tawaranProgram/detailTawaranProgram.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/pelajariSelengkapnyaKD.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/reusableWidgets/reusableWidgetsCard.dart';
import 'package:app/presentation/pages/profil/bloc/profil_bloc.dart';
import 'package:app/presentation/pages/profil/sso/utils/sso_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hex/hex.dart';
import '../../../../data/source/local/model/jenisProgram.dart';
import '../../../component/sub_title_with_arrow_lainnya.dart';
import '../../showWebsite.dart';
import 'components/jenisProgram/cardJenisProgramKD.dart';

class KompetensiDosenPage extends StatelessWidget {
  final BuildContext parentContext;
  KompetensiDosenPage({Key? key, required this.parentContext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _loginSsoPage(context) async {
      authorizationUrl = await createClient();
      showSSOLoginPage(context, authorizationUrl);
    }

    Future.delayed(
      Duration(microseconds: 500),
      () => showPopUpAlert(context, 'Kompetensi Dosen'),
    );

    return Container(
      color: blueLinear2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomSliverBar(
          appBarTitle: "Kompetensi Dosen",
          header: FlexibleSpaceBar(background: _header(context)),
          expandedHeight: 257.w,
          appBarActions: [
            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (builder) => JenisProgramKD()));
            //   },
            //   child: Padding(
            //     padding: EdgeInsets.only(right: 16.w),
            //     child: ImageIcon(
            //       AssetImage("assets/icons/icon_information.png"),
            //       size: 22.sp,
            //     ),
            //   ),
            // ),
          ],
          child: Column(children: [_slidingUpContent(context)]),
        ),
      ),
    );
  }

  Widget _slidingUpContent(context) {
    var textStyle1 = TextStyle(color: neutral50, fontSize: 14.sp);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<ProfilBloc, ProfilState>(
            builder: (context, state) {
              if (state is ProfilLoadedState) {
                if (state.userInformationDetail.role == "Dosen") {
                  return loggedInCard(
                    avatar: state.userAvatar,
                    userInfoDetail: state.userInformationDetail,
                  );
                } else {
                  return loginCardWithLogoutPopUp(
                    context,
                    'Kompetensi Dosen',
                  );
                }
              } else if (state is ProfilNotLogInState) {
                return LoginCard(isDosenOnlyModule: true);
              } else {
                return SkeletonLoadingKD();
              }
            },
          ),
          SizedBox(height: 48.sp),
          Padding(
            padding: EdgeInsets.only(left: 0.5.w),
            child: Text(
              "Program Dibuka",
              style: styleSubJudul,
            ),
          ),
          SizedBox(
            height: 8.sp,
          ),
          BlocBuilder<ListTawaranProgramBloc, ListTawaranProgramState>(
            builder: (context, state) {
              return RichText(
                  text: TextSpan(children: [
                TextSpan(text: "Ada ", style: textStyle1),
                TextSpan(
                    text: (state is ListTawaranProgramLoaded)
                        ? "${state.list.length}"
                        : "0",
                    style: textStyle1.copyWith(fontWeight: FontWeight.bold)),
                TextSpan(text: " Program yang sedang dibuka", style: textStyle1)
              ]));
            },
          ),
          SizedBox(
            height: 20.sp,
          ),
          BlocBuilder<ListTawaranProgramBloc, ListTawaranProgramState>(
            builder: (context, state) {
              if (state is ListTawaranProgramInitial) {
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (BuildContext context, index) {
                    return Column(
                      children: [
                        SkeletonCardKD(),
                        SizedBox(
                          height: 20.sp,
                        )
                      ],
                    );
                  },
                );
              } else if (state is ListTawaranProgramLoaded) {
                if (state.list.length > 0) {
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.list.length,
                    itemBuilder: (BuildContext context, index) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    // REDIRECT  TO KOMDOS DETAIL AND IN DETAIL TO WEBSITE KOMDOS

                                    return DetailTawaranProgram(
                                        program: state.list[index].program!,
                                        skema: state.list[index].namaPeriode!,
                                        startDate: state.list[index].startDate!,
                                        endDate: state.list[index].endDate!,
                                        urlProgram: "https://kompetensi-ditdaya.kemdikbud.go.id/register");
                                  }));
                            },
                            child: CardKD(
                              nama: state.list[index].namaPeriode!,
                              startDate: state.list[index].startDate!,
                              endDate: state.list[index].endDate!,
                              tag: state.list[index].program!,
                              persyaratan: state.list[index].namaPeriode!,
                            ),
                          ),
                          SizedBox(
                            height: 20.sp,
                          )
                        ],
                      );
                    },
                  );
                } else {
                  return noOpenedProgram();
                }
              } else if (state is ListTawaranProgramError) {
                return serverProblem();
              } else if (state is ListTawaranProgramNoInternet) {
                return noInternetWithContainer();
              } else {
                return SizedBox();
              }
            },
          ),
          SizedBox(
            height: 28.sp,
          ),
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SubTitleWithArrowLainnya(
                    subJudul: "Jenis Program",
                    function: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (builder) => JenisProgramKD()));

                    }),
                SizedBox(height: 20.h),
                CardJenisProgramKD(
                    nama: listJenisProgram[0].nama,
                    deskripsi: listJenisProgram[0].deskripsi),
                SizedBox(
                  height: 20.sp,
                )
              ],
            ),
          ),
          ..._statistikKD(),
          SizedBox(
            height: 24.sp,
          ),
          Text(
            "Informasi Kompetensi Dosen",
            style: styleSubJudul,
          ),
          SizedBox(
            height: 20.sp,
          ),
          _informasiKD(context),
          SizedBox(
            height: 44.sp,
          ),
        ],
      ),
    );
  }

  Widget loggedInCard(
      {required String avatar, required UserInformationDetail userInfoDetail}) {
    return BlocProvider(
      create: (context) => di.locator<ProgramTerdaftarBloc>()
        ..add(
          GetProgramTerdaftarEvent(
            nidn: userInfoDetail.nidn!,
            tahun: "2021",
          ),
        ),
      child: BlocBuilder<ProgramTerdaftarBloc, ProgramTerdaftarState>(
        builder: (context, state) {
          return Container(
            margin: EdgeInsets.only(top: 20.sp),
            padding: EdgeInsets.symmetric(horizontal: 30.sp, vertical: 20.w),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(151, 151, 151, 0.06),
                    offset: Offset(0, 4),
                    blurRadius: 15,
                    spreadRadius: 10)
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        avatar == ""
                        ? Container(
                            alignment: Alignment.center,
                            child : CircleAvatar(
                                      backgroundImage: AssetImage(
                                        defaultProfilePhoto(role: userInfoDetail.role!, gender: userInfoDetail.jenisKelamin!),
                                      ),
                                      radius: 32.w,
                                    )
                          )
                        : Container(
                          alignment : Alignment.center,
                          child : CircleAvatar(
                                    backgroundImage: MemoryImage(
                                      Uint8List.fromList(HEX.decode(avatar)),
                                    ),
                                    radius: 32.w,
                                  )
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
                                userInfoDetail.nama!,
                                style: TextStyle(
                                  color: blue4,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.sp,
                                ),
                              ),
                              SizedBox(
                                height: 6.sp,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 28.sp,
                    ),
                    Text(
                      "Program Terdaftar",
                      style: textStyleParagraph.copyWith(
                          color: blue3, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    BlocBuilder<ProgramTerdaftarBloc, ProgramTerdaftarState>(
                      builder: (context, state) {
                        if (state is ProgramTerdaftarLoaded) {
                          var item;
                          List<String> dateStrings = [];
                          for(int i = 0; i <= state.list.length -1; i++){
                            dateStrings.add(state.list[i].startDate ?? "");
                          }
                          dateStrings.sort((a, b){ //sorting in descending order
                            return DateTime.parse(b).compareTo(DateTime.parse(a));
                          });
                          print(dateStrings);
                          for(int i = 0; i <= state.list.length -1; i++){
                            if(state.list[i].startDate == dateStrings[0]){
                              item = state.list[i];
                            }
                          }
                          return Column(
                            children: [
                              CardProgramTerdaftar(
                                  nama: item.namaPeriode!,
                                  startDate: item.startDate!,
                                  tag: item.program!,
                                  backgroundColor: whiteBgPage,
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) => BlocProvider(
                                            create: (context) =>
                                            di.locator<PenilaianDosenBloc>()
                                              ..add(GetPenilaianDosenEvent(
                                                  id: item.
                                                      urlRiwayatPenilaian!)),
                                            child: DetailProgramTerdaftar(
                                              namaPeriode:
                                              item.namaPeriode!,
                                              skema: item.skema!,
                                              program: item.program!,
                                              startDate:
                                              item.startDate!,
                                              endDate: item.endDate!,
                                              registeredDate: item.registeredDate!,
                                              urlSertifikat: item.urlSertifikat ??
                                                  "",
                                              urlRiwayatPenilaian: item
                                                  .urlRiwayatPenilaian!,
                                            ),
                                          )))),
                              SizedBox(
                                height: 20.sp,
                              ),
                              Material(
                                color: white,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(10.r),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) => BlocProvider(
                                                  create: (context) => di
                                                      .locator<
                                                          ProgramTerdaftarBloc>()
                                                    ..add(
                                                        GetProgramTerdaftarEvent(
                                                            nidn: userInfoDetail.nidn!,
                                                            tahun: "2021")),
                                                  child: ProgramTerdaftarKD(),
                                                )));
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: blue4, width: 1.sp),
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    padding:
                                        EdgeInsets.symmetric(vertical: 15.sp),
                                    child: Text(
                                      "Lihat Program Lainnya",
                                      style: styleGraphSubHeader,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else if (state is ProgramTerdaftarError) {
                          return GestureDetector(
                              onTap: () => Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    //REDIRECT TO WEBSITE KOMDOS

                                    return ShowWebsite(
                                      title: "Kompetensi Dosen",
                                      link:
                                          "https://kompetensi.sumberdaya.kemdikbud.go.id/v2/login",
                                    );
                                  })),
                              child: NoDataInPage(
                                text:
                                    "Anda saat ini tidak terdaftar pada program kompetensi dosen",
                              ));
                        } else {
                          return SkeletonMainProgramTerdaftar();
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget loginCard(context) {
    return GestureDetector(
      onTap: () async {
        // BlocProvider.of<LoginKdBloc>(context)..add(SignInKdEvent());
        authorizationUrl = await createClient();
        print("AUTH URL $authorizationUrl");
        showSSOLoginPage(context, authorizationUrl);
      },
      child: Container(
        margin: EdgeInsets.only(top: 20.sp),
        padding: EdgeInsets.symmetric(horizontal: 30.sp, vertical: 20.w),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(151, 151, 151, 0.06),
                offset: Offset(0, 4),
                blurRadius: 15,
                spreadRadius: 10)
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/profil/general.png',
              width: 64.sp,
              height: 64.sp,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
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
                    "Login",
                    style: TextStyle(
                      color: blue4,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(
                    height: 6.sp,
                  ),
                  Text(
                    "Silahkan Login terlebih dahulu",
                    style: TextStyle(
                        color: teksAbuCerah4,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp),
                  ),
                  SizedBox(height: 20.sp),
                  Text.rich(
                    TextSpan(
                      text: "Login",
                      style: TextStyle(
                        color: red,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                      ),
                      children: [
                        WidgetSpan(
                          child: SizedBox(
                            width: 1.sp,
                          ),
                        ),
                        WidgetSpan(
                          child: Icon(
                            Icons.navigate_next,
                            color: red,
                            size: 12.sp,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _informasiKD(context) {
    return InkEffect(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BlocProvider(
                      create: (context) =>
                          di.locator<FileListBloc>()..add(GetFileListEvent()),
                      child: DaftarUnduhan(),
                    )));
      },
      boxDecoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.r),
            bottomRight: Radius.circular(10.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 0.25,
            blurRadius: 0.6,
            offset: Offset(0, 0.5), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 145.sp,
            decoration: BoxDecoration(
              gradient: kedairekaInformasiBgGradient,
              color: neutral100,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.r),
                topRight: Radius.circular(10.r),
              ),
            ),
            child: Image.asset("assets/kedaireka/btnkedaireka.png"),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 18.sp,
              ),
              Container(
                width: 358.w,
                padding: EdgeInsets.symmetric(horizontal: 16.sp),
                child: Text(
                  "Daftar Informasi Edaran Kompetensi Dosen",
                  style: TextStyle(
                      color: neutral80,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(height: 8.sp),
              Padding(
                padding: EdgeInsets.only(left: 20.sp),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Lihat detail",
                      style: TextStyle(
                          color: Color(0xFF1A689E),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      width: 1.sp,
                    ),
                    Icon(
                      Icons.navigate_next,
                      color: Color(0xFF1A689E),
                      size: 17.sp,
                    )
                  ],
                ),
              ),
              SizedBox(height: 24.sp),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _statistikKD() {
    return [
      Text(
        "Statistik Kompetensi Dosen",
        style: styleSubJudul,
      ),
      SizedBox(
        height: 20.w,
      ),
      Row(
        children: [
          _cardStatistik("Publikasi dihasilkan", 478),
          SizedBox(
            width: 16.w,
          ),
          _cardStatistik("Tawaran Program", 8),
        ],
      ),
    ];
  }

  Widget _cardStatistik(String nama, int jumlah) {
    return Container(
      decoration: BoxDecoration(
          color: white, borderRadius: BorderRadius.circular(10.r)),
      width: 171.w,
      // height: 84.sp,
      padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 18.sp),
      child: Column(
        children: [
          Text(nama,
              style: styleSubJudul2Medium.copyWith(
                color: neutral30,
              )),
          SizedBox(
            height: 12.sp,
          ),
          Text(
            jumlah.toString(),
            style: styleSubJudul2Medium.copyWith(color: orange),
          )
        ],
      ),
    );
  }

  Widget _header(context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(gradient: beasiswaBgGradient),
      child: Stack(children: [
        Positioned(
          left: 110.w,
          bottom: -51.w,
          right: 0,
          child: Image.asset(
            'assets/kompetensiDosen/header_kompetensi_dosen.png',
            width: 342.w,
            height: 341.w,
          ),
        ),
        Positioned(
          left: 30.w,
          bottom: 24.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: AssetImage(
                    "assets/kompetensiDosen/logo_kompetensi_dosen.png"),
                width: 58.w,
                height: 55.w,
              ),
              SizedBox(
                height: 12.w,
              ),
              Text(
                "Tingkatkan kompetensimu melalui\nmodul dan berbagai program\nsertifikasi yang ditawarkan",
                style: TextStyle(
                  color: whiteBgPage,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                  letterSpacing: 0.08.w,
                  height: 1.5,
                ),
              ),
              SizedBox(
                height: 14.w,
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return PelajariSelengkapnyaKD();
                    // ShowWebsite(
                    //   title: "Kompetensi Dosen",
                    //   link: "https://kompetensi.sumberdaya.kemdikbud.go.id/v2/login",
                    // );
                  }),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                        width: 189.w,
                        height: 40.h,
                        padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.r),
                            color: bgPelajariSelengkapnya
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Pelajari Selengkapnya",
                              style: stylePelajariSelengkapnya,
                              textAlign: TextAlign.center,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 14.h,
                            )

                          ],)
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
