import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/pages/beranda/beasiswa/components/beasiswa_loading.dart';
import 'package:app/presentation/pages/beranda/beasiswa/components/cardBeasiswa.dart';
import 'package:app/presentation/pages/beranda/beasiswa/components/list_pagination_beasiswa/list_pagination_beasiswa_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BeasiswaSedangDibukaLainnyaPage extends StatefulWidget {
  const BeasiswaSedangDibukaLainnyaPage({Key? key}) : super(key: key);

  @override
  State<BeasiswaSedangDibukaLainnyaPage> createState() =>
      _BeasiswaSedangDibukaLainnyaPageState();
}

class _BeasiswaSedangDibukaLainnyaPageState
    extends State<BeasiswaSedangDibukaLainnyaPage> {
  ScrollController scrollController = ScrollController();

  void onScroll(BuildContext context) {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      listPaginationBeasiswaBloc.add(ListPaginationBeasiswaDibukaEvent());
    }
  }

  late ListPaginationBeasiswaBloc listPaginationBeasiswaBloc;
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      listPaginationBeasiswaBloc =
          BlocProvider.of<ListPaginationBeasiswaBloc>(context);
      scrollController.addListener(() {
        onScroll(context);
      });
      return Scaffold(
        backgroundColor: whiteBgPage,
        appBar: CustomAppBar(
          title: "Sedang Dibuka",
        ),
        body: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              SizedBox(
                height: 20.w,
              ),
              BlocBuilder<ListPaginationBeasiswaBloc,
                  ListPaginationBeasiswaState>(
                builder: (context, state) {
                  if (state is ListPaginationBeasiswaLoaded) {
                    final res = state.listBeasiswa;
                    return ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount:
                          (state.hasReachedMax) ? res.length : res.length + 1,
                      itemBuilder: (BuildContext context, index) {
                        if (index < res.length) {
                          return CardBeasiswa(
                            deskripsi: res[index].deskripsi,
                            persyaratan: res[index].persyaratan,
                            url: res[index].linkPendaftaran,
                            namaBeasiswa: res[index].nama,
                            namaInstansi: res[index].penyelenggara,
                            startDate: res[index].tanggalDibuka.toString(),
                            endDate: res[index].tanggalDitutup.toString(),
                            listTagName:
                                res[index].penerima.map((e) => e.nama).toList(),
                            isOpen: res[index].isOpen,
                            urlLampiran: res[index].lampiran!.pathFile,
                            daftar: true,
                            closed: false,
                          );
                        } else {
                          return Center(
                            child: SizedBox(
                              width: 30,
                              height: 30,
                              child:
                                  CircularProgressIndicator(color: blueLinear1),
                            ),
                          );
                        }
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 20.h);
                      },
                    );
                  } else if (state is ListPaginationBeasiswaLoading) {
                    return programBeasiswaLoading();
                  } else {
                    return Container();
                  }
                },
              ),
              SizedBox(
                height: 50.w,
              ),
            ],
          ),
        ),
      );
    });
  }
}
