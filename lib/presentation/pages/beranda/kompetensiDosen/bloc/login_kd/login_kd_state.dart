part of 'login_kd_bloc.dart';

abstract class LoginKdState extends Equatable {
  const LoginKdState();

  @override
  List<Object> get props => [];
}

class LoginKdInitial extends LoginKdState {}

class LoginKdNoInternet extends LoginKdState {}

class LoggedInKdState extends LoginKdState {}
