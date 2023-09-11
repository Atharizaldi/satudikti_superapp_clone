import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/sister/biodata_sister.dart';
import 'package:app/domain/usecases/sister/get_biodata_sister.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'biodata_sister_event.dart';
part 'biodata_sister_state.dart';

class BiodataSisterBloc extends Bloc<BiodataSisterEvent, BiodataSisterState> {
  GetBiodataSister getBiodataSister;
  Logger log;
  InternetCheck internetCheck;
  String nidn = '';
  BiodataSisterBloc(
      {required this.getBiodataSister,
      required this.internetCheck,
      required this.log})
      : super(BiodataSisterInitial()) {
    on<GetBiodataSisterEvent>(_getBiodata);
  }

  void _getBiodata(
      GetBiodataSisterEvent event, Emitter<BiodataSisterState> emit) async {
    bool hasInternet = await InternetCheck().hasConnection();
    if (hasInternet) {
      final result = await getBiodataSister.execute(event.nidn);
      nidn = event.nidn;

      await result.fold((failure) async {
        log.d('LoggedInBloc - error di profile: $state');
        log.d('LoggedInBloc - failure msg: ${failure.message}');
        if (failure.message == 'error500') {
          emit(BiodataSisterErrorState(nidn: event.nidn));
        } else if (failure.message == 'error404') {
          emit(BiodataSisterNotFoundState(null));
        } else if (failure.message == '') {
          emit(BiodataSisterErrorState(nidn: event.nidn));
        }
      }, (biodataSister) async {
        log.d('LoggedInBloc - masuk ke profil: $state');
        emit(BiodataSisterLoadedState(
          biodataSister: biodataSister,
          nidn: event.nidn,
        ));
      });
    } else {
      emit(BiodataSisterNoInternetState(nidn: event.nidn));
    }
  }
}
