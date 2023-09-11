import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/detail_pencarian/pt/detail_pencarian_pt_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/card/cardPerguruanTinggi.dart';
import 'package:app/presentation/pages/beranda/pddikti/cubit/tab_bar/tab_bar_cubit.dart';
import 'package:app/presentation/pages/beranda/pddikti/detailPerguruanTinggiPage.dart';
import 'package:app/presentation/pages/beranda/searchPage/component/searchNotFound.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PDDiktiPencarianPT extends StatelessWidget {
  final List<dynamic> ptList;
  const PDDiktiPencarianPT({Key? key, required this.ptList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      child: ListView(
        children: [
          SizedBox(
            height: screenHeight(context) * (1 / 30),
          ),
          ptList.isEmpty
              ? searchNotFound('Perguruan Tinggi')
              : ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: this.ptList.length,
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
                              builder: (context) => MultiBlocProvider(
                                providers: [
                                  BlocProvider(
                                    create: (context) =>
                                        di.locator<DetailPencarianPtBloc>()
                                          ..add(LoadPencarianEvent(
                                            kodePT: this.ptList[index].kodePt,
                                            fromSpecific: false,
                                          )),
                                  ),
                                  BlocProvider(
                                    create: (context) => TabBarCubit(),
                                  ),
                                ],
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
    );
  }
}
