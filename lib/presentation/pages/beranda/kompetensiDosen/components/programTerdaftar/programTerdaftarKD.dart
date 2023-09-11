import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/bloc/penilaian_dosen/penilaian_dosen_bloc.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/bloc/program_terdaftar/program_terdaftar_bloc.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/components/programTerdaftar/cardProgramTerdaftar.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/components/programTerdaftar/detailProgramTerdaftar/detailProgramTerdaftar.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/components/programTerdaftar/skeleton_card_program_terdaftar.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/reusableWidgets/reusableWidgetsCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProgramTerdaftarKD extends StatelessWidget {
  ProgramTerdaftarKD({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBgPage,
      appBar: CustomAppBar(
        title: "Program Terdaftar",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 34.sp,
            ),
            BlocBuilder<ProgramTerdaftarBloc, ProgramTerdaftarState>(
                builder: (context, state) {
              print("pterdaftar state $state");
              if (state is ProgramTerdaftarLoaded) {
                return ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.list.length,
                    itemBuilder: (buildContext, index) {
                      return Column(
                        children: [
                          CardProgramTerdaftar(
                            nama: state.list[index].namaPeriode!,
                            startDate: state.list[index].startDate!,
                            tag: state.list[index].program!,
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => BlocProvider(
                                          create: (context) =>
                                              di.locator<PenilaianDosenBloc>()
                                                ..add(GetPenilaianDosenEvent(
                                                    id: state.list[index]
                                                        .urlRiwayatPenilaian!)),
                                          child: DetailProgramTerdaftar(
                                            namaPeriode:
                                                state.list[index].namaPeriode!,
                                            skema: state.list[index].skema!,
                                            program: state.list[index].program!,
                                            startDate:
                                                state.list[index].startDate!,
                                            endDate: state.list[index].endDate!,
                                            registeredDate: state
                                                .list[index].registeredDate!,
                                            urlSertifikat: state.list[index]
                                                    .urlSertifikat ??
                                                "",
                                            urlRiwayatPenilaian: state
                                                .list[index]
                                                .urlRiwayatPenilaian!,
                                          ),
                                        ))),
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                        ],
                      );
                    });
              } else if (state is ProgramTerdaftarInitial) {
                return listSkeletonProgramTerdaftar();
              } else if (state is ProgramTerdaftarError) {
                return Container(
                  height: 400.w,
                  alignment: Alignment.center,
                  child: serverProblem(),
                );
              } else if (state is ProgramTerdaftarNoInternet) {
                return Container(
                  height: 400.w,
                  alignment: Alignment.center,
                  child: noInternetWithContainer(),
                );
              } else {
                return SizedBox();
              }
            }),
            SizedBox(
              height: 95.sp,
            )
          ],
        ),
      ),
    );
  }

  ListView listSkeletonProgramTerdaftar() {
    return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 4,
        itemBuilder: (buildContext, index) {
          return Column(
            children: [
              SkeletonCardProgramTerdaftar(),
              SizedBox(
                height: 20.sp,
              ),
            ],
          );
        });
  }
}
