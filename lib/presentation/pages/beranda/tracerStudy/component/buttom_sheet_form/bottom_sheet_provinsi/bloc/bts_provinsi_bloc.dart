import 'package:app/common/internetCheck.dart';
import 'package:app/domain/usecases/tracer/getListProvinsi.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bts_provinsi_event.dart';
part 'bts_provinsi_state.dart';

class BtsTracerProvinsiBloc extends Bloc<BtsProvinsiEvent, BtsProvinsiState> {
  GetListProvinsi getListProvinsiUseCase;

  BtsTracerProvinsiBloc({
    required this.getListProvinsiUseCase,
  }) : super(BtsProvinsiNotFoundState()) {
    on<BtsSearchProvinsiEvent>(_searchProvinsi);
  }

  void _searchProvinsi(
      BtsSearchProvinsiEvent event, Emitter<BtsProvinsiState> emit) async {
    emit(BtsProvinsiLoadingState());
    final isConnected = await InternetCheck().hasConnection();
    if (isConnected) {
      print("ISCONN _searchProvinsi ${event.listAllProvinsi}");

      List<String> matches = [];
      event.listAllProvinsi.forEach((key, value) {
        if (key.toLowerCase().contains(event.query.toLowerCase())) {
          matches.add(key);
        } 
        
        if (matches.isEmpty) {
          emit(BtsProvinsiNotFoundState());
        } else {
          emit(BtsProvinsiLoadedState(matchesProvinsi: matches));
        }
      });
    } else {
      emit(BtsProvinsiNoInternetState());
    }
  }
  
}
