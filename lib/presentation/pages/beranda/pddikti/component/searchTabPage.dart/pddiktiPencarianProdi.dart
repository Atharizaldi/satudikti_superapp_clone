import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/detail_pencarian/prodi/detail_pencarian_prodi_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/card/cardProdi.dart';
import 'package:app/presentation/pages/beranda/pddikti/cubit/tab_bar/tab_bar_cubit.dart';
import 'package:app/presentation/pages/beranda/pddikti/detailProdiPageReg.dart';
import 'package:app/presentation/pages/beranda/searchPage/component/searchNotFound.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PDDiktiPencarianProdi extends StatelessWidget {
  final List<dynamic> prodiList;
  const PDDiktiPencarianProdi({Key? key, required this.prodiList})
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
          prodiList.isEmpty
              ? searchNotFound('Program Studi')
              : ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: this.prodiList.length,
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
                              builder: (context) => MultiBlocProvider(
                                providers: [
                                  BlocProvider(
                                    create: (context) =>
                                        di.locator<DetailPencarianProdiBloc>()
                                          ..add(LoadPencarianProdiRegEvent(
                                            fromPT: false,
                                            idReg: this.prodiList[index].idReg,
                                          )),
                                  ),
                                  BlocProvider(
                                    create: (context) => TabBarCubit(),
                                  ),
                                ],
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
    );
  }
}
