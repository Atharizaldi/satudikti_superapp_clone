import 'package:app/injection.dart';
import 'package:app/presentation/pages/profil/bloc/profil_bloc.dart';
import 'package:app/presentation/pages/profil/notification/bloc/notification_settings_bloc.dart';

void profilBlocInjection() {
  locator.registerFactory(
    () => ProfilBloc(
      log: locator(),
      internetCheck: locator(),
      getUserInformationUseCase: locator(),
      getUserInformationDetail: locator(),
      logoutSSO: locator(),
      getUserAvatar: locator(),
      putUserAvatar: locator()
    ),
  );
  locator.registerFactory(() => NotificationSettingsBloc(log: locator()));
}
