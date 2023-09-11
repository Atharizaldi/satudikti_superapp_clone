part of 'list_pagination_beasiswa_bloc.dart';

abstract class ListPaginationBeasiswaState extends Equatable {
  const ListPaginationBeasiswaState();

  @override
  List<Object> get props => [];
}

class ListPaginationBeasiswaInitial extends ListPaginationBeasiswaState {}

class ListPaginationBeasiswaFailed extends ListPaginationBeasiswaState {}

class ListPaginationBeasiswaLoading extends ListPaginationBeasiswaState {}

class ListPaginationBeasiswaNoInternet extends ListPaginationBeasiswaState {}

class ListPaginationBeasiswaLoaded extends ListPaginationBeasiswaState {
  final bool hasReachedMax;
  final int newPage;
  final Beasiswa beasiswa;
  final List<ListBeasiswa> listBeasiswa;

  ListPaginationBeasiswaLoaded(
      {required this.hasReachedMax,
      required this.newPage,
      required this.beasiswa,
      required this.listBeasiswa});
  @override
  List<Object> get props => [hasReachedMax, newPage, beasiswa, listBeasiswa];
}
