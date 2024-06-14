import 'dart:convert';
import 'dart:io';

import 'package:benji_rider/src/providers/constants.dart';
import 'package:benji_rider/src/repo/controller/api_url.dart';
import 'package:benji_rider/src/repo/utils/helpers.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class AppVersion {
  final String version;
  final String app;
  final String link;
  final String details;
  final String releaseDate;

  AppVersion({
    required this.version,
    required this.app,
    required this.link,
    required this.details,
    required this.releaseDate,
  });

  factory AppVersion.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return AppVersion(
      version: json['version'] ?? "0",
      app: json['app'] ?? notAvailable,
      link: json['link'] ?? notAvailable,
      details: json['details'] ?? notAvailable,
      releaseDate: json['release_date'] ?? notAvailable,
    );
  }
}

Future<AppVersion> getAppLatestVersion() async {
  String os = "";
  String app = "rider";
  if (Platform.isAndroid) {
    os = "android";
  } else if (Platform.isIOS) {
    os = "ios";
  } else {
    return AppVersion.fromJson(null);
  }

  var url = "${Api.baseUrl}/app-version/getLatestAppVersion/$os/$app";
  print(url);
  try {
    http.Response response =
        await http.get(Uri.parse(url), headers: authHeader());
    print(response.body);
    return AppVersion.fromJson(jsonDecode(response.body));
  } catch (e) {
    print(e);
  }
  return AppVersion.fromJson(null);
}

Future<void> launchDownload(String openUrl) async {
  final url = Uri.parse(openUrl);
  print(url);
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
    webViewConfiguration: const WebViewConfiguration(
        headers: <String, String>{'my_header_key': 'my_header_value'}),
  )) {
    throw Exception('Could not launch $url');
  }
}
