part of 'detail_pencarian_prodi_bloc.dart';

abstract class DetailPencarianProdiState extends Equatable {
  const DetailPencarianProdiState();

  @override
  List<Object> get props => [];
}

class InitDetailProdiState extends DetailPencarianProdiState {}

class NoInternetProdiState extends DetailPencarianProdiState {}

class NotFoundProdiState extends DetailPencarianProdiState {}

class LoadedDetailProdiState extends DetailPencarianProdiState {}
