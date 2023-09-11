part of 'selancarloggedin_bloc.dart';

abstract class SelancarloggedinState extends Equatable {
  const SelancarloggedinState();

  @override
  List<Object> get props => [];
}

class SelancarloggedinInitial extends SelancarloggedinState {}

class SelancarLoggedInLoadedState extends SelancarloggedinState {
  final ProfilePAKDetail profileDetail;
  final List<Usulan> usulanList;
  final UsulanDetail usulanDetail;
  final String nidn;

  SelancarLoggedInLoadedState({
    required this.profileDetail,
    required this.usulanList,
    required this.usulanDetail,
    required this.nidn,
  });

  @override
  List<Object> get props => [
        profileDetail,
        usulanList,
        usulanDetail,
      ];
}

class SelancarLoggedInNoInternetState extends SelancarloggedinState {
  final String nidn;

  SelancarLoggedInNoInternetState({required this.nidn});

  @override
  List<Object> get props => [this.nidn];
}

class SelancarLoggedInErrorState extends SelancarloggedinState {
  final String nidn;

  SelancarLoggedInErrorState({required this.nidn});

  @override
  List<Object> get props => [];
}

class SelancarLoggedInNotFoundState extends SelancarloggedinState {
  final ProfilePAKDetail? profilePAKDetail;
  SelancarLoggedInNotFoundState(this.profilePAKDetail);

  @override
  List<Object> get props => [];
}
