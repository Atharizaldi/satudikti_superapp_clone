import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/sinta/journals/JournalsDetail.dart';
import 'package:app/domain/usecases/sinta/journals/getJournalsDetail.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'journals_detail_event.dart';
part 'journals_detail_state.dart';

//id 738
class JournalsDetailBloc
    extends Bloc<JournalsDetailEvent, JournalsDetailState> {
  InternetCheck internetCheck;
  GetJournalsDetail getJournalsDetail;

  JournalsDetailBloc(
      {required this.internetCheck, required this.getJournalsDetail})
      : super(JournalsDetailLoading()) {
    on<GetJournalsDetailEvent>(_getJournalsDetail);
  }

  void _getJournalsDetail(
      GetJournalsDetailEvent event, Emitter<JournalsDetailState> emit) async {
    bool hasInternet = await internetCheck.hasConnection();
    if (hasInternet) {
      final result = await getJournalsDetail.execute(event.id);
      await result.fold(
        (failure) async {
          Logger().i("_getJournalsDetail: failure");
          emit(JournalsDetailLoading());
        },
        (journalsDetail) async {
          Logger().i("_getJournalsDetail: ${journalsDetail.data?.journal?.id}");
          emit(JournalsDetailLoaded(
              journal: journalsDetail.data?.journal ?? Journal()));
        },
      );
    } else {
      emit(JournalsDetailLoading());
    }
  }
}
