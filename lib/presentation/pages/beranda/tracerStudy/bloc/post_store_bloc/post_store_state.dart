import 'package:app/data/source/remote/model/tracer/postStoreAnswer.dart';
import 'package:equatable/equatable.dart';

abstract class PostStoreAnswerTracerState extends Equatable {
  const PostStoreAnswerTracerState();
}

class PostStoreAnswerLoadingState extends PostStoreAnswerTracerState {
  @override
  List<Object> get props => [];
}

class PostStoreAnswerErrorState extends PostStoreAnswerTracerState {
  @override
  List<Object> get props => [];
}

class PostStoreAnswerSuccessState extends PostStoreAnswerTracerState {
  final PostStoreAnswerData data;

  PostStoreAnswerSuccessState({required this.data});

  @override
  List<Object> get props => [data];
}

class PostStoreAnswerFailedState extends PostStoreAnswerTracerState {
  final PostStoreAnswerData data;

  PostStoreAnswerFailedState({required this.data});

  @override
  List<Object> get props => [data];
}

class PostStoreAnswerNoInternetState extends PostStoreAnswerTracerState {
  @override
  List<Object> get props => [];
}
