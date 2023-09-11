import 'package:app/data/source/local/model/notification.dart'
    as notificationModel;
import 'package:app/data/source/local/queryDb.dart' as database;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';

class NotificationHelper {
  static Logger log = Logger();

  static final _notification = FlutterLocalNotificationsPlugin();
  static final newsTopic = "news";
  static final pengumumanTopic = "pengumuman";

  static Future<void> initFirebaseNotification() async {
    await initiateSettings();

    String? userToken;
    await FirebaseMessaging.instance.getToken().then((value) {
      log.i("TOKEN: " + value.toString());
      userToken = value.toString();
    });

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    firebaseForegroundListener();
  }

  static Future<void> initiateSettings() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_stat_icondikti');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _notification.initialize(initializationSettings,
        onSelectNotification: ((payload) {}));

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    var notificationValues = firebaseResponseToNotification(message);

    log.i("Notification background handler ${notificationValues.title}");
    await database.insertNotifications(notificationValues);
  }

  static Future<void> firebaseForegroundListener() async {
    //=================FOREGROUND===================//
    //this is actually not really foreground, bcs when app closed this listen is executed
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      var notificationValues = firebaseResponseToNotification(message);

      log.i("Notification foreground tanggal : ${notificationValues.tanggal}");
      await database.insertNotifications(notificationValues);

      if (notification != null && android != null && !kIsWeb) {
        showNotification(
            id: notification.hashCode,
            title: notification.title,
            body: notification.body,
            payload: notificationValues.notifId);
      }
    });
  }

  static Future<NotificationDetails> notificationDetails() async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'notification channel',
      "notification channel",
      channelDescription: 'This channel is used for basic notifications.',
      icon: '@drawable/ic_stat_icondikti',
      largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
      importance: Importance.max,
      priority: Priority.high,
    );
    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    return NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails);
  }

  static Future showNotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    log.i("showNotification $title");
    _notification.show(
      id,
      title,
      body,
      await notificationDetails(),
      payload: payload,
    );
  }

  static Future showNotificationTest() async {
    log.i("showNotificationTest");
    _notification.show(
      0,
      "title",
      "body",
      await notificationDetails(),
      payload: "payload",
    );
  }

  static notificationModel.Notification firebaseResponseToNotification(
      RemoteMessage message) {
    log.i("Receive Notif: ${message.sentTime}");
    print("BODY DATA ${message.data}");
    // print("INI NOTIF KATEGORY ${message.}");
    print("INI ISI NOTIFKASI ${message.notification!.titleLocKey}");
    print("Response Body:");
    print("Nama Notifikasi: ${message.data['notification_name']}");

    // print(message.notification!.body);

    return notificationModel.Notification(
      notifId: message.messageId.toString(),
      title: message.notification!.title.toString(),
      body: message.notification!.body.toString(),
      category: message.category.toString(),
      isRead: 0,
      tanggal: message.sentTime.toString(),
      topic: message.category.toString(),
    );
  }

  static Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    log.i("onDidReceiveLocalNotification: $title");
    // display a dialog with the notification details, tap ok to go to another page
    //older IOS than 10
  }
}
