import 'dart:io';

import 'package:http/http.dart';

Future<void> downloadImages({
  String splashUrl,
  String iconUrl,
  String notiIconUrl,
}) async {
  await Future.wait([
    if (splashUrl != null) downloadSplash(splashUrl),
    if (iconUrl != null) downloadIcon(iconUrl),
    if (notiIconUrl != null) downloadNotiIcon(notiIconUrl),
  ]);
}

Future<void> downloadSplash(String splashUrl) async {
  final splashResponse = await get(splashUrl);
  final splashFile = File('assets/images/discy_splash_logo.png');
  if (splashFile.existsSync()) {
    splashFile.deleteSync();
  }
  splashFile.createSync();
  splashFile.writeAsBytesSync(splashResponse.bodyBytes);
}

Future<void> downloadIcon(String iconUrl) async {
  final iconResponse = await get(iconUrl);
  final iconFile = File('assets/images/discy_app_icon.png');
  if (iconFile.existsSync()) {
    iconFile.deleteSync();
  }
  iconFile.createSync();
  iconFile.writeAsBytesSync(iconResponse.bodyBytes);
}

Future<void> downloadNotiIcon(String notiIconUrl) async {
  final iconResponse = await get(notiIconUrl);
  final iconFile = File('android/app/src/main/res/drawable/noti_icon.png');
  if (iconFile.existsSync()) {
    iconFile.deleteSync();
  }
  iconFile.createSync();
  iconFile.writeAsBytesSync(iconResponse.bodyBytes);
}
