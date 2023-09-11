import 'package:equatable/equatable.dart';

abstract class PengajuanUsulanState extends Equatable {
  const PengajuanUsulanState();

  @override
  List<Object> get props => [];
}

class InitPengajuanUsulanState extends PengajuanUsulanState {}

class NotFoundPengajuanUsulanState extends PengajuanUsulanState {}

class NoInternetPengajuanUsulanState extends PengajuanUsulanState {}

class LoadedPengajuanUsulanState extends PengajuanUsulanState {}