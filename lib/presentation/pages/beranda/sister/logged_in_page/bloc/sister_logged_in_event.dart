part of 'sister_logged_in_bloc.dart';

abstract class SisterLoggedinEvent extends Equatable {
  const SisterLoggedinEvent();

  @override
  List<Object> get props => [];
}

class FetchSisterLoggedInFAQApiEvent extends SisterLoggedinEvent {}

class SisterGetProfileEvent extends SisterLoggedinEvent {
  final String nidn;

  SisterGetProfileEvent({required this.nidn}) {
    print("KESINI ==================== ${nidn}");
  }
}

class SisterGetUsulanListEvent extends SisterLoggedinEvent {
  final String nidn;

  SisterGetUsulanListEvent({required this.nidn});
}

class SisterGetUsulanDetailEvent extends SisterLoggedinEvent {
  final String nidn;

  SisterGetUsulanDetailEvent({required this.nidn});
}
