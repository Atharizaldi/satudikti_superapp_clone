part of 'notification_settings_bloc.dart';

abstract class NotificationSettingsEvent extends Equatable {
  const NotificationSettingsEvent();
}

class GetSettingsEvent extends NotificationSettingsEvent {

  @override
  List<Object> get props => [];
}

class UpdateSettingEvent extends NotificationSettingsEvent {
  final bool isBerita;
  final bool value;

  UpdateSettingEvent({required this.isBerita, required this.value});

  @override
  List<Object> get props => [isBerita, value];
}

