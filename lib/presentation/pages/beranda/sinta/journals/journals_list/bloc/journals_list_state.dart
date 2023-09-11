part of 'journals_list_bloc.dart';

abstract class JournalsListState extends Equatable {
  const JournalsListState();
}

class JournalsListInitial extends JournalsListState {
  @override
  List<Object> get props => [];
}

class JournalsListLoading extends JournalsListInitial {
  @override
  List<Object> get props => [];
}

class JournalsListNoInternet extends JournalsListInitial {
  @override
  List<Object> get props => [];
}

class JournalsListError extends JournalsListInitial {
  @override
  List<Object> get props => [];
}

class JournalsListLoaded extends JournalsListInitial {
  final int totalItem;
  final bool hasReachedMax;
  final int page;
  final List<Journals> journalsList;

  JournalsListLoaded({
    required this.totalItem,
    required this.hasReachedMax,
    required this.page,
    required this.journalsList,
  });

  @override
  List<Object> get props => [totalItem, hasReachedMax, page, journalsList];
}
