import 'dart:io';

import 'package:app/common/notificationHelper.dart';
import 'package:app/data/source/local/sharedpreferences.dart';
import 'package:app/data/source/remote/model/sslPass.dart';
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/beranda/bloc/beranda_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/cubit/tab_bar/tab_bar_cubit.dart';
import 'package:app/presentation/pages/profil/bloc/profil_bloc.dart';
import 'package:app/presentation/pages/profil/notification/bloc/notification_settings_bloc.dart';
import 'package:app/presentation/pages/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:webview_flutter/webview_flutter.dart';

Logger log = Logger();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var chain = await rootBundle.load('assets/certificates/satudikti.crt');
  var key = await rootBundle.load('assets/certificates/satudikti.key');

  await dotenv.load();

  HttpOverrides.global = MyHttpOverrides(
    clientCert: chain,
    keystore: key,
  );

  openDatabase(
    join(await getDatabasesPath(), 'notification.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE notification(id INTEGER PRIMARY KEY, notifId TEXT, isRead INTEGER, title TEXT, body TEXT, category TEXT, tanggal TEXT, topic TEXT)',
      );
    },
    version: 1,
  );

  await Firebase.initializeApp();
  NotificationHelper.initFirebaseNotification();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  initializeDateFormatting();

  await Prefs.init();
  di.init();

  if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => di.locator<BerandaBloc>()
              ..add(GetRecentBeritaEvent())
              ..add(GetPengungumanEvent())
              ..add(GetPopularBeritaEvent())
              ..add(GetLayananFavoritEvent()),
          ),
          BlocProvider(
              create: (BuildContext context) =>
                  di.locator<ProfilBloc>()..add(CheckIsLoggedInEvent())),
          BlocProvider(
              create: (BuildContext context) =>
                  di.locator<NotificationSettingsBloc>()
                    ..add(GetSettingsEvent())),
          BlocProvider(
            create: (context) => TabBarCubit(),
          ),
        ],
        child: MaterialApp(
          title: 'Satudikti',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: white,
            primarySwatch: Colors.blue,
            fontFamily: 'Plus Jakarta Sans',
          ),
          builder: (context, widget) {
            ScreenUtil.setContext(context);
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
              child: widget!,
            );
          },
          home: SplashScreen(),
        ),
      ),
    );
  }
}
