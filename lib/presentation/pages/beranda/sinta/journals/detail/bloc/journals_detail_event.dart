part of 'journals_detail_bloc.dart';

abstract class JournalsDetailEvent extends Equatable {
  const JournalsDetailEvent();
}

class GetJournalsDetailEvent extends JournalsDetailEvent {
  final String id;

  GetJournalsDetailEvent({required this.id});

  @override
  List<Object> get props => [id];
}

