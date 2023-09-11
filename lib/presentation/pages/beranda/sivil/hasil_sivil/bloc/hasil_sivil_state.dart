part of 'hasil_sivil_bloc.dart';

abstract class HasilSivilState extends Equatable {
  const HasilSivilState();

  @override
  List<Object> get props => [];
}

class InitHasilSivilState extends HasilSivilState {}

class NotFoundHasilSivilState extends HasilSivilState {}

class NoInternetHasilSivilState extends HasilSivilState {}

class LoadedHasilSivilState extends HasilSivilState {}
