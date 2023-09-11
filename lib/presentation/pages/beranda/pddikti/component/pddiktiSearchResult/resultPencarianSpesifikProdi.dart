import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/bannerSubJudul.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/detail_pencarian/prodi/detail_pencarian_prodi_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/result_spesifik_bloc/result_spesifik_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/card/cardProdi.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/loadingPddikti/loading_pencarian_specific_pddikti.dart';
import 'package:app/presentation/pages/beranda/pddikti/detailProdiPage.dart';
import 'package:app/presentation/pages/beranda/searchPage/component/searchNotFound.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResultPencarianProdi extends StatefulWidget {
  final String namaProdi;
  final String? kodePT, akreditasi, jenjang;

  const ResultPencarianProdi(
      {Key? key,
      required this.namaProdi,
      this.kodePT,
      this.akreditasi,
      this.jenjang})
      : super(key: key);

  @override
  _ResultPencarianProdiState createState() => _ResultPencarianProdiState();
}

class _ResultPencarianProdiState extends State<ResultPencarianProdi> {
  bool isLoading = true;
  bool isNull = false;
  bool isConnected = false;

  var listProdi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBgPage,
      appBar: CustomAppBar(title: 'Hasil Pencarian'),
      body: BlocConsumer<ResultSpesifikBloc, ResultSpesifikState>(
        listener: (context, state) {
          if (state is ResultProdiLoadedState) {
            listProdi = BlocProvider.of<ResultSpesifikBloc>(context).listProdi;
          } else {
            print('else listener');
          }
        },
        builder: (context, state) {
          return (state is ResultSpesifikNoInternetState)
              ? NoInternet(onPressed: () {}, buttonHide: true)
              : (state is ResultSpesifikLoadingState)
                  ? Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16.w, top: 10.w),
                          child: Container(
                            child: BannerSubJudul(
                              subJudul: 'Hasil Pencarian',
                              warna: blue3,
                              edgeInsets: EdgeInsets.zero,
                            ),
                          ),
                        ),
                        LoadingPencarianSpecifikPDDikti(),
                      ],
                    )
                  : (state is ResultSpesifikNotFoundState)
                      // ? NotFound()
                      ? searchNotFound("Pencarian")
                      : ListView(
                          physics: BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth(context) * (1 / 20),
                                  vertical: screenHeight(context) * (1 / 50)),
                              child: BannerSubJudul(
                                subJudul: 'Hasil Pencarian',
                                warna: blue3,
                                edgeInsets: EdgeInsets.zero,
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth(context) * (1 / 30),
                                ),
                                child: ListView.separated(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: listProdi.data.prodi.length,
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      height: 20.h,
                                    );
                                  },
                                  itemBuilder: (context, index) {
                                    return CardProdi(
                                      namaProdi:
                                          listProdi.data.prodi[index].nama,
                                      lembaga:
                                          listProdi.data.prodi[index].lembaga,
                                      jenjang:
                                          listProdi.data.prodi[index].jenjang,
                                      akreditas:
                                          listProdi.data.prodi[index].akreditas,
                                      status: '',
                                      isDetail: false,
                                      warnaKodePD: neutralCaption,
                                      kodePD: listProdi
                                          .data.prodi[index].kodeProdi
                                          .trim(),
                                      function: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return BlocProvider(
                                              create: (context) => di.locator<
                                                  DetailPencarianProdiBloc>()
                                                ..add(LoadPencarianProdiEvent(
                                                    kodePT: listProdi.data
                                                        .prodi[index].kodePt
                                                        .trim(),
                                                    kodeProdi: listProdi.data
                                                        .prodi[index].kodeProdi
                                                        .trim(),
                                                    fromPT: false)),
                                              child: DetailProdiPage(
                                                kodePT: listProdi
                                                    .data.prodi[index].kodePt
                                                    .trim(),
                                                kodeProdi: listProdi
                                                    .data.prodi[index].kodeProdi
                                                    .trim(),
                                                fromPT: false,
                                              ),
                                            );
                                          },
                                        ));
                                      },
                                    );
                                  },
                                )),
                          ],
                        );
        },
      ),
    );
  }
}
