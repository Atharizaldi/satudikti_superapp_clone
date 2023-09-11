import 'package:app/common/notificationHelper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static late SharedPreferences _prefs;

  // await FirebaseMessaging.instance.subscribeToTopic(newsTopic);
  // await FirebaseMessaging.instance.subscribeToTopic(pengumumanTopic);
  static const _beritaKey = "berita";
  static const _pengumumanKey = "pengumuman";
  static const _majalahKey = 'majalah';
  static const _majalahintKey = 'majalahint';
  static const _nidnDosenKey = 'nidnDosen';
  static const _dataDosenKey = 'dataDosen';

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    _prefs = await SharedPreferences.getInstance();

    initNotif();

    return _prefs;
  }

  static Future<void> initNotif() async {
    bool? beritaState = getNotifBerita();
    bool? pengumumanState = getNotifPengumuman();

    if (beritaState == null || beritaState == true) {
      Logger().i("Notification Berita subscribed");
      await FirebaseMessaging.instance
          .subscribeToTopic(NotificationHelper.newsTopic);
    } else {
      Logger().i("Notification Berita unsubscribed");
      await FirebaseMessaging.instance
          .unsubscribeFromTopic(NotificationHelper.newsTopic);
    }

    if (pengumumanState == null || pengumumanState == true) {
      Logger().i("Notification Pengumuman subscribed");
      await FirebaseMessaging.instance
          .subscribeToTopic(NotificationHelper.pengumumanTopic);
    } else {
      Logger().i("Notification Pengumuman unsubscribed");
      await FirebaseMessaging.instance
          .unsubscribeFromTopic(NotificationHelper.pengumumanTopic);
    }
  }

  //notification
  static Future<bool> setNotifBerita(bool value) async =>
      await _prefs.setBool(_beritaKey, value);

  static Future<bool> setNotifPengumuman(bool value) async =>
      await _prefs.setBool(_pengumumanKey, value);

  static Future<bool> setMajalah(String value) async =>
      await _prefs.setString(_majalahKey, value);

  static Future<bool> setMajalahInt(List<String> value) async =>
      await _prefs.setStringList(_majalahintKey, value);

  static Future<bool> setNidnDosen(String value) async =>
      await _prefs.setString(_nidnDosenKey, value);

  static Future<bool> setDataDosen(List<String> value) async =>
      await _prefs.setStringList(_dataDosenKey, value);

  static bool? getNotifBerita() => _prefs.getBool(_beritaKey);

  static bool? getNotifPengumuman() => _prefs.getBool(_pengumumanKey);

  static String? getMajalah() => _prefs.getString(_majalahKey);

  static List<String>? getMajalahInt() => _prefs.getStringList(_majalahintKey);

  static String? getNidnDosen() => _prefs.getString(_nidnDosenKey);

  static List<String>? getDataDosen() => _prefs.getStringList(_dataDosenKey);

  //deletes..
  static Future<bool> remove(String key) async => await _prefs.remove(key);

  static Future<bool> clear() async => await _prefs.clear();
}
