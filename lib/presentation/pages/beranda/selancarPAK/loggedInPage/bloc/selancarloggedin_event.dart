part of 'selancarloggedin_bloc.dart';

abstract class SelancarloggedinEvent extends Equatable {
  const SelancarloggedinEvent();

  @override
  List<Object> get props => [];
}

class FetchSelancarLoggedInFAQApiEvent extends SelancarloggedinEvent {}

class SelancarGetProfileEvent extends SelancarloggedinEvent {
  final String nidn;

  SelancarGetProfileEvent({required this.nidn});
}

class SelancarGetUsulanListEvent extends SelancarloggedinEvent {
  final String nidn;

  SelancarGetUsulanListEvent({required this.nidn});
}

class SelancarGetUsulanDetailEvent extends SelancarloggedinEvent {
  final String nidn;

  SelancarGetUsulanDetailEvent({required this.nidn});
}
