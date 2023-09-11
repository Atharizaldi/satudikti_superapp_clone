import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/kedaireka/kedairekaList.dart';
import 'package:app/domain/usecases/kedaireka/getIndustri.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'kedairekaindustri_event.dart';
part 'kedairekaindustri_state.dart';

class KedairekaindustriBloc
    extends Bloc<KedairekaindustriEvent, KedairekaindustriState> {
  GetListIndustri getListIndustri;
  InternetCheck internetCheck;

  KedairekaindustriBloc(
      {required this.getListIndustri, required this.internetCheck})
      : super(KedairekaindustriLoading()) {
    on<FetchKedairekaindustriEvent>(_getKedairekaIndustri);
  }
  void _getKedairekaIndustri(FetchKedairekaindustriEvent event,
      Emitter<KedairekaindustriState> emit) async {
    bool hasInternet = await internetCheck.hasConnection();
    try {
      if (hasInternet) {
        final result = await getListIndustri.execute(defaultLimit.toString());
        await result.fold(
          (failure) async {
            emit(KedairekaindustriNoInternet());
          },
          (modelKedairekaIndustri) async {
            emit(KedairekaindustriLoaded(
                modelKedairekaIndustri: modelKedairekaIndustri));
          },
        );
      } else {
        emit(KedairekaindustriNoInternet());
      }
    } catch (e) {
      emit(KedairekaindustriNoInternet());
    }
  }
}
