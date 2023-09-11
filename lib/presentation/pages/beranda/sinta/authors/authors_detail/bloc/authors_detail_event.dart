part of 'authors_detail_bloc.dart';

abstract class AuthorsDetailEvent extends Equatable {
  const AuthorsDetailEvent();
}

class GetAuthorsDetailEvent extends AuthorsDetailEvent {
  final String nidn;

  GetAuthorsDetailEvent({required this.nidn});

  @override
  List<Object> get props => [nidn];
}
