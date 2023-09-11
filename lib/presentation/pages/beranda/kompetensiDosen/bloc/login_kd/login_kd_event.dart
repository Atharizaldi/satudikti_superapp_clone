part of 'login_kd_bloc.dart';

abstract class LoginKdEvent extends Equatable {
  const LoginKdEvent();

  @override
  List<Object> get props => [];
}

class SignInKdEvent extends LoginKdEvent {}
