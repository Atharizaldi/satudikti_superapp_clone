import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/detail_pencarian/mahasiswa/detail_pencarian_mahasiswa_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/card/cardMahasiswaDosen.dart';
import 'package:app/presentation/pages/beranda/pddikti/cubit/tab_bar/tab_bar_cubit.dart';
import 'package:app/presentation/pages/beranda/pddikti/detailMahasiswaPage.dart';
import 'package:app/presentation/pages/beranda/searchPage/component/searchNotFound.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PDDiktiPencarianMahasiswa extends StatelessWidget {
  final List<dynamic> mahasiswaList;
  const PDDiktiPencarianMahasiswa({Key? key, required this.mahasiswaList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth(context) * (1 / 30),
      ),
      child: ListView(
        children: [
          SizedBox(
            height: screenHeight(context) * (1 / 30),
          ),
          mahasiswaList.isEmpty
              ? searchNotFound("Mahasiswa")
              : ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: this.mahasiswaList.length,
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MultiBlocProvider(
                                providers: [
                                  BlocProvider(
                                    create: (context) => di
                                        .locator<DetailPencarianMahasiswaBloc>()
                                      ..add(LoadDetailPencarianEvent(
                                        nomorInduk:
                                            this.mahasiswaList[index].idReg,
                                        kodePT: '',
                                        kodePD: '',
                                        namaPT: '',
                                        namaProdi: '',
                                        nama: this.mahasiswaList[index].nama,
                                        fromElasticGeneral: true,
                                      )),
                                  ),
                                  BlocProvider(
                                    create: (context) => TabBarCubit(),
                                  ),
                                ],
                                child: DetailMahasiswaPage(
                                  nomorInduk: this.mahasiswaList[index].idReg,
                                  kodePT: '',
                                  kodePD: '',
                                  namaPT: '',
                                  namaProdi: '',
                                  nama: this.mahasiswaList[index].nama,
                                  fromElasticGeneral: true,
                                ),
                              ),
                            ));
                      },
                      nomorInduk: this.mahasiswaList[index].nim,
                      nama: this.mahasiswaList[index].nama,
                      namaProdi: this.mahasiswaList[index].prodi,
                      namaPerguruanTinggi: this.mahasiswaList[index].pt,
                    );
                  },
                ),
        ],
      ),
    );
  }
}
