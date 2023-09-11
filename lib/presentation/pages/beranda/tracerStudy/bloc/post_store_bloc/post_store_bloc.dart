import 'package:app/common/internetCheck.dart';
import 'package:app/domain/usecases/tracer/postStoreAnswer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import 'post_store_event.dart';
import 'post_store_state.dart';

class PostStoreAnswerTracerBloc
    extends Bloc<PostStoreAnswerTracerEvent, PostStoreAnswerTracerState> {
  PostStoreAnswer postStoreAnswer;

  PostStoreAnswerTracerBloc({
    required this.postStoreAnswer,
  }) : super(PostStoreAnswerLoadingState()) {
    on<PostStoreAnswerEvent>(_postStoreAnswer);
  }

  void _postStoreAnswer(PostStoreAnswerEvent event,
      Emitter<PostStoreAnswerTracerState> emit) async {
    emit(PostStoreAnswerLoadingState());
    final hasInternet = await InternetCheck().hasConnection();
    if (hasInternet) {
      final postData = await postStoreAnswer.execute(event.listAnswer);
      // for (var i = 0; i < event.listAnswer.length; i++) {
      //   Logger().i(
      //       "INI RESULT DARI BLOC index ke $i ${event.listAnswer[i].questionId} + ${event.listAnswer[i].extraAnswer}");
      // }

      postData.fold((failure) {
        emit(PostStoreAnswerErrorState());
        Logger().e("Post data answer error");
      }, (result) {
        if (result.status) {
          emit(PostStoreAnswerSuccessState(data: result));
          Logger().d("Validasi data sukses");
        } else {
          emit(PostStoreAnswerFailedState(data: result));
          Logger().e("Validasi data gagal");
        }
      });
    } else {
      Logger().e("Koneksi Server Failed");
      emit(PostStoreAnswerNoInternetState());
    }
  }
}
