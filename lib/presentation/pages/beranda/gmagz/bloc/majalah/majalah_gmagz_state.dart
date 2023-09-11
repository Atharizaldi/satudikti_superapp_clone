part of 'majalah_gmagz_bloc.dart';

abstract class MajalahGMagzState extends Equatable {
  const MajalahGMagzState();

  @override
  List<Object> get props => [];
}

class MajalahGMagzinInitial extends MajalahGMagzState {}

class MajalahGMagzLoadedState extends MajalahGMagzState {
  final List<ListBook> listBook;
  final String sort;
  final String judul;
  final String displayBy;
  final int totalRowCount;
  bool hasReachedMax;
  final int newPage;

  MajalahGMagzLoadedState(
      {required this.listBook,
      required this.sort,
      required this.judul,
      required this.displayBy,
      required this.hasReachedMax,
      required this.newPage,
      required this.totalRowCount});
  @override
  List<Object> get props =>
      [listBook, judul, sort, hasReachedMax, newPage, totalRowCount, displayBy];
}

class MajalahGMagzLoading extends MajalahGMagzState {
  @override
  List<Object> get props => [];
}

class MajalahGMagzMAX extends MajalahGMagzState {
  @override
  List<Object> get props => [];
}

class MajalahGMagzNoInternetState extends MajalahGMagzState {
  final String sort;

  MajalahGMagzNoInternetState({required this.sort});

  @override
  List<Object> get props => [this.sort];
}

class MajalahGMagzErrorState extends MajalahGMagzState {
  final String sort;

  MajalahGMagzErrorState({required this.sort});

  @override
  List<Object> get props => [];
}

class MajalahGMagzNotFoundState extends MajalahGMagzState {
  final MajalahGMagz? mahalahGMagz;

  MajalahGMagzNotFoundState(this.mahalahGMagz);

  @override
  List<Object> get props => [];
}
