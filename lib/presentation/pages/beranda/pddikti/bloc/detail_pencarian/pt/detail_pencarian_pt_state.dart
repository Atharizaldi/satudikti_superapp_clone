part of 'detail_pencarian_pt_bloc.dart';

abstract class DetailPencarianPtState extends Equatable {
  const DetailPencarianPtState();

  @override
  List<Object> get props => [];
}

class InitDetailPTState extends DetailPencarianPtState {}

class ErrorPTState extends DetailPencarianPtState {}

class LoadingPTState extends DetailPencarianPtState {}

class NoInternetPTState extends DetailPencarianPtState {}

class NotFoundPTState extends DetailPencarianPtState {}

class LoadedDetailPTState extends DetailPencarianPtState {}

class IDPTLoaded extends DetailPencarianPtState {
  final List<PerguruanTinggiData> idptpddikti;

  const IDPTLoaded({required this.idptpddikti});
  @override
  List<Object> get props => [idptpddikti];
}
