part of 'sister_logged_in_bloc.dart';

abstract class SisterLoggedinState extends Equatable {
  const SisterLoggedinState();

  @override
  List<Object> get props => [];
}

class SisterLoggedinInitial extends SisterLoggedinState {}

class SisterLoggedInLoadedState extends SisterLoggedinState {
  final ProfileSisterDetail profileDetail;
  final String nidn;
  final List<String> dataDosen;

  SisterLoggedInLoadedState(
      {required this.profileDetail,
      required this.nidn,
      required this.dataDosen});

  @override
  List<Object> get props => [profileDetail];
}

class SisterLoggedInNoInternetState extends SisterLoggedinState {
  final String nidn;

  SisterLoggedInNoInternetState({required this.nidn});

  @override
  List<Object> get props => [this.nidn];
}

class SisterLoggedInErrorState extends SisterLoggedinState {
  final String nidn;

  SisterLoggedInErrorState({required this.nidn});

  @override
  List<Object> get props => [];
}

class SisterLoggedInNotFoundState extends SisterLoggedinState {
  final ProfileSisterDetail? profileSisterDetail;
  SisterLoggedInNotFoundState(this.profileSisterDetail);

  @override
  List<Object> get props => [];
}
// part of 'sister_logged_in_bloc.dart';

// abstract class SisterLoggedinState extends Equatable {
//   const SisterLoggedinState();

//   @override
//   List<Object> get props => [];
// }

// class SisterLoggedinInitial extends SisterLoggedinState {}

// class SisterLoggedInLoadedState extends SisterLoggedinState {
//   final ProfileSisterDetail profileDetail;

//   SisterLoggedInLoadedState({required this.profileDetail});

//   @override
//   List<Object> get props => [profileDetail];
// }
