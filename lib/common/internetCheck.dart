//Class untuk cek konektivitas internet
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logger/logger.dart';

class InternetCheck {
  Logger log = Logger();

  Future<bool> hasConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      return true;
    } else {
      return false;
    }
  }
}
