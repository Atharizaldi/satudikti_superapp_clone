import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/kampusMerdeka/ckm_list.dart';
import 'package:app/domain/usecases/kampusmerdeka/getCKM.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cerita_kampus_merdeka_event.dart';
part 'cerita_kampus_merdeka_state.dart';

class CeritaKampusMerdekaBloc extends Bloc<CeritaKampusMerdekaEvent, CeritaKampusMerdekaState> {
  GetCKM getCKM;
  InternetCheck internetCheck;

  CeritaKampusMerdekaBloc({required this.getCKM, required this.internetCheck}) : super(CeritaKMLoadingState()){
  on<GetCeritaKMPopularEvent>(_getPopularCeritaKM);
  on<GetCeritaKMRecentlyEvent>(_getRecentCeritaKM);
  on<GetCeritaKMMSIBEvent>(_getMSIBCeritaKM);
  on<GetCeritaKMPertukaranMahasiswaEvent>(_getPertukaranMahasiswaCeritaKM);
  on<GetCeritaKMKampusMengajarEvent>(_getKampusMengajarCeritaKM);
  on<GetCeritaKMIISMAEvent>(_getIISMACeritaKM);
  on<GetCeritaKMWirausahaEvent>(_getWirausahaCeritaKM);
  on<GetCeritaKMPraktisiMengajarEvent>(_getPraktisiMengajarCeritaKM);
  on<GetCeritaKMFestivalKampusMerdekaEvent>(
  _getFestivalKampusMerdekaCeritaKM);
  }

  void _getRecentCeritaKM(
      GetCeritaKMRecentlyEvent event, Emitter<CeritaKampusMerdekaState> emit) async {
    bool hasInternet = await InternetCheck().hasConnection();
    if (hasInternet) {
      final result = await getCKM.execute('terkini');
      await result.fold(
            (failure) async {
          if (failure.message == 'error500') {
            emit(CeritaKMErrorState());
          }
        },
            (recentlyCeritaKM) async {
          if (state is CeritaKMLoadedState) {
            CeritaKMLoadedState ceritaKMLoadedState =
            state as CeritaKMLoadedState;
            emit(CeritaKMLoadedState(
                listCeritaKampusMerdeka:
                ceritaKMLoadedState.listCeritaKampusMerdeka,
                msibCeritaKM: ceritaKMLoadedState.msibCeritaKM,
                pertukaranMahasiswaCeritaKM:
                ceritaKMLoadedState.pertukaranMahasiswaCeritaKM,
                kampusMengajarCeritaKM:
                ceritaKMLoadedState.kampusMengajarCeritaKM,
                iismaCeritaKM: ceritaKMLoadedState.iismaCeritaKM,
                wirausahaCeritaKM: ceritaKMLoadedState.wirausahaCeritaKM,
                praktisiMengajarCeritaKM:
                ceritaKMLoadedState.praktisiMengajarCeritaKM,
                festivalKMCeritaKM: ceritaKMLoadedState.festivalKMCeritaKM,
                recentCeritaKM: recentlyCeritaKM.listCKM.toList(),
                popularCeritaKM: ceritaKMLoadedState.popularCeritaKM));
          } else {
            emit(
              CeritaKMLoadedState(
                listCeritaKampusMerdeka:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                msibCeritaKM: CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                pertukaranMahasiswaCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                kampusMengajarCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                iismaCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                wirausahaCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                praktisiMengajarCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                festivalKMCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                recentCeritaKM: recentlyCeritaKM.listCKM.toList(),
                popularCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
              ),
            );
          }
        },
      );
    } else {
      emit(CeritaKMNoInternetState(
        listCeritaKampusMerdeka: [],
        msibCeritaKM: [],
        pertukaranMahasiswaCeritaKM: [],
        kampusMengajarCeritaKM: [],
        iismaCeritaKM: [],
        wirausahaCeritaKM: [],
        praktisiMengajarCeritaKM: [],
        festivalKMCeritaKM: [],
        recentCeritaKM: [],
        popularCeritaKM: [],
      ));
    }
  }

  void _getPopularCeritaKM(
      GetCeritaKMPopularEvent event, Emitter<CeritaKampusMerdekaState> emit) async {
    bool hasInternet = await InternetCheck().hasConnection();
    if (hasInternet) {
      final result = await getCKM.execute('reaction');
      await result.fold(
            (failure) async {
          emit(CeritaKMErrorState());
        },
            (popularCeritaKM) async {
          if (state is CeritaKMLoadedState) {
            CeritaKMLoadedState ceritaKMLoadedState =
            state as CeritaKMLoadedState;
            emit(CeritaKMLoadedState(
                listCeritaKampusMerdeka:
                ceritaKMLoadedState.listCeritaKampusMerdeka,
                msibCeritaKM: ceritaKMLoadedState.msibCeritaKM,
                pertukaranMahasiswaCeritaKM:
                ceritaKMLoadedState.pertukaranMahasiswaCeritaKM,
                kampusMengajarCeritaKM:
                ceritaKMLoadedState.kampusMengajarCeritaKM,
                iismaCeritaKM: ceritaKMLoadedState.iismaCeritaKM,
                wirausahaCeritaKM: ceritaKMLoadedState.wirausahaCeritaKM,
                praktisiMengajarCeritaKM:
                ceritaKMLoadedState.praktisiMengajarCeritaKM,
                festivalKMCeritaKM: ceritaKMLoadedState.festivalKMCeritaKM,
                recentCeritaKM: ceritaKMLoadedState.recentCeritaKM,
                popularCeritaKM: popularCeritaKM.listCKM));
          } else {
            emit(
              CeritaKMLoadedState(
                listCeritaKampusMerdeka:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                msibCeritaKM: CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                pertukaranMahasiswaCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                kampusMengajarCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                iismaCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                wirausahaCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                praktisiMengajarCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                festivalKMCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                recentCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                popularCeritaKM: popularCeritaKM.listCKM.toList(),
              ),
            );
          }
        },
      );
    } else {
      emit(CeritaKMNoInternetState(
        listCeritaKampusMerdeka: [],
        msibCeritaKM: [],
        pertukaranMahasiswaCeritaKM: [],
        kampusMengajarCeritaKM: [],
        iismaCeritaKM: [],
        wirausahaCeritaKM: [],
        praktisiMengajarCeritaKM: [],
        festivalKMCeritaKM: [],
        recentCeritaKM: [],
        popularCeritaKM: [],
      ));
    }
  }

  void _getMSIBCeritaKM(
      GetCeritaKMMSIBEvent event, Emitter<CeritaKampusMerdekaState> emit) async {
    bool hasInternet = await InternetCheck().hasConnection();
    if (hasInternet) {
      final result = await getCKM.execute('7');
      await result.fold(
            (failure) async {
          emit(CeritaKMErrorState());
        },
            (msibCeritaKM) async {
          if (state is CeritaKMLoadedState) {
            CeritaKMLoadedState ceritaKMLoadedState =
            state as CeritaKMLoadedState;
            emit(CeritaKMLoadedState(
                listCeritaKampusMerdeka:
                ceritaKMLoadedState.listCeritaKampusMerdeka,
                msibCeritaKM: msibCeritaKM.listCKM.toList(),
                pertukaranMahasiswaCeritaKM:
                ceritaKMLoadedState.pertukaranMahasiswaCeritaKM,
                kampusMengajarCeritaKM:
                ceritaKMLoadedState.kampusMengajarCeritaKM,
                iismaCeritaKM: ceritaKMLoadedState.iismaCeritaKM,
                wirausahaCeritaKM: ceritaKMLoadedState.wirausahaCeritaKM,
                praktisiMengajarCeritaKM:
                ceritaKMLoadedState.praktisiMengajarCeritaKM,
                festivalKMCeritaKM: ceritaKMLoadedState.festivalKMCeritaKM,
                recentCeritaKM: ceritaKMLoadedState.recentCeritaKM,
                popularCeritaKM: ceritaKMLoadedState.popularCeritaKM));
          } else {
            emit(
              CeritaKMLoadedState(
                listCeritaKampusMerdeka:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                msibCeritaKM: msibCeritaKM.listCKM.toList(),
                pertukaranMahasiswaCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                kampusMengajarCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                iismaCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                wirausahaCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                praktisiMengajarCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                festivalKMCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                recentCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                popularCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
              ),
            );
          }
        },
      );
    } else {
      emit(CeritaKMNoInternetState(
        listCeritaKampusMerdeka: [],
        msibCeritaKM: [],
        pertukaranMahasiswaCeritaKM: [],
        kampusMengajarCeritaKM: [],
        iismaCeritaKM: [],
        wirausahaCeritaKM: [],
        praktisiMengajarCeritaKM: [],
        festivalKMCeritaKM: [],
        recentCeritaKM: [],
        popularCeritaKM: [],
      ));
    }
  }

  void _getPertukaranMahasiswaCeritaKM(
      GetCeritaKMPertukaranMahasiswaEvent event,
      Emitter<CeritaKampusMerdekaState> emit) async {
    bool hasInternet = await InternetCheck().hasConnection();
    if (hasInternet) {
      final result = await getCKM.execute('8');
      await result.fold(
            (failure) async {
          emit(CeritaKMErrorState());
        },
            (pertukaranMahasiswaCeritaKM) async {
          if (state is CeritaKMLoadedState) {
            CeritaKMLoadedState ceritaKMLoadedState =
            state as CeritaKMLoadedState;
            emit(CeritaKMLoadedState(
                listCeritaKampusMerdeka:
                ceritaKMLoadedState.listCeritaKampusMerdeka,
                msibCeritaKM: ceritaKMLoadedState.msibCeritaKM,
                pertukaranMahasiswaCeritaKM:
                pertukaranMahasiswaCeritaKM.listCKM.toList(),
                kampusMengajarCeritaKM:
                ceritaKMLoadedState.kampusMengajarCeritaKM,
                iismaCeritaKM: ceritaKMLoadedState.iismaCeritaKM,
                wirausahaCeritaKM: ceritaKMLoadedState.wirausahaCeritaKM,
                praktisiMengajarCeritaKM:
                ceritaKMLoadedState.praktisiMengajarCeritaKM,
                festivalKMCeritaKM: ceritaKMLoadedState.festivalKMCeritaKM,
                recentCeritaKM: ceritaKMLoadedState.recentCeritaKM,
                popularCeritaKM: ceritaKMLoadedState.popularCeritaKM));
          } else {
            emit(
              CeritaKMLoadedState(
                listCeritaKampusMerdeka:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                msibCeritaKM: CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                pertukaranMahasiswaCeritaKM:
                pertukaranMahasiswaCeritaKM.listCKM.toList(),
                kampusMengajarCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                iismaCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                wirausahaCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                praktisiMengajarCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                festivalKMCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                recentCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                popularCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
              ),
            );
          }
        },
      );
    } else {
      emit(CeritaKMNoInternetState(
        listCeritaKampusMerdeka: [],
        msibCeritaKM: [],
        pertukaranMahasiswaCeritaKM: [],
        kampusMengajarCeritaKM: [],
        iismaCeritaKM: [],
        wirausahaCeritaKM: [],
        praktisiMengajarCeritaKM: [],
        festivalKMCeritaKM: [],
        recentCeritaKM: [],
        popularCeritaKM: [],
      ));
    }
  }

  void _getKampusMengajarCeritaKM(GetCeritaKMKampusMengajarEvent event,
      Emitter<CeritaKampusMerdekaState> emit) async {
    bool hasInternet = await InternetCheck().hasConnection();
    if (hasInternet) {
      final result = await getCKM.execute('9');
      await result.fold(
            (failure) async {
          emit(CeritaKMErrorState());
        },
            (kampusMengajarCeritaKM) async {
          if (state is CeritaKMLoadedState) {
            CeritaKMLoadedState ceritaKMLoadedState =
            state as CeritaKMLoadedState;
            emit(CeritaKMLoadedState(
                listCeritaKampusMerdeka:
                ceritaKMLoadedState.listCeritaKampusMerdeka,
                msibCeritaKM: ceritaKMLoadedState.msibCeritaKM,
                pertukaranMahasiswaCeritaKM:
                ceritaKMLoadedState.pertukaranMahasiswaCeritaKM,
                kampusMengajarCeritaKM: kampusMengajarCeritaKM.listCKM.toList(),
                iismaCeritaKM: ceritaKMLoadedState.iismaCeritaKM,
                wirausahaCeritaKM: ceritaKMLoadedState.wirausahaCeritaKM,
                praktisiMengajarCeritaKM:
                ceritaKMLoadedState.praktisiMengajarCeritaKM,
                festivalKMCeritaKM: ceritaKMLoadedState.festivalKMCeritaKM,
                recentCeritaKM: ceritaKMLoadedState.recentCeritaKM,
                popularCeritaKM: ceritaKMLoadedState.popularCeritaKM));
          } else {
            emit(
              CeritaKMLoadedState(
                listCeritaKampusMerdeka:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                msibCeritaKM: CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                pertukaranMahasiswaCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                kampusMengajarCeritaKM: kampusMengajarCeritaKM.listCKM.toList(),
                iismaCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                wirausahaCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                praktisiMengajarCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                festivalKMCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                recentCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                popularCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
              ),
            );
          }
        },
      );
    } else {
      emit(CeritaKMNoInternetState(
        listCeritaKampusMerdeka: [],
        msibCeritaKM: [],
        pertukaranMahasiswaCeritaKM: [],
        kampusMengajarCeritaKM: [],
        iismaCeritaKM: [],
        wirausahaCeritaKM: [],
        praktisiMengajarCeritaKM: [],
        festivalKMCeritaKM: [],
        recentCeritaKM: [],
        popularCeritaKM: [],
      ));
    }
  }

  void _getIISMACeritaKM(
      GetCeritaKMIISMAEvent event, Emitter<CeritaKampusMerdekaState> emit) async {
    bool hasInternet = await InternetCheck().hasConnection();
    if (hasInternet) {
      final result = await getCKM.execute('10');
      await result.fold(
            (failure) async {
          emit(CeritaKMErrorState());
        },
            (iismaCeritaKM) async {
          if (state is CeritaKMLoadedState) {
            CeritaKMLoadedState ceritaKMLoadedState =
            state as CeritaKMLoadedState;
            emit(CeritaKMLoadedState(
                listCeritaKampusMerdeka:
                ceritaKMLoadedState.listCeritaKampusMerdeka,
                msibCeritaKM: ceritaKMLoadedState.msibCeritaKM,
                pertukaranMahasiswaCeritaKM:
                ceritaKMLoadedState.pertukaranMahasiswaCeritaKM,
                kampusMengajarCeritaKM:
                ceritaKMLoadedState.kampusMengajarCeritaKM,
                iismaCeritaKM: iismaCeritaKM.listCKM.toList(),
                wirausahaCeritaKM: ceritaKMLoadedState.wirausahaCeritaKM,
                praktisiMengajarCeritaKM:
                ceritaKMLoadedState.praktisiMengajarCeritaKM,
                festivalKMCeritaKM: ceritaKMLoadedState.festivalKMCeritaKM,
                recentCeritaKM: ceritaKMLoadedState.recentCeritaKM,
                popularCeritaKM: ceritaKMLoadedState.popularCeritaKM));
          } else {
            emit(
              CeritaKMLoadedState(
                listCeritaKampusMerdeka:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                msibCeritaKM: CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                pertukaranMahasiswaCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                kampusMengajarCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                iismaCeritaKM: iismaCeritaKM.listCKM.toList(),
                wirausahaCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                praktisiMengajarCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                festivalKMCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                recentCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                popularCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
              ),
            );
          }
        },
      );
    } else {
      emit(CeritaKMNoInternetState(
        listCeritaKampusMerdeka: [],
        msibCeritaKM: [],
        pertukaranMahasiswaCeritaKM: [],
        kampusMengajarCeritaKM: [],
        iismaCeritaKM: [],
        wirausahaCeritaKM: [],
        praktisiMengajarCeritaKM: [],
        festivalKMCeritaKM: [],
        recentCeritaKM: [],
        popularCeritaKM: [],
      ));
    }
  }

  void _getWirausahaCeritaKM(
      GetCeritaKMWirausahaEvent event, Emitter<CeritaKampusMerdekaState> emit) async {
    bool hasInternet = await InternetCheck().hasConnection();
    if (hasInternet) {
      final result = await getCKM.execute('11');
      await result.fold(
            (failure) async {
          emit(CeritaKMErrorState());
        },
            (wirausahaCeritaKM) async {
          if (state is CeritaKMLoadedState) {
            CeritaKMLoadedState ceritaKMLoadedState =
            state as CeritaKMLoadedState;
            emit(CeritaKMLoadedState(
                listCeritaKampusMerdeka:
                ceritaKMLoadedState.listCeritaKampusMerdeka,
                msibCeritaKM: ceritaKMLoadedState.msibCeritaKM,
                pertukaranMahasiswaCeritaKM:
                ceritaKMLoadedState.pertukaranMahasiswaCeritaKM,
                kampusMengajarCeritaKM:
                ceritaKMLoadedState.kampusMengajarCeritaKM,
                iismaCeritaKM: ceritaKMLoadedState.iismaCeritaKM,
                wirausahaCeritaKM: wirausahaCeritaKM.listCKM.toList(),
                praktisiMengajarCeritaKM:
                ceritaKMLoadedState.praktisiMengajarCeritaKM,
                festivalKMCeritaKM: ceritaKMLoadedState.festivalKMCeritaKM,
                recentCeritaKM: ceritaKMLoadedState.recentCeritaKM,
                popularCeritaKM: ceritaKMLoadedState.popularCeritaKM));
          } else {
            emit(
              CeritaKMLoadedState(
                listCeritaKampusMerdeka:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                msibCeritaKM: CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                pertukaranMahasiswaCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                kampusMengajarCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                iismaCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                wirausahaCeritaKM: wirausahaCeritaKM.listCKM.toList(),
                praktisiMengajarCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                festivalKMCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                recentCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                popularCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
              ),
            );
          }
        },
      );
    } else {
      emit(CeritaKMNoInternetState(
        listCeritaKampusMerdeka: [],
        msibCeritaKM: [],
        pertukaranMahasiswaCeritaKM: [],
        kampusMengajarCeritaKM: [],
        iismaCeritaKM: [],
        wirausahaCeritaKM: [],
        praktisiMengajarCeritaKM: [],
        festivalKMCeritaKM: [],
        recentCeritaKM: [],
        popularCeritaKM: [],
      ));
    }
  }

  void _getPraktisiMengajarCeritaKM(GetCeritaKMPraktisiMengajarEvent event,
      Emitter<CeritaKampusMerdekaState> emit) async {
    bool hasInternet = await InternetCheck().hasConnection();
    if (hasInternet) {
      final result = await getCKM.execute('12');
      await result.fold(
            (failure) async {
          emit(CeritaKMErrorState());
        },
            (praktisiMengajarCeritaKM) async {
          if (state is CeritaKMLoadedState) {
            CeritaKMLoadedState ceritaKMLoadedState =
            state as CeritaKMLoadedState;
            emit(CeritaKMLoadedState(
                listCeritaKampusMerdeka:
                ceritaKMLoadedState.listCeritaKampusMerdeka,
                msibCeritaKM: ceritaKMLoadedState.msibCeritaKM,
                pertukaranMahasiswaCeritaKM:
                ceritaKMLoadedState.pertukaranMahasiswaCeritaKM,
                kampusMengajarCeritaKM:
                ceritaKMLoadedState.kampusMengajarCeritaKM,
                iismaCeritaKM: ceritaKMLoadedState.iismaCeritaKM,
                wirausahaCeritaKM: ceritaKMLoadedState.wirausahaCeritaKM,
                praktisiMengajarCeritaKM:
                praktisiMengajarCeritaKM.listCKM.toList(),
                festivalKMCeritaKM: ceritaKMLoadedState.festivalKMCeritaKM,
                recentCeritaKM: ceritaKMLoadedState.recentCeritaKM,
                popularCeritaKM: ceritaKMLoadedState.popularCeritaKM));
          } else {
            emit(
              CeritaKMLoadedState(
                listCeritaKampusMerdeka:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                msibCeritaKM: CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                pertukaranMahasiswaCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                kampusMengajarCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                iismaCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                wirausahaCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                praktisiMengajarCeritaKM:
                praktisiMengajarCeritaKM.listCKM.toList(),
                festivalKMCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                recentCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                popularCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
              ),
            );
          }
        },
      );
    } else {
      emit(CeritaKMNoInternetState(
        listCeritaKampusMerdeka: [],
        msibCeritaKM: [],
        pertukaranMahasiswaCeritaKM: [],
        kampusMengajarCeritaKM: [],
        iismaCeritaKM: [],
        wirausahaCeritaKM: [],
        praktisiMengajarCeritaKM: [],
        festivalKMCeritaKM: [],
        recentCeritaKM: [],
        popularCeritaKM: [],
      ));
    }
  }

  void _getFestivalKampusMerdekaCeritaKM(
      GetCeritaKMFestivalKampusMerdekaEvent event,
      Emitter<CeritaKampusMerdekaState> emit) async {
    bool hasInternet = await InternetCheck().hasConnection();
    if (hasInternet) {
      final result = await getCKM.execute('13');
      await result.fold(
            (failure) async {
          emit(CeritaKMErrorState());
        },
            (festivalKampusMerdekaCeritaKM) async {
          if (state is CeritaKMLoadedState) {
            CeritaKMLoadedState ceritaKMLoadedState =
            state as CeritaKMLoadedState;
            emit(CeritaKMLoadedState(
                listCeritaKampusMerdeka:
                ceritaKMLoadedState.listCeritaKampusMerdeka,
                msibCeritaKM: ceritaKMLoadedState.msibCeritaKM,
                pertukaranMahasiswaCeritaKM:
                ceritaKMLoadedState.pertukaranMahasiswaCeritaKM,
                kampusMengajarCeritaKM:
                ceritaKMLoadedState.kampusMengajarCeritaKM,
                iismaCeritaKM: ceritaKMLoadedState.iismaCeritaKM,
                wirausahaCeritaKM: ceritaKMLoadedState.wirausahaCeritaKM,
                praktisiMengajarCeritaKM:
                ceritaKMLoadedState.praktisiMengajarCeritaKM,
                festivalKMCeritaKM:
                festivalKampusMerdekaCeritaKM.listCKM.toList(),
                recentCeritaKM: ceritaKMLoadedState.recentCeritaKM,
                popularCeritaKM: ceritaKMLoadedState.popularCeritaKM));
          } else {
            emit(
              CeritaKMLoadedState(
                listCeritaKampusMerdeka:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                msibCeritaKM: CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                pertukaranMahasiswaCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                kampusMengajarCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                iismaCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                wirausahaCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                praktisiMengajarCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                festivalKMCeritaKM:
                festivalKampusMerdekaCeritaKM.listCKM.toList(),
                recentCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
                popularCeritaKM:
                CeritaKampusMerdeka(listCKM: []).listCKM.toList(),
              ),
            );
          }
        },
      );
    } else {
      emit(CeritaKMNoInternetState(
        listCeritaKampusMerdeka: [],
        msibCeritaKM: [],
        pertukaranMahasiswaCeritaKM: [],
        kampusMengajarCeritaKM: [],
        iismaCeritaKM: [],
        wirausahaCeritaKM: [],
        praktisiMengajarCeritaKM: [],
        festivalKMCeritaKM: [],
        recentCeritaKM: [],
        popularCeritaKM: [],
      ));
    }
  }
}