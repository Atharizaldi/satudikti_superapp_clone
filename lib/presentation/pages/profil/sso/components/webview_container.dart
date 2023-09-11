import 'dart:convert';
import 'dart:io';

import 'package:app/data/source/remote/model/profil/user_information.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/profil/bloc/profil_bloc.dart';
import 'package:app/presentation/pages/profil/sso/utils/sso_utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewContainer extends StatefulWidget {
  final Map<String, String> queryParameters;
  final Uri authorizationUrl;
  final Uri redirectUrl;
  final dynamic responseUrl;
  WebViewContainer(
      {required this.queryParameters,
      required this.authorizationUrl,
      required this.redirectUrl,
      required this.responseUrl});
  @override
  createState() => _WebViewContainerState(
        queryParameters: this.queryParameters,
        authorizationUrl: this.authorizationUrl,
        redirectUrl: this.redirectUrl,
        responseUrl: this.responseUrl,
      );
}

class _WebViewContainerState extends State<WebViewContainer> {
  Map<String, String> queryParameters;
  var authorizationUrl;
  var redirectUrl;
  var responseUrl;
  _WebViewContainerState({
    required this.queryParameters,
    required this.authorizationUrl,
    required this.redirectUrl,
    required this.responseUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarSSO(),
        body: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: authorizationUrl.toString(),
          onWebResourceError: (er) {
            Logger().i("ERROR onWebResourceError : $er");
          },

          navigationDelegate: (navReq) async {
            var creds;
            responseUrl = Uri.parse(navReq.url);

            // print(
            //     "navreg url ${navReq.url} redirect url ${redirectUrl.toString()}");
            if (navReq.url.startsWith(redirectUrl.toString())) {
              queryParameters = Uri.parse(navReq.url).queryParameters;
              Logger().i("NAVREEGG responseUrl $responseUrl");

              var client = await grant!
                  .handleAuthorizationResponse(responseUrl.queryParameters);
              Logger().i("CLIENTT ${client.identifier},${client.secret} ");
              creds = client.credentials;

              // print(
              //     "json to Credentials ${Credentials.fromJson(jsonCreds)}");
              // var getUserinfos = await getUserInformation(creds);
              // print(
              //     'Response from get userinfo with token: ${getUserinfos.body}');

              // save to prefs

              // blom handle kalo ada error
              BlocProvider.of<ProfilBloc>(context)
                ..add(LogInEvent(credentials: creds));
              // userInformations =
              //     json.decode(getUserinfos.body)['data']['nm_pengguna'];

              // PUT User FCM Token to server
              //================================

              //Get user FCM Token
              String? userToken;
              await FirebaseMessaging.instance.getToken().then((value) {
                Logger().i("TOKEN DARI PAGE LOGIN: " + value.toString());
                userToken = value.toString();
              });

              // Get user ID
              String? userID;
              var uri = Uri.parse(urlUserinfo);
              Map<String, String> headers = {
                'Authorization': 'Bearer ${creds.accessToken}',
              };
              try {
                var response = await http.get(uri, headers: headers);
                if (response.statusCode == 200) {
                  String jsonDataString = response.body.toString();
                  var jsonData = jsonDecode(jsonDataString);
                  final result = UserInformationResponse.fromJson(jsonData);

                  userID = result.data!.idPengguna;
                  print("USER ID : " + userID.toString());
                } else {
                  Logger().e("Server Failure when GET user ID");
                }
              } on Exception {
                Logger().e("Exception");
              }

              // If userID not null, then PUT FCM Token to server
              if (userID != null) {
                var uri = Uri.parse(
                    'https://devsuperapp-api.dikti.go.id/v2/sso/api/v1/user/profile/$userID/token');

                try {
                  final response = await http.put(uri,
                      headers: <String, String>{
                        dotenv.get('API_KEY'): dotenv.get('API_VALUE'),
                        'Content-Type': 'application/json',
                      },
                      body: jsonEncode({
                        'token': userToken,
                      }));
                  if (response.statusCode == 200) {
                    Logger().i("PUT token success");
                  } else {
                    Logger().e("Server Failure when PUT token");
                  }
                } on SocketException {
                  Logger().e("Exception when PUT token");
                }
              }

              Navigator.pop(context);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          // ------- 8< -------
        ));
  }
}

class AppBarSSO extends StatelessWidget with PreferredSizeWidget {
  const AppBarSSO({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: Colors.transparent,
      centerTitle: true,
      actions: [Container()],
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(bottom: 0.5),
        child: Container(
            decoration: BoxDecoration(
          gradient: appBarGradient,
        )),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
