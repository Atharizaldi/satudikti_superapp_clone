import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/detail_pencarian/dosen/detail_pencarian_dosen_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/detail_pencarian/mahasiswa/detail_pencarian_mahasiswa_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/result_spesifik_bloc/result_spesifik_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/loadingPddikti/loading_detail_dosen_pddikti.dart';
import 'package:app/presentation/pages/beranda/pddikti/detailDosenPage.dart';
import 'package:app/presentation/pages/beranda/pddikti/detailMahasiswaPage.dart';
import 'package:app/presentation/pages/beranda/searchPage/component/searchNotFound.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultDirectlyDetailMahasiswaDosen extends StatefulWidget {
  final int category;
  final String? nomorInduk;

  const ResultDirectlyDetailMahasiswaDosen({
    Key? key,
    required this.category,
    this.nomorInduk,
  }) : super(key: key);

  @override
  _ResultDirectlyDetailMahasiswaDosenState createState() =>
      _ResultDirectlyDetailMahasiswaDosenState();
}

class _ResultDirectlyDetailMahasiswaDosenState
    extends State<ResultDirectlyDetailMahasiswaDosen> {
  bool isLoading = true;
  bool isConnected = false;
  bool isNull = false;

  var listMahasiswa, listDosen, listProdi, listPT;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResultSpesifikBloc, ResultSpesifikState>(
      listener: (context, state) {
        print("STATE $state");
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
        print("STATE builder $state");
        if (state is ResultDosenLoadedState) {
          return switchCardDetail(1);
        } else if (state is ResultMahasiswaLoadedState) {
          return switchCardDetail(0);
        } else if (state is ResultSpesifikNotFoundState) {
          return Scaffold(
              backgroundColor: whiteBgPage,
              appBar: CustomAppBar(
                title: switchTitle(widget.category),
              ),
              body:
                  // noDataDosen()
                  searchNotFound("Pencarian"));
        } else {
          return Scaffold(
              backgroundColor: whiteBgPage,
              appBar: CustomAppBar(
                title: switchTitle(widget.category),
              ),
              body: LoadingDetailDosenPDDikti());
        }
      },
    );
  }

  String switchTitle(int category) {
    switch (category) {
      case 0:
        return 'Mahasiswa';
      case 1:
        return 'Dosen';
      default:
        return '';
    }
  }

  dynamic switchCardDetail(int category) {
    int index = 0;
    switch (category) {
      case 0:
        return BlocProvider(
          create: (context) => di.locator<DetailPencarianMahasiswaBloc>()
            ..add(LoadDetailPencarianEvent(
              nomorInduk: widget.nomorInduk!,
              kodePD: listMahasiswa.data.mahasiswa[index].kodeProdi,
              kodePT: listMahasiswa.data.mahasiswa[index].npsn,
              namaPT: listMahasiswa.data.mahasiswa[index].namaPt,
              namaProdi: listMahasiswa.data.mahasiswa[index].namaProdi,
              nama: listMahasiswa.data.mahasiswa[index].nmPd,
              fromElasticGeneral: false,
            )),
          child: DetailMahasiswaPage(
            nomorInduk: widget.nomorInduk!,
            kodePD: listMahasiswa.data.mahasiswa[index].kodeProdi,
            kodePT: listMahasiswa.data.mahasiswa[index].npsn,
            namaPT: listMahasiswa.data.mahasiswa[index].namaPt,
            namaProdi: listMahasiswa.data.mahasiswa[index].namaProdi,
            nama: listMahasiswa.data.mahasiswa[index].nmPd,
            fromElasticGeneral: false,
          ),
        );

      case 1:
        return BlocProvider(
          create: (context) => di.locator<DetailPencarianDosenBloc>()
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

      default:
    }
  }
}
