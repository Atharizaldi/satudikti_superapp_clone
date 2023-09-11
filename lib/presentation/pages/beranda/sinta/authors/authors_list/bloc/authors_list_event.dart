part of 'authors_list_bloc.dart';

abstract class AuthorsListEvent extends Equatable {
  const AuthorsListEvent();

  @override
  List<Object?> get props => [];
}

class GetAuthorsListEvent extends AuthorsListEvent {
  final String keyword;
  final bool top;

  GetAuthorsListEvent({required this.keyword, required this.top});

  @override
  List<Object> get props => [keyword];
}