part of 'profil_bloc.dart';

abstract class ProfilEvent extends Equatable {
  const ProfilEvent();
}

class CheckIsLoggedInEvent extends ProfilEvent {
  @override
  List<Object> get props => [];
}

class LogInEvent extends ProfilEvent {
  final Credentials credentials;
  LogInEvent({required this.credentials});
  @override
  List<Object> get props => [credentials];
}

class LogOutEvent extends ProfilEvent {
  @override
  List<Object> get props => [];
}

class GetProfilDetailEvent extends ProfilEvent {
  final Credentials credentials;
  GetProfilDetailEvent({required this.credentials});
  @override
  List<Object> get props => [];
}

class GetProfilInfoDetailEvent extends ProfilEvent {
  final String? username;
  final UserInformation? userInformation;
  GetProfilInfoDetailEvent({
    required this.username,
    required this.userInformation,
  });
  @override
  List<Object> get props => [];
}

class GetAvatarEvent extends ProfilEvent {
  final String? userId;
  final UserInformation? userInformation;
  final UserInformationDetail? userInformationDetail;

  GetAvatarEvent({
    this.userId,
    this.userInformation,
    this.userInformationDetail,
  }); 
  @override
  List<Object> get props => [];
}
