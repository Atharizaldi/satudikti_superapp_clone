part of 'berita_bloc.dart';

abstract class BeritaEvent extends Equatable {
  const BeritaEvent();
}

class GetBeritaEvent extends BeritaEvent {
  final String category;

  GetBeritaEvent({required this.category});

  @override
  List<Object> get props => [category];
}
