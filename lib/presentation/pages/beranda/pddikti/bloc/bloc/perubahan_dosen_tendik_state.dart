part of 'perubahan_dosen_tendik_bloc.dart';

abstract class PerubahanDosenTendikState extends Equatable {
  const PerubahanDosenTendikState();

  @override
  List<Object> get props => [];
}

class PerubahanDosenTendikInitial extends PerubahanDosenTendikState {}

class PerubahanNoInternetState extends PerubahanDosenTendikState {}

class PerubahanErrorState extends PerubahanDosenTendikState {}

// ignore: must_be_immutable
class PerubahanDosenTendikLoaded extends PerubahanDosenTendikState {
  List<ListPerubahanDosenTendikResponse> listSemua;
  List<ListPerubahanDosenTendikResponse> listDraft;
  List<ListPerubahanDosenTendikResponse> listDisetujui;
  List<ListPerubahanDosenTendikResponse> listDiusulkan;
  List<ListPerubahanDosenTendikResponse> listDitolak;
  List<ListPerubahanDosenTendikResponse> listDitangguhkan;
  final bool hasReached;
  final int page;

  PerubahanDosenTendikLoaded(
      {required this.listSemua,
      required this.listDraft,
      required this.listDisetujui,
      required this.listDiusulkan,
      required this.listDitolak,
      required this.listDitangguhkan,
      required this.hasReached,
      required this.page});

  @override
  List<Object> get props => [
        listSemua,
        listDraft,
        listDisetujui,
        listDiusulkan,
        listDitolak,
        listDitangguhkan,
        hasReached,
        page
      ];
}

class PerubahanDosenTendikLoading extends PerubahanDosenTendikState {}
