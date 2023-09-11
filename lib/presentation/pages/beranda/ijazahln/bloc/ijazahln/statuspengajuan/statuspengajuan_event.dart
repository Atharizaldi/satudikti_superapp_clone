part of 'statuspengajuan_bloc.dart';

abstract class StatuspengajuanEvent extends Equatable {
  const StatuspengajuanEvent();

  @override
  List<Object> get props => [];
}

class FetchStatusPengajuan extends StatuspengajuanEvent {
  final String query;

  FetchStatusPengajuan(this.query);
  @override
  List<Object> get props => [query];
}

class FetchStatusPengajuanFailed extends StatuspengajuanEvent {
  FetchStatusPengajuanFailed();

  @override
  List<Object> get props => [];
}
