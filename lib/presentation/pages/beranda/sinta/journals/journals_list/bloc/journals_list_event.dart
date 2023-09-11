part of 'journals_list_bloc.dart';

abstract class JournalsListEvent extends Equatable {
  const JournalsListEvent();
}

class GetJournalsListEvent extends JournalsListEvent {
  final String keyword;

  GetJournalsListEvent({required this.keyword});

  @override
  List<Object> get props => [keyword];
}
