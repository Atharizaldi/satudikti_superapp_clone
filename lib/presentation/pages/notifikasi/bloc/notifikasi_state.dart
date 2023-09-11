part of 'notifikasi_bloc.dart';

abstract class NotifikasiState extends Equatable {
  const NotifikasiState();
}

class NotifikasiLoadingState extends NotifikasiState {
  @override
  List<Object> get props => [];
}

class NotifikasiErrorState extends NotifikasiState {
  @override
  List<Object> get props => [];
}

class NotifikasiLoadedState extends NotifikasiState {
  final List<Notification> notificationList;
  final List<Notification> notificationPengumumanList;
  final List<Notification> notificationBeritaList;
  //Notifikasi Tambahan
  final List<Notification> notificationKomdosList;
  final List<Notification> notificationSelancarPAKList;
  final List<Notification> notificationPDDiktiList;

  NotifikasiLoadedState(
      {required this.notificationList,
      required this.notificationPengumumanList,
      required this.notificationBeritaList,
      required this.notificationKomdosList,
      required this.notificationSelancarPAKList,
      required this.notificationPDDiktiList});

  @override
  List<Object> get props => [];
}
