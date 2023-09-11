import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecurePrefs {
  static late FlutterSecureStorage _securePrefs = FlutterSecureStorage();

  //deletes..
  static Future<void> delete(String key) async =>
      await _securePrefs.delete(key: key);

  static Future<void> deleteAll() async => await _securePrefs.deleteAll();
}
