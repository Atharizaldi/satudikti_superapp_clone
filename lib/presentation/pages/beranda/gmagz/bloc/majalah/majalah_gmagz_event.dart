part of 'majalah_gmagz_bloc.dart';

abstract class MajalahGMagzevent extends Equatable {
  const MajalahGMagzevent();

  @override
  List<Object> get props => [];
}

class GetMajalahGMagzEvent extends MajalahGMagzevent {
  final String sort;
  final String judul;
  final String displayby;
  int page;

  GetMajalahGMagzEvent(
      {required this.sort,
      required this.judul,
      required this.displayby,
      this.page = 1});
  @override
  List<Object> get props => [
        sort.toString(),
        judul.toString(),
        displayby.toString(),
        page.toString()
      ];
}
