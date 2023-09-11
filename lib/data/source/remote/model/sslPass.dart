import 'dart:io';

import 'package:flutter/services.dart';

class MyHttpOverrides extends HttpOverrides {
  ByteData clientCert;
  ByteData keystore;

  MyHttpOverrides({
    required this.clientCert,
    required this.keystore,
  });

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    context = SecurityContext.defaultContext;

    bool _certificateCheck(truststore, String host, int port) {
      return host == "api.satudikti.id";
    }

    String password = "";

    context.useCertificateChainBytes(clientCert.buffer.asUint8List(),
        password: password);

    context.usePrivateKeyBytes(keystore.buffer.asUint8List(),
        password: password);

    HttpClient client = super.createHttpClient(context)
      ..badCertificateCallback = (_certificateCheck);

    client..badCertificateCallback = (_certificateCheck);

    return client;
  }
}

void sslPass() async {
  var chain = await rootBundle.load('assets/certificates/satudikti.crt');
  var key = await rootBundle.load('assets/certificates/satudikti.key');

  HttpOverrides.global = MyHttpOverrides(
    clientCert: chain,
    keystore: key,
  );
}
