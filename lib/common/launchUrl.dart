import 'package:app/common/baseUrl.dart';
import 'package:url_launcher/url_launcher.dart';

void launchURL(String url) async =>
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

void launchURLWithAppHeaders(String url) async => await canLaunch(url)
    ? await launch(
        url,
        headers: appHeaders,
      )
    : throw 'Could not launch $url';

void launchURLHK(String url) async => await launch(url);
