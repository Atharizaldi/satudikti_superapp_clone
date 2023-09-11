import 'package:app/data/source/remote/model/tracer/getAllAnswer.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../../../data/source/remote/model/tracer/TracerKuesioner.dart';
import '../../../../../../../../data/source/remote/model/tracer/validasiData.dart';

abstract class KuesionerTracerState extends Equatable {
  const KuesionerTracerState();
}

class KuesionerSingleChoice extends KuesionerTracerState {
  late List<String>? labelSingleChoice = [];

  KuesionerSingleChoice({
    required this.labelSingleChoice,
  });
  @override
  List<Object> get props => [];
}

class KuesionerTracerLoadingState extends KuesionerTracerState {
  @override
  List<Object> get props => [];
}

class KuesionerTracerErrorState extends KuesionerTracerState {
  @override
  List<Object> get props => [];
}

class KuesionerTracerNoInternetState extends KuesionerTracerState {
  @override
  List<Object> get props => [];
}

class KuesionerTracerLoadedState extends KuesionerTracerState {
  final List<Question> listQuestions;
  final int page;

  KuesionerTracerLoadedState({required this.listQuestions, required this.page});

  @override
  List<Object> get props => [listQuestions];
}

class ValidasiDataLoadingState extends KuesionerTracerState {
  @override
  List<Object> get props => [];
}

class ValidasiDatarErrorState extends KuesionerTracerState {
  @override
  List<Object> get props => [];
}

class ValidasiDataNoInternetState extends KuesionerTracerState {
  @override
  List<Object> get props => [];
}

class ValidasiDataFailedState extends KuesionerTracerState {
  final ValidasiData data;

  ValidasiDataFailedState({required this.data});

  @override
  List<Object> get props => [data];
}

class ValidasiDataSuccessState extends KuesionerTracerState {
  final ValidasiData data;

  ValidasiDataSuccessState({required this.data});

  @override
  List<Object> get props => [data];
}

class GetAllAnswersLoadedState extends KuesionerTracerState {
  final GetAllAnswer data;

  GetAllAnswersLoadedState({required this.data});

  @override
  List<Object> get props => [data];
}
