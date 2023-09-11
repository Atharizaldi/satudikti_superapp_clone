
import 'package:app/data/source/remote/model/tracer/AnswerKuesioner.dart';
import 'package:equatable/equatable.dart';

abstract class PostStoreAnswerTracerEvent extends Equatable {
  const PostStoreAnswerTracerEvent();
}

class PostStoreAnswerEvent extends PostStoreAnswerTracerEvent {
  final List<AnswerKuesioner> listAnswer;

  PostStoreAnswerEvent({required this.listAnswer});
  @override
  List<Object> get props => [];
}

