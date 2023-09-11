import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/kedaireka/kedairekaList.dart';
import 'package:app/domain/usecases/kedaireka/getPT.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'kedairekapt_event.dart';
part 'kedairekapt_state.dart';

class KedairekaptBloc extends Bloc<KedairekaptEvent, KedairekaptState> {
  GetListInsanPT getListInsanPT;
  InternetCheck internetCheck;

  KedairekaptBloc({required this.getListInsanPT, required this.internetCheck})
      : super(KedairekaptLoading()) {
    on<KedairekaptEvent>(_getKedairekaPT);
  }
  void _getKedairekaPT(
      KedairekaptEvent event, Emitter<KedairekaptState> emit) async {
    bool hasInternet = await internetCheck.hasConnection();
    try {
      if (hasInternet) {
        final result = await getListInsanPT.execute(defaultLimit.toString());
        await result.fold(
          (failure) async {
            emit(KedairekaptNoInternet());
          },
          (modelKedairekaIndustriPT) async {
            emit(KedairekaptLoaded(
                modelKedairekaIndustriPT: modelKedairekaIndustriPT));
          },
        );
      } else {
        emit(KedairekaptNoInternet());
      }
    } catch (e) {
      emit(KedairekaptNoInternet());
    }
  }
}
