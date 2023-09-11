import 'package:app/data/source/local/model/notification.dart';
import 'package:app/data/source/local/queryDb.dart' as database;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'notifikasi_event.dart';
part 'notifikasi_state.dart';

class NotifikasiBloc extends Bloc<NotifikasiEvent, NotifikasiState> {
  Logger log;

  NotifikasiBloc({required this.log}) : super(NotifikasiLoadingState()) {
    on<GetNotifikasiEvent>(_getNotifikasi);
    on<UpdateNotifikasiEvent>(_updateNotifikasi);
    on<MarkReadAllNotifikasiEvent>(_markReadAllNotifikasi);
  }

  void _getNotifikasi(
      GetNotifikasiEvent event, Emitter<NotifikasiState> emit) async {
    emit(NotifikasiLoadingState());
    try {
      List<Notification> notificationList = await database.getNotification();
      if (notificationList.length > 30) {
        await database.deleteNotification(notificationList[0]).then((value) {
          add(GetNotifikasiEvent());
        });
      } else {
        List<Notification> notificationPengumumanList = notificationList
            .where((notification) => notification.topic == 'pengumuman')
            .toList();
        List<Notification> notificationBeritaList = notificationList
            .where((notification) => notification.topic == 'news')
            .toList();
        List<Notification> notificationKomdosList = notificationList
            .where((notification) => notification.topic == 'Komdos')
            .toList();
        List<Notification> notificationSelancarPAKList = notificationList
            .where((notification) => notification.topic == 'selancarPAK')
            .toList();
        List<Notification> notificationPDDiktiList = notificationList
            .where((notification) => notification.topic == 'PDDIKTI')
            .toList();
        emit(NotifikasiLoadedState(
            notificationList: notificationList,
            notificationPengumumanList: notificationPengumumanList,
            notificationBeritaList: notificationBeritaList,
            notificationKomdosList: notificationKomdosList,
            notificationSelancarPAKList: notificationSelancarPAKList,
            notificationPDDiktiList: notificationPDDiktiList));
      }
    } on Exception catch (e) {
      log.i("NotifikasiBloc getNotif error: ${e.toString()}");
      emit(NotifikasiErrorState());
    }
  }

  void _updateNotifikasi(
      UpdateNotifikasiEvent event, Emitter<NotifikasiState> emit) async {
    await database.updateNotification(event.notification);
    add(GetNotifikasiEvent());
  }

  void _markReadAllNotifikasi(
      MarkReadAllNotifikasiEvent event, Emitter<NotifikasiState> emit) async {
    if (state is NotifikasiLoadedState) {
      NotifikasiLoadedState loadedState = state as NotifikasiLoadedState;

      loadedState.notificationList.forEach((notification) async {
        await database.updateNotification(notification);
      });

      add(GetNotifikasiEvent());
    }
  }
}
