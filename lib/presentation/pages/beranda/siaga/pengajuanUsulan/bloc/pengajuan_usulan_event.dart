import 'package:equatable/equatable.dart';

abstract class PengajuanUsulanEvent extends Equatable {
  const PengajuanUsulanEvent();

  @override
  List<Object> get props => [];
}

class LoadPengajuanUsulanEvent extends PengajuanUsulanEvent {
  final String kataKunci;

  LoadPengajuanUsulanEvent({
    required this.kataKunci,
  });
}
