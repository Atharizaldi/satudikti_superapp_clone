part of 'authors_list_bloc.dart';

abstract class AuthorsListState extends Equatable {
  const AuthorsListState();
}

class AuthorsListInitial extends AuthorsListState {
  @override
  List<Object> get props => [];
}

class AuthorsListLoading extends AuthorsListState {
  @override
  List<Object> get props => [];
}

class AuthorsListNoInternet extends AuthorsListState {
  @override
  List<Object> get props => [];
}

class AuthorsListError extends AuthorsListState {
  @override
  List<Object> get props => [];
}

class AuthorsListLoaded extends AuthorsListState {
  final int totalItem;
  final bool hasReachedMax;
  final int page;
  final List<Authors> authorsList;

  AuthorsListLoaded({
    required this.totalItem,
    required this.hasReachedMax,
    required this.page,
    required this.authorsList,
  });

  @override
  List<Object> get props => [totalItem, hasReachedMax, page, authorsList];
}
