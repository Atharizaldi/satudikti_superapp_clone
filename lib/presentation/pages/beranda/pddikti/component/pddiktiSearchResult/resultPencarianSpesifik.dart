import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/bannerSubJudul.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/detail_pencarian/dosen/detail_pencarian_dosen_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/detail_pencarian/mahasiswa/detail_pencarian_mahasiswa_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/result_spesifik_bloc/result_spesifik_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/card/cardMahasiswaDosen.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/loadingPddikti/loading_pencarian_specific_pddikti.dart';
import 'package:app/presentation/pages/beranda/pddikti/detailDosenPage.dart';
import 'package:app/presentation/pages/beranda/pddikti/detailMahasiswaPage.dart';
import 'package:app/presentation/pages/beranda/searchPage/component/searchNotFound.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResultPencarianMahasiswaDosen extends StatefulWidget {
  final int category;
  final String? nomorInduk, nama, kodePT, kodePD;

  const ResultPencarianMahasiswaDosen(
      {Key? key,
      required this.category,
      this.nomorInduk,
      this.nama,
      this.kodePT,
      this.kodePD})
      : super(key: key);

  @override
  _ResultPencarianMahasiswaDosenState createState() =>
      _ResultPencarianMahasiswaDosenState();
}

class _ResultPencarianMahasiswaDosenState
    extends State<ResultPencarianMahasiswaDosen> {
  bool isLoading = true;
  bool isConnected = false;
  bool isNull = false;

  var listMahasiswa, listDosen, listProdi, listPT;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBgPage,
      appBar: CustomAppBar(title: 'Hasil Pencarian'),
      body: BlocConsumer<ResultSpesifikBloc, ResultSpesifikState>(
        listener: (context, state) {
          if (state is ResultMahasiswaLoadedState) {
            listMahasiswa =
                BlocProvider.of<ResultSpesifikBloc>(context).listMahasiswa;
          } else if (state is ResultDosenLoadedState) {
            listDosen = BlocProvider.of<ResultSpesifikBloc>(context).listDosen;
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
                                child: switchCardDetail(widget.category)),
                          ],
                        );
        },
      ),
    );
  }

  dynamic switchCardDetail(int category) {
    switch (category) {
      case 0:
        return ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: listMahasiswa.data.mahasiswa.length,
          separatorBuilder: (context, builder) {
            return SizedBox(
              height: 20.w,
            );
          },
          itemBuilder: (context, index) {
            return CardMahasiswaDosen(
              isMahasiswa: true,
              isDetail: false,
              nomorInduk: listMahasiswa.data.mahasiswa[index].nipd,
              nama: listMahasiswa.data.mahasiswa[index].nmPd,
              namaProdi: listMahasiswa.data.mahasiswa[index].namaProdi,
              namaPerguruanTinggi: listMahasiswa.data.mahasiswa[index].namaPt,
              function: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return BlocProvider(
                      create: (context) => di
                          .locator<DetailPencarianMahasiswaBloc>()
                        ..add(LoadDetailPencarianEvent(
                          nomorInduk: widget.nomorInduk!,
                          kodePD: listMahasiswa.data.mahasiswa[index].kodeProdi,
                          kodePT: listMahasiswa.data.mahasiswa[index].npsn,
                          namaPT: listMahasiswa.data.mahasiswa[index].namaPt,
                          namaProdi:
                              listMahasiswa.data.mahasiswa[index].namaProdi,
                          nama: listMahasiswa.data.mahasiswa[index].nmPd,
                          fromElasticGeneral: false,
                        )),
                      child: DetailMahasiswaPage(
                        nomorInduk: widget.nomorInduk!,
                        kodePD: listMahasiswa.data.mahasiswa[index].kodeProdi,
                        kodePT: listMahasiswa.data.mahasiswa[index].npsn,
                        namaPT: listMahasiswa.data.mahasiswa[index].namaPt,
                        namaProdi:
                            listMahasiswa.data.mahasiswa[index].namaProdi,
                        nama: listMahasiswa.data.mahasiswa[index].nmPd,
                        fromElasticGeneral: false,
                      ),
                    );
                  },
                ));
              },
            );
          },
        );
      case 1:
        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: listDosen.data.dosen.length,
          itemBuilder: (context, index) {
            return CardMahasiswaDosen(
              isMahasiswa: false,
              isDetail: false,
              nomorInduk: widget.nomorInduk!,
              nama: listDosen.data.dosen[index].nama,
              namaProdi: listDosen.data.dosen[index].nmProdi,
              namaPerguruanTinggi: listDosen.data.dosen[index].nmPt,
              function: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return BlocProvider(
                      create: (context) =>
                          di.locator<DetailPencarianDosenBloc>()
                            ..add(LoadDetailPencarianDosenEvent(
                              null,
                              nomorInduk: widget.nomorInduk!,
                              namaPT: listDosen.data.dosen[index].nmPt,
                              namaProdi: listDosen.data.dosen[index].nmProdi,
                              nama: listDosen.data.dosen[index].nama,
                            )),
                      child: DetailDosenPage(
                        nomorInduk: widget.nomorInduk!,
                        namaPT: listDosen.data.dosen[index].nmPt,
                        namaProdi: listDosen.data.dosen[index].nmProdi,
                        nama: listDosen.data.dosen[index].nama,
                      ),
                    );
                  },
                ));
              },
            );
          },
        );
      default:
    }
  }
}
