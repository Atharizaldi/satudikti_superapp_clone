part of 'authors_detail_bloc.dart';

abstract class AuthorsDetailState extends Equatable {
  const AuthorsDetailState();
}

class AuthorsDetailLoading extends AuthorsDetailState {
  @override
  List<Object> get props => [];
}

class AuthorsDetailLoaded extends AuthorsDetailState {
  final Author author;
  final String overall;
  final String overall3y;
  final String afill;
  final String affil3y;
  final List<List<String>> tables;

  AuthorsDetailLoaded({
    required this.author,
    required this.overall,
    required this.overall3y,
    required this.afill,
    required this.affil3y,
    required this.tables,
  });

  @override
  List<Object> get props => [author, overall, overall3y, afill, affil3y, tables];
}
