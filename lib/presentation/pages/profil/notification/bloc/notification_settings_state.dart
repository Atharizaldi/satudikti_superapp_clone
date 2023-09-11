part of 'notification_settings_bloc.dart';

abstract class NotificationSettingsState extends Equatable {
  const NotificationSettingsState();
}

class NotificationSwitchsState extends NotificationSettingsState {
  final bool berita;
  final bool pengumuman;

  NotificationSwitchsState({required this.berita, required this.pengumuman});

  @override
  List<Object> get props => [berita, pengumuman];
}