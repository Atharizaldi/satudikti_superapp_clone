part of 'detail_prodi_ptln_bloc.dart';

abstract class DetailProdiPtlnState extends Equatable {
  const DetailProdiPtlnState();
}

class DetailProdiPtlnLoadingState extends DetailProdiPtlnState {

  @override
  List<Object> get props => [];
}

class DetailProdiPtlnLoadedState extends DetailProdiPtlnState {
  final ProdiPTLN prodiPTLN;

  DetailProdiPtlnLoadedState({required this.prodiPTLN});

  @override
  List<Object> get props => [prodiPTLN];
}
