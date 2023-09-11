part of 'list_beasiswa_bloc.dart';

abstract class ListBeasiswaState extends Equatable {
  const ListBeasiswaState();

  @override
  List<Object> get props => [];
}

class ListBeasiswaInitialState extends ListBeasiswaState {}

class ListBeasiswaLoadingState extends ListBeasiswaState {}

class ListBeasiswaLoadedState extends ListBeasiswaState {
  final List<ListBeasiswa> beasiswaDibuka;
  final List<ListBeasiswa> beasiswaDitutup;
  final List<ListBeasiswa> beasiswaAkanDibuka;
  final Data beasiswaDibukaRowCount;
  final Data beasiswaDitutupRowCount;
  final Data beasiswaAkanDibukaRowCount;

  ListBeasiswaLoadedState(
      {required this.beasiswaDibuka,
      required this.beasiswaDitutup,
      required this.beasiswaAkanDibuka,
      required this.beasiswaDibukaRowCount,
      required this.beasiswaDitutupRowCount,
      required this.beasiswaAkanDibukaRowCount});

  @override
  List<Object> get props => [
        beasiswaDibuka,
        beasiswaDitutup,
        beasiswaAkanDibuka,
        beasiswaDibukaRowCount,
        beasiswaDitutupRowCount,
        beasiswaAkanDibukaRowCount,
      ];
}

class ListBeasiswaNoInternetState extends ListBeasiswaState {}

class ListBeasiswaErrorState extends ListBeasiswaState {}
