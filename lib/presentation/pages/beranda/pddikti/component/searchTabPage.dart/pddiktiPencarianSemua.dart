import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/sub_title_with_arrow_lainnya.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/detail_pencarian/dosen/detail_pencarian_dosen_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/detail_pencarian/mahasiswa/detail_pencarian_mahasiswa_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/detail_pencarian/prodi/detail_pencarian_prodi_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/detail_pencarian/pt/detail_pencarian_pt_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/card/cardMahasiswaDosen.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/card/cardPerguruanTinggi.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/card/cardProdi.dart';
import 'package:app/presentation/pages/beranda/pddikti/detailDosenPage.dart';
import 'package:app/presentation/pages/beranda/pddikti/detailMahasiswaPage.dart';
import 'package:app/presentation/pages/beranda/pddikti/detailPerguruanTinggiPage.dart';
import 'package:app/presentation/pages/beranda/pddikti/detailProdiPageReg.dart';
import 'package:app/presentation/pages/beranda/searchPage/component/searchNotFound.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PDDiktiPencarianSemua extends StatelessWidget {
  final VoidCallback perguruanTinggiButton,
      prodiButton,
      dosenButton,
      mahasiswaButton;

  final List<dynamic> ptList, prodiList, dosenList, mahasiswaList;

  const PDDiktiPencarianSemua(
      {Key? key,
      required this.perguruanTinggiButton,
      required this.prodiButton,
      required this.dosenButton,
      required this.mahasiswaButton,
      required this.ptList,
      required this.prodiList,
      required this.dosenList,
      required this.mahasiswaList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ptList.isEmpty &&
            prodiList.isEmpty &&
            dosenList.isEmpty &&
            mahasiswaList.isEmpty
        ? Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth(context) * (1 / 30),
            ),
            margin: EdgeInsets.only(
              top: screenHeight(context) * (1 / 30),
            ),
            child: searchNotFound('Pencarian'))
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                this.mahasiswaList.isEmpty
                    ? Container()
                    : Column(
                        children: [
                          SizedBox(height: 30.h),
                          SubTitleWithArrowLainnya(
                            subJudul: 'Data Mahasiswa',
                            function: this.mahasiswaButton,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: this.mahasiswaList.length > 3
                                ? 3
                                : this.mahasiswaList.length,
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 20.h,
                              );
                            },
                            itemBuilder: (context, index) {
                              return CardMahasiswaDosen(
                                isMahasiswa: true,
                                isDetail: false,
                                function: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return BlocProvider(
                                        create: (context) => di.locator<
                                            DetailPencarianMahasiswaBloc>()
                                          ..add(LoadDetailPencarianEvent(
                                              nama: this
                                                  .mahasiswaList[index]
                                                  .nama,
                                              nomorInduk: this
                                                  .mahasiswaList[index]
                                                  .idReg,
                                              kodePT: '',
                                              kodePD: '',
                                              namaPT: '',
                                              namaProdi: '',
                                              fromElasticGeneral: true)),
                                        child: DetailMahasiswaPage(
                                            nama:
                                                this.mahasiswaList[index].nama,
                                            nomorInduk:
                                                this.mahasiswaList[index].idReg,
                                            kodePT: '',
                                            kodePD: '',
                                            namaPT: '',
                                            namaProdi: '',
                                            fromElasticGeneral: true),
                                      );
                                    },
                                  ));
                                },
                                nomorInduk: this.mahasiswaList[index].nim,
                                nama: this.mahasiswaList[index].nama,
                                namaProdi: this.mahasiswaList[index].prodi,
                                namaPerguruanTinggi:
                                    this.mahasiswaList[index].pt,
                              );
                            },
                          ),
                        ],
                      ),
                this.ptList.isEmpty
                    ? Container()
                    : Column(
                        children: [
                          SizedBox(height: 30.h),
                          SubTitleWithArrowLainnya(
                              subJudul: 'Data Perguruan Tinggi',
                              function: this.perguruanTinggiButton),
                          SizedBox(
                            height: 20.h,
                          ),
                          ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                this.ptList.length > 3 ? 3 : this.ptList.length,
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 20.h,
                              );
                            },
                            itemBuilder: (context, index) {
                              return CardPerguruanTinggi(
                                namaPt: this.ptList[index].nama,
                                npsn: this.ptList[index].kodePt,
                                logo: '',
                                function: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BlocProvider(
                                          create: (context) => di
                                              .locator<DetailPencarianPtBloc>()
                                            ..add(LoadPencarianEvent(
                                              kodePT: this.ptList[index].kodePt,
                                              fromSpecific: false,
                                            )),
                                          child: DetailPerguruanTinggiPage(
                                            kodePT: this.ptList[index].kodePt,
                                            fromSpecific: false,
                                          ),
                                        ),
                                      ));
                                },
                              );
                            },
                          ),
                        ],
                      ),
                SizedBox(
                  height: 30.h,
                ),
                this.dosenList.isEmpty
                    ? Container()
                    : Column(
                        children: [
                          SubTitleWithArrowLainnya(
                              subJudul: 'Data Dosen',
                              function: this.dosenButton),
                          SizedBox(
                            height: 20.h,
                          ),
                          ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: this.dosenList.length > 3
                                ? 3
                                : this.dosenList.length,
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 20.h,
                              );
                            },
                            itemBuilder: (context, index) {
                              return CardMahasiswaDosen(
                                isMahasiswa: false,
                                isDetail: false,
                                function: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BlocProvider(
                                          create: (context) => di.locator<
                                              DetailPencarianDosenBloc>()
                                            ..add(
                                              LoadDetailPencarianDosenEvent(
                                                null,
                                                nama:
                                                    this.dosenList[index].nama,
                                                namaPT:
                                                    this.dosenList[index].pt,
                                                namaProdi:
                                                    this.dosenList[index].prodi,
                                                nomorInduk:
                                                    this.dosenList[index].nidn,
                                              ),
                                            ),
                                          child: DetailDosenPage(
                                            nama: this.dosenList[index].nama,
                                            namaPT: this.dosenList[index].pt,
                                            namaProdi:
                                                this.dosenList[index].prodi,
                                            nomorInduk:
                                                this.dosenList[index].nidn,
                                          ),
                                        ),
                                      ));
                                },
                                nomorInduk: this.dosenList[index].nidn,
                                nama: this.dosenList[index].nama,
                                namaProdi: this.dosenList[index].prodi,
                                namaPerguruanTinggi: this.dosenList[index].pt,
                              );
                            },
                          ),
                        ],
                      ),
                SizedBox(
                  height: 30.h,
                ),
                this.prodiList.isEmpty
                    ? Container()
                    : Column(
                        children: [
                          SubTitleWithArrowLainnya(
                              subJudul: 'Data Prodi',
                              function: this.prodiButton),
                          SizedBox(
                            height: 20.h,
                          ),
                          ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: this.prodiList.length > 3
                                ? 3
                                : this.prodiList.length,
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 20.h,
                              );
                            },
                            itemBuilder: (context, index) {
                              return CardProdi(
                                namaProdi: this.prodiList[index].nama,
                                lembaga: this.prodiList[index].lembaga,
                                akreditas: this.prodiList[index].akreditas,
                                jenjang: this.prodiList[index].jenjang,
                                status: 'XXXXX',
                                kodePD: '',
                                isDetail: false,
                                warnaKodePD: Colors.transparent,
                                function: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BlocProvider(
                                          create: (context) => di.locator<
                                              DetailPencarianProdiBloc>()
                                            ..add(
                                              LoadPencarianProdiRegEvent(
                                                fromPT: false,
                                                idReg:
                                                    this.prodiList[index].idReg,
                                              ),
                                            ),
                                          child: DetailProdiPageReg(
                                            fromPT: false,
                                            idReg: this.prodiList[index].idReg,
                                          ),
                                        ),
                                      ));
                                },
                              );
                            },
                          ),
                        ],
                      ),
                SizedBox(
                  height: 30.h,
                ),
              ],
            ),
          );
  }
}
