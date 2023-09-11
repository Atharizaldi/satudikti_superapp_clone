part of 'usulan_dosen_bloc.dart';

abstract class UsulanDosenEvent extends Equatable {
  const UsulanDosenEvent();

  @override
  List<Object> get props => [];
}

class GetUsulanDosenEvent extends UsulanDosenEvent {
  final String namaDosen;
  final String tanggalLahir;
  final String idPT;
  final String nidn;
  final String isLogin;
  GetUsulanDosenEvent(
      {required this.namaDosen,
      required this.tanggalLahir,
      required this.idPT,
      required this.isLogin,
      required this.nidn});
}
