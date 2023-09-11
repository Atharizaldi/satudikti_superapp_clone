part of 'notifikasi_bloc.dart';

abstract class NotifikasiEvent extends Equatable {
  const NotifikasiEvent();
}

class NotifikasiErrorEvent extends NotifikasiEvent {
  @override
  List<Object> get props => [];
}

class GetNotifikasiEvent extends NotifikasiEvent {
  @override
  List<Object> get props => [];
}

class UpdateNotifikasiEvent extends NotifikasiEvent {
  final Notification notification;

  UpdateNotifikasiEvent({required this.notification});

  @override
  List<Object> get props => [];
}

class MarkReadAllNotifikasiEvent extends NotifikasiEvent {

  @override
  List<Object> get props => [];
}

