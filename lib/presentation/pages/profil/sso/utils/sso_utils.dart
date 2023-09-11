import 'dart:async';
import 'dart:io';

import 'package:app/common/baseUrl.dart';
import 'package:app/presentation/pages/profil/sso/components/webview_container.dart';
import 'package:app/presentation/pages/profil/sso/package/authorization_code_grant.dart';
import 'package:app/presentation/pages/profil/sso/package/client.dart';
import 'package:app/presentation/pages/profil/sso/package/credentials.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as httpClient;
import 'package:webview_flutter/webview_flutter.dart';

var userInformations;
final authorizationEndpoint = Uri.parse('$urlSSOLive/dialog/authorize');
final tokenEndpoint = Uri.parse('$urlSSOLive/oauth/token');
final urlUserinfo = '$urlSSOLive/api/userinfo';
final urlLogoutSSO = '$urlSSOLive/logout';
final redirectUrl = Uri.parse('my.test.app:/oauth2redirect');

Map<String, String> queryParameters = {};

AuthorizationCodeGrant? grant;

final credentialsFile = File('~/.myapp/credentials.json');
var responseUrl;

var authorizationUrl;

final Iterable<String> scopes = <String>[
  'userinfo',
  'profile',
];

/// Either load an OAuth2 client from saved credentials or authenticate a new
/// one.
createClient() async {
  var exists = await credentialsFile.exists();

  var identifier = dotenv.get('CLIENT_ID');
  var secret = dotenv.get('CLIENT_SECRET');
  var stateString = dotenv.get('STATE_STRING');

  print("EXIST $exists");
  // If the OAuth2 credentials have already been saved from a previous run, we
  // just want to reload them.
  if (exists) {
    var credentials =
        Credentials.fromJson(await credentialsFile.readAsString());
    return Client(
      credentials,
      identifier: identifier,
      secret: secret,
    );
  }

  // If we don't have OAuth2 credentials yet, we need to get the resource owner
  // to authorize us. We're assuming here that we're a command-line application.
  grant = AuthorizationCodeGrant(
    identifier,
    authorizationEndpoint,
    tokenEndpoint,
    secret: secret,
  );

  print("grant ${grant!}");

  print("SCOPES ITERATOR ${scopes.iterator}");
  print("AUTHORIZATION URL $authorizationUrl");

  return grant!.getAuthorizationUrl(
    redirectUrl,
    scopes: scopes,
    state: stateString,
  );
}

void showSSOLoginPage(BuildContext context, Uri authorizationUrl) {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => WebViewContainer(
              queryParameters: queryParameters,
              authorizationUrl: authorizationUrl,
              redirectUrl: redirectUrl,
              responseUrl: responseUrl,
            )),
  );
}

Future<void> showSSOLogoutPage(BuildContext context) async {
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBarSSO(),
        body: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: urlLogoutSSO.toString(),
          onPageStarted: (val) {
            print("Heloo");
          },
          navigationDelegate: (navReq) {
            return NavigationDecision.prevent;
          },
          onPageFinished: (url) {
            Navigator.pop(context);
          },
        ),
      ),
    ),
  );
  // Navigator.pop(context);

  // Navigator.pop(context);
  // Future.delayed(Duration(seconds: 1), () {
  // });
}

Future<httpClient.Response> getUserInformation(Credentials credentials) async {
  return await httpClient.get(
    Uri.parse(urlUserinfo),
    headers: {
      // 'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${credentials.accessToken}',
    },
  );
}
