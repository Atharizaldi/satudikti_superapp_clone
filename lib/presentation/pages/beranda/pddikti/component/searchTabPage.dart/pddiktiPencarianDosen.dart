import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/detail_pencarian/dosen/detail_pencarian_dosen_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/card/cardMahasiswaDosen.dart';
import 'package:app/presentation/pages/beranda/pddikti/cubit/tab_bar/tab_bar_cubit.dart';
import 'package:app/presentation/pages/beranda/pddikti/detailDosenPage.dart';
import 'package:app/presentation/pages/beranda/searchPage/component/searchNotFound.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PDDiktiPencarianDosen extends StatelessWidget {
  final List<dynamic> dosenList;
  const PDDiktiPencarianDosen({Key? key, required this.dosenList})
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
          dosenList.isEmpty
              ? searchNotFound('Dosen')
              : ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: this.dosenList.length,
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
                              builder: (context) => MultiBlocProvider(
                                providers: [
                                  BlocProvider(
                                    create: (context) =>
                                        di.locator<DetailPencarianDosenBloc>()
                                          ..add(
                                            LoadDetailPencarianDosenEvent(
                                              null,
                                              nama: this.dosenList[index].nama,
                                              namaPT: this.dosenList[index].pt,
                                              namaProdi:
                                                  this.dosenList[index].prodi,
                                              nomorInduk:
                                                  this.dosenList[index].nidn,
                                            ),
                                          ),
                                  ),
                                  BlocProvider(
                                    create: (context) => TabBarCubit(),
                                  ),
                                ],
                                child: DetailDosenPage(
                                  nama: this.dosenList[index].nama,
                                  namaPT: this.dosenList[index].pt,
                                  namaProdi: this.dosenList[index].prodi,
                                  nomorInduk: this.dosenList[index].nidn,
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
    );
  }
}
