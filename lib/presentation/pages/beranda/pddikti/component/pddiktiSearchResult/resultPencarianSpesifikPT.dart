import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/bannerSubJudul.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/detail_pencarian/pt/detail_pencarian_pt_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/result_spesifik_bloc/result_spesifik_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/card/cardPerguruanTinggi.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/loadingPddikti/loading_pencarian_specific_pddikti.dart';
import 'package:app/presentation/pages/beranda/pddikti/detailPerguruanTinggiPage.dart';
import 'package:app/presentation/pages/beranda/searchPage/component/searchNotFound.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResultPencarianPT extends StatefulWidget {
  final String kodePT, kodeProvinsi, tipePT;

  const ResultPencarianPT(
      {Key? key,
      required this.kodePT,
      required this.kodeProvinsi,
      required this.tipePT})
      : super(key: key);

  @override
  _ResultPencarianMahasiswaDosenState createState() =>
      _ResultPencarianMahasiswaDosenState();
}

class _ResultPencarianMahasiswaDosenState extends State<ResultPencarianPT> {
  bool isLoading = true;
  bool isNull = false;
  bool isConnected = false;

  var listPT;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBgPage,
      appBar: CustomAppBar(title: 'Hasil Pencarian'),
      body: BlocConsumer<ResultSpesifikBloc, ResultSpesifikState>(
        listener: (context, state) {
          if (state is ResultPTLoadedState) {
            listPT = BlocProvider.of<ResultSpesifikBloc>(context).listPT;
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
                                  itemCount: listPT.data.pt.length,
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      height: 20.h,
                                    );
                                  },
                                  itemBuilder: (context, index) {
                                    return CardPerguruanTinggi(
                                      namaPt: listPT.data.pt[index].nama,
                                      npsn: listPT.data.pt[index].npsn,
                                      logo: listPT.data.pt[index].logo,
                                      function: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return BlocProvider(
                                              create: (context) => di.locator<
                                                  DetailPencarianPtBloc>()
                                                ..add(LoadPencarianEvent(
                                                    kodePT: listPT
                                                        .data.pt[index].npsn,
                                                    fromSpecific: true)),
                                              child: DetailPerguruanTinggiPage(
                                                kodePT:
                                                    listPT.data.pt[index].npsn,
                                                fromSpecific: true,
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
