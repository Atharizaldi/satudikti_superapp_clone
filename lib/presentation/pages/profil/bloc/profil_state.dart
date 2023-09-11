part of 'profil_bloc.dart';

abstract class ProfilState extends Equatable {
  const ProfilState();
}

class ProilLoadingState extends ProfilState {
  @override
  List<Object> get props => [];
}

class ProfilLoadedState extends ProfilState {
  final UserInformation userInformation;
  final UserInformationDetail userInformationDetail;
  final String userAvatar;

  ProfilLoadedState({
    required this.userInformation,
    required this.userInformationDetail,
    required this.userAvatar,
  });

  @override
  List<Object> get props => [userInformation, userInformationDetail, userAvatar];
}

class ProfilNotLogInState extends ProfilState {
  @override
  List<Object?> get props => [];
}

class ProfilErrorState extends ProfilState {
  @override
  List<Object?> get props => [];
}
