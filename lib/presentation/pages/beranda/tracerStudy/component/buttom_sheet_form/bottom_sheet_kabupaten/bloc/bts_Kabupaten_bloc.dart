import 'package:app/common/internetCheck.dart';
import 'package:app/domain/usecases/tracer/getListElasticKabupaten.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bts_Kabupaten_event.dart';
part 'bts_Kabupaten_state.dart';

class BtsTracerKabupatenBloc extends Bloc<BtsKabupatenEvent, BtsKabupatenState> {
  GetListElasticKabupaten getListElasticKabupatenUseCase;

  BtsTracerKabupatenBloc({
    required this.getListElasticKabupatenUseCase,
  }) : super(BtsKabupatenNotFoundState()) {
    on<BtsSearchKabupatenEvent>(_searchKabupaten);
  }

  void _searchKabupaten(
      BtsSearchKabupatenEvent event, Emitter<BtsKabupatenState> emit) async {
    emit(BtsKabupatenLoadingState());
    final isConnected = await InternetCheck().hasConnection();
    if (isConnected) {
      print("ISCONN _searchKabupaten ${event.listAllKabupaten}");

      List<String> matches = [];
      event.listAllKabupaten.forEach((key, value) {

        if (key.toLowerCase().contains(event.query.toLowerCase())) {
          matches.add(key);
        }

        if (matches.isEmpty) {
          emit(BtsKabupatenNotFoundState());
        } else {
          emit(BtsKabupatenLoadedState(matchesKabupaten: matches));
        }
        
      });
    } else {
      emit(BtsKabupatenNoInternetState());
    }
  }
}
