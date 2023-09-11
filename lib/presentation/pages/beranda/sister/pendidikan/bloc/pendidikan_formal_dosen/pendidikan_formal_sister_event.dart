part of 'pendidikan_formal_sister_bloc.dart';

abstract class PendidikanSisterEvent extends Equatable {
  const PendidikanSisterEvent();

  @override
  List<Object> get props => [];
}

class GetPendidikanSisterEvent extends PendidikanSisterEvent {
  final String nidn;
  final String displayByDiklat;
  final String judulDIklat;
  final String? matkulPengajaran;
  final String? displayByPengajaran;
  final String judulPembimbingan;
  final String displayByPembimbingan;
  final String judulPengujian;
  final String displayByPengujian;

  GetPendidikanSisterEvent({
    required this.nidn,
    this.displayByDiklat = '',
    this.judulDIklat = '',
    this.displayByPembimbingan = '',
    this.judulPembimbingan = '',
    this.displayByPengujian = '',
    this.judulPengujian = '',
    this.displayByPengajaran = '',
    this.matkulPengajaran = '',
  });
}
