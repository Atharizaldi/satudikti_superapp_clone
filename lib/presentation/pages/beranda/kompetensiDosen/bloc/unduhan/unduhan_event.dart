part of 'unduhan_bloc.dart';

abstract class UnduhanEvent extends Equatable {
  const UnduhanEvent();

  @override
  List<Object> get props => [];
}

class GetUnduhanEvent extends UnduhanEvent {
  final String id;
  GetUnduhanEvent({required this.id});
}
