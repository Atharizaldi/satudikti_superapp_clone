part of 'statuspengajuan_bloc.dart';

abstract class StatuspengajuanState extends Equatable {
  const StatuspengajuanState();

  @override
  List<Object> get props => [];
}

class StatuspengajuanLoading extends StatuspengajuanState {
  @override
  List<Object> get props => [];
}

class StatusPengajuanLoaded extends StatuspengajuanState {
  final StatusByEmail listByEmail;

  StatusPengajuanLoaded({required this.listByEmail});
  @override
  List<Object> get props => [listByEmail];
}

class StatusPengajuanLoadedFailed extends StatuspengajuanState {
  StatusPengajuanLoadedFailed();
  @override
  List<Object> get props => [];
}
