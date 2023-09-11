import 'dart:io';

import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/getListPT.dart';
import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/getListProdi.dart';
import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/getSpecificElasticPT.dart';
import 'package:app/data/source/remote/model/tableau.dart';
import 'package:app/domain/usecases/pddikti/getListElasticPTAPI.dart';
import 'package:app/domain/usecases/pddikti/getListElasticProvinsi.dart';
import 'package:app/domain/usecases/pddikti/getListPTAPI.dart';
import 'package:app/domain/usecases/pddikti/getListProdiAPI.dart';
import 'package:app/domain/usecases/pddikti/getStatistic.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pencarian_spesifik_event.dart';
part 'pencarian_spesifik_state.dart';

class PencarianSpesifikBloc
    extends Bloc<PencarianSpesifikEvent, PencarianSpesifikState> {
  GetStatistic getStatisticUseCase;
  GetListPTAPI getListPTAPIUseCase;
  GetListProdiAPI getListProdiAPIUseCase;
  GetListElasticPTAPI getListElasticPTAPIUseCase;
  GetListElasticProvinsi getListElasticProvinsiUseCase;
  Map<String, String> hasilProvinsi = {};
  Tableau? tableauList;
  bool onPTSearch = false;

  PencarianSpesifikBloc(
      {required this.getStatisticUseCase,
      required this.getListPTAPIUseCase,
      required this.getListElasticPTAPIUseCase,
      required this.getListProdiAPIUseCase,
      required this.getListElasticProvinsiUseCase})
      : super(PencarianSpesifikInitialState()) {
    on<InitPencarianSpesifikEvent>(_initEvent);
  }

  void _initEvent(PencarianSpesifikEvent event,
      Emitter<PencarianSpesifikState> emit) async {
    try {
      print('before result initevent');
      bool result = await InternetCheck().hasConnection();
      print('result');
      print(result);
      await getListProvinsi();
      await getStatistic();

      if (result) {
        emit(PencarianSpesifikLoadedState());
      } else {
        emit(PencarianSpesifikNoInternetState());
      }
    } on SocketException {
      print('SocketException');
      emit(PencarianSpesifikNoInternetState());
    } on Exception {
      print('Exception');
      emit(PencarianSpesifikNoInternetState());
    }
  }

  Future<GetListPT?> getListPTAPI(
      String page, String limit, String keyword) async {
    print('getListPTAPI - bloc');
    try {
      final result = await getListPTAPIUseCase.execute(page, limit, keyword);
      return await result.fold((failure) async {
        print('failure - bloc');
        return null;
      }, (getPTList) async {
        print('getPTList - bloc');
        return getPTList;
      });
    } on Exception {
      print('exception on getListPTAPI bloc');
      return null;
    }
  }

  Future<GetListProdi?> getListProdiAPI(String idPt, String keyword) async {
    try {
      final result = await getListProdiAPIUseCase.execute(idPt, keyword);
      return result.fold((failure) {
        return null;
      }, (getListProdi) {
        return getListProdi;
      });
    } on Exception {
      print('exception prodi bloc');
      return null;
    }
  }

  Future<GetSpecificElasticPT?> getListElasticPTAPI(String keyword) async {
    final result = await getListElasticPTAPIUseCase.execute(keyword);
    return result.fold((failure) {
      return null;
    }, (getSpecificElasticPT) {
      return getSpecificElasticPT;
    });
  }

  Future<Tableau?> getStatistic() async {
    final result = await getStatisticUseCase.execute();
    return result.fold((failure) async {
      return null;
    }, (tableau) async {
      return tableauList = tableau;
    });
  }

  Future<void> getListProvinsi() async {
    final result = await getListElasticProvinsiUseCase.execute();
    return result.fold((failure) async {
      print('fail on bloc prov');
      hasilProvinsi = {};
    }, (getListProvinsi) async {
      print('success on bloc prov');
      hasilProvinsi = getListProvinsi;
    });
  }
}
