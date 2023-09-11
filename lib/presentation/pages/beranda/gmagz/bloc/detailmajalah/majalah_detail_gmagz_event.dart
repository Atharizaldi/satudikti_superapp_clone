part of 'majalah_detail_gmagz_bloc.dart';

abstract class MajalahDetailGMagzevent extends Equatable {
  const MajalahDetailGMagzevent();

  @override
  List<Object> get props => [];
}

class GetMajalahDetailGMagzEvent extends MajalahDetailGMagzevent {
  final String id;

  GetMajalahDetailGMagzEvent({required this.id});
  @override
  List<Object> get props => [id];
}

class PutGMagzDownloader extends MajalahDetailGMagzevent {
  final String id;

  PutGMagzDownloader({required this.id});

  @override
  List<Object> get props => [id];
}

class PutGMagzReader extends MajalahDetailGMagzevent {
  final String id;

  PutGMagzReader({required this.id});

  @override
  List<Object> get props => [id];
}
