import 'dart:io';

import 'package:app/common/internetCheck.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

class ShowWebsite extends StatefulWidget {
  final String link;
  final String title;
  const ShowWebsite({Key? key, required this.link, this.title = ''})
      : super(key: key);

  @override
  _ShowWebsiteState createState() => _ShowWebsiteState();
}

class _ShowWebsiteState extends State<ShowWebsite> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  late PullToRefreshController pullToRefreshController;
  String url = "";
  double progress = 0;
  final urlController = TextEditingController();
  var isConnected = false;
  bool showError = false;

  @override
  void initState() {
    super.initState();
    internetCheck();
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  dynamic internetCheck() async {
    final result = await InternetCheck().hasConnection();
    setState(() {
      isConnected = result;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            widget.title,
            style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 1),
          ),
          actions: [Container()],
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(bottom: 0.5),
            child: Container(
                decoration: BoxDecoration(
              gradient: appBarGradient,
            )),
          ),
        ),
        body: isConnected
            ? SafeArea(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Stack(
                        children: [
                          showError
                              ? Container()
                              : InAppWebView(
                                  key: webViewKey,
                                  initialUrlRequest:
                                      URLRequest(url: Uri.parse(widget.link)),
                                  initialOptions: options,
                                  pullToRefreshController:
                                      pullToRefreshController,
                                  onWebViewCreated: (controller) {
                                    webViewController = controller;
                                  },
                                  onLoadStart: (controller, url) {
                                    setState(() {
                                      this.url = url.toString();
                                      urlController.text = this.url;
                                    });
                                  },
                                  onReceivedServerTrustAuthRequest:
                                      (controller, challenge) async {
                                    return ServerTrustAuthResponse(
                                        action: ServerTrustAuthResponseAction
                                            .PROCEED);
                                  },
                                  androidOnPermissionRequest:
                                      (controller, origin, resources) async {
                                    return PermissionRequestResponse(
                                        resources: resources,
                                        action: PermissionRequestResponseAction
                                            .GRANT);
                                  },
                                  shouldOverrideUrlLoading:
                                      (controller, navigationAction) async {
                                    var uri = navigationAction.request.url!;
                                    print('URI $uri');
                                    if (![
                                      "http",
                                      "https",
                                      "file",
                                      "chrome",
                                      "data",
                                      "javascript",
                                      "about"
                                    ].contains(uri.scheme)) {
                                      if (await canLaunch(url)) {
                                        // Launch the App
                                        print("LAUNCHH");
                                        await launch(
                                          url,
                                        );
                                        // and cancel the request
                                        return NavigationActionPolicy.CANCEL;
                                      }
                                    }

                                    return NavigationActionPolicy.ALLOW;
                                  },
                                  onLoadStop: (controller, url) async {
                                    pullToRefreshController.endRefreshing();
                                    print("OnloADSTOP");
                                    setState(() {
                                      this.url = url.toString();
                                      urlController.text = this.url;
                                      progress = 1.0;
                                    });
                                  },
                                  onLoadError:
                                      (controller, url, code, message) {
                                    progress = 1.0;

                                    // code -6 & -2: no internet available
                                    if (code == -6 || code == -2) {
                                      showError = true;
                                      setState(() {});
                                    }
                                  },
                                  onProgressChanged: (controller, progress) {
                                    if (progress == 100) {
                                      pullToRefreshController.endRefreshing();
                                    }
                                    print('progress: $progress');
                                    this.progress = progress / 100;
                                    // setState(() {});

                                    urlController.text = this.url;
                                  },
                                  onUpdateVisitedHistory:
                                      (controller, url, androidIsReload) {
                                    setState(() {
                                      this.url = url.toString();
                                      urlController.text = this.url;
                                    });
                                  },
                                  onConsoleMessage:
                                      (controller, consoleMessage) {
                                    print('$consoleMessage');
                                  },
                                ),
                          progress < 1.0
                              ? LinearProgressIndicator(value: progress)
                              : Container(),
                          showError
                              ? NoInternet(onPressed: () {}, buttonHide: true)
                              : Container()
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : NoInternet(onPressed: () => internetCheck(), buttonHide: false),
      ),
    );
  }
}
