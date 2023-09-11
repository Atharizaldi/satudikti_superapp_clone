import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/tracer/getAllAnswer.dart';
import 'package:app/domain/usecases/tracer/getAllAnswerTracer.dart';
import 'package:app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../../../../../../../domain/usecases/tracer/getQuestions.dart';
import '../../../../../../../../domain/usecases/tracer/validateData.dart';
import '../../../../../../data/source/remote/model/tracer/TracerKuesioner.dart';
import 'kuesioner_event.dart';
import 'kuesioner_state.dart';

class KuesionerTracerBloc
    extends Bloc<KuesionerTracerEvent, KuesionerTracerState> {
  GetQuestions getQuestions;
  PostValidateData postValidateData;
  GetAllAnswersTracer getAllAnswersTracer;
  // late List<Answer>? answer;
  // late List<Questions>? questions;
  // late List<String> questionList;
  List<String>? answerSingleChoice = [];
  List<String>? labelSingleChoice = [];
  List<AnswerLists> questionSingleChoice = [];

  KuesionerTracerBloc({
    required this.getQuestions,
    required this.postValidateData,
    required this.getAllAnswersTracer,
  }) : super(KuesionerTracerLoadingState()) {
    on<GetKuesionerTracerEvent>(_getQuestions);
    on<PostValidateDataEvent>(_postData);
    on<GetAnswer>(_getAnswer);
  }

  void _getAnswer(GetAnswer event, Emitter<KuesionerTracerState> emit) async {
    emit(KuesionerTracerLoadingState());
    final hasInternet = await InternetCheck().hasConnection();
    if (hasInternet) {
      final result = await getAllAnswersTracer.execute(event.id);

      await result.fold((failure) async {
        log.d('Get All Kuesioner - error di : $state');
        log.d('Get All Kuesioner - failure msg: ${failure.message}');
        if (failure.message == 'error500') {
          emit(KuesionerTracerErrorState());
        } else if (failure.message == '') {
          emit(KuesionerTracerErrorState());
        }
      }, (data) async {
        log.d('LoggedInBloc - masuk ke profil: $state');
        emit(GetAllAnswersLoadedState(data: data));
      });
    } else {
      emit(KuesionerTracerNoInternetState());
    }
  }

  void _getQuestions(
      GetKuesionerTracerEvent event, Emitter<KuesionerTracerState> emit) async {
    emit(KuesionerTracerLoadingState());
    final hasInternet = await InternetCheck().hasConnection();
    if (hasInternet) {
      List<Question> listQuestions = [];
      final resultQuestions = await getQuestions.execute(event.page!);

      resultQuestions.fold((failure) {
        emit(KuesionerTracerErrorState());
      }, (response) {
        listQuestions = response;
      });

      if (listQuestions.isNotEmpty) {
        emit(KuesionerTracerLoadedState(
            listQuestions: listQuestions, page: event.page!));
      }
    } else {
      emit(KuesionerTracerNoInternetState());
    }
  }

  void _postData(
      PostValidateDataEvent event, Emitter<KuesionerTracerState> emit) async {
    emit(ValidasiDataLoadingState());
    final hasInternet = await InternetCheck().hasConnection();

    if (hasInternet) {
      final postData = await postValidateData.execute(
          event.kodePt, event.kodeProdi, event.nim, event.tglLahir, event.nik);

      postData.fold((failure) {
        emit(ValidasiDatarErrorState());
        Logger().e("Validasi data error");
      }, (result) {
        // answer = result.data!.answer;
        // questions = result.data!.questions;

        // for (var i = 0; i < answer!.length; i++) {
        //   if (answer![i].answerType == 1) {
        //     print("KAMSDA ${answer![i].answer!}");
        //     answerSingleChoice?.addAll([answer![i].answer!]);
        //   }
        // }
        // for (var i = 0; i < questions!.length; i++) {
        //   if (questions![i].answerType?.answerTypeId == 1) {
        //     print("object QUESTIN ${questions![i]}");
        //     questionSingleChoice.addAll(questions![i].answerLists!);
        //     labelSingleChoice?.addAll([questions![i].question!]);
        //   }
        // }
        // log.i(
        //     "INI PANJANG ANSWER ${answer!.length} INI PANJANG QUESTION ${questions!.length} HALO ${answerSingleChoice?.length} INI QUESTION SINGLE CHOICE ${questionSingleChoice.length} DAN INI ${labelSingleChoice![2]}");

        if (result.status! ||
            result.message == "Alumni sudah mengisi kuesioner") {
          // emit(KuesionerSingleChoice(
          //     answer: answer,
          //     labelSingleChoice: labelSingleChoice,
          //     questionSingleChoice: questionSingleChoice,
          //     questions: questions));
          Logger().d("Validasi data sukses");
          emit(ValidasiDataSuccessState(data: result));
        } else {
          Logger().e("Validasi data gagal");
          emit(ValidasiDataFailedState(data: result));
        }
      });
    } else {
      emit(ValidasiDataNoInternetState());
    }
  }
}
