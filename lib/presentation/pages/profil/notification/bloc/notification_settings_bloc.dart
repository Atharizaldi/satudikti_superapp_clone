import 'package:app/common/notificationHelper.dart';
import 'package:app/data/source/local/sharedpreferences.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart';

part 'notification_settings_event.dart';
part 'notification_settings_state.dart';

class NotificationSettingsBloc
    extends Bloc<NotificationSettingsEvent, NotificationSettingsState> {
  Logger log;

  NotificationSettingsBloc({required this.log})
      : super(NotificationSwitchsState(berita: false, pengumuman: false)) {
    on<GetSettingsEvent>(_getSettings);
    on<UpdateSettingEvent>(_updateSetting);
  }

  void _getSettings(
      GetSettingsEvent event, Emitter<NotificationSettingsState> emit) async {
    bool beritaState = Prefs.getNotifBerita() ?? true;
    bool pengumumanState = Prefs.getNotifPengumuman() ?? true;
    emit(NotificationSwitchsState(
        berita: beritaState, pengumuman: pengumumanState));
  }

  void _updateSetting(
      UpdateSettingEvent event, Emitter<NotificationSettingsState> emit) async {
    NotificationSwitchsState notificationSwitchsState =
        state as NotificationSwitchsState;

    if (event.isBerita) {
      emit(NotificationSwitchsState(
          berita: event.value,
          pengumuman: notificationSwitchsState.pengumuman));
      Prefs.setNotifBerita(event.value);
      if (event.value) {
        log.i("Notification Berita subscribed");
        FirebaseMessaging.instance
            .subscribeToTopic(NotificationHelper.newsTopic);
      } else {
        log.i("Notification Berita unsubscribed");
        FirebaseMessaging.instance
            .unsubscribeFromTopic(NotificationHelper.newsTopic);
      }
    } else {
      emit(NotificationSwitchsState(
          berita: notificationSwitchsState.berita, pengumuman: event.value));
      Prefs.setNotifPengumuman(event.value);
      if (event.value) {
        log.i("Notification Pengumuman subscribed");
        FirebaseMessaging.instance
            .subscribeToTopic(NotificationHelper.pengumumanTopic);
      } else {
        log.i("Notification Pengumuman unsubscribed");
        FirebaseMessaging.instance
            .unsubscribeFromTopic(NotificationHelper.pengumumanTopic);
      }
    }
  }
}
