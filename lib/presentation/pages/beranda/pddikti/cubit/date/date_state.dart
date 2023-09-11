part of 'date_cubit.dart';

abstract class DateState extends Equatable {
  const DateState();

  @override
  List<Object> get props => [];
}

class DateInitial extends DateState {}

class DateLoaded extends DateState {
  final String date;
  DateLoaded({required this.date});
}
