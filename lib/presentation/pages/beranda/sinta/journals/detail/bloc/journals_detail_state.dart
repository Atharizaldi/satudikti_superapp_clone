part of 'journals_detail_bloc.dart';

abstract class JournalsDetailState extends Equatable {
  const JournalsDetailState();
}

class JournalsDetailLoading extends JournalsDetailState {
  @override
  List<Object> get props => [];
}

class JournalsDetailLoaded extends JournalsDetailState {
  final Journal journal;

  JournalsDetailLoaded({
    required this.journal,
  });

  @override
  List<Object> get props => [journal];
}