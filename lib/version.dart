import 'dart:io';

Future<Map<String, String>> versions() async {
  final pubFileYaml = File('pubspec.yaml');

  final lastAndroidVersionRaw = pubFileYaml.readAsLinesSync().firstWhere((element) => element.contains('version:'));
  final lastAndroidVersion = lastAndroidVersionRaw.trim().replaceFirst('version: ', '');
  final lastAndroidVersionString = lastAndroidVersion.split('+').first;
  final lastAndroidVersionStringSegments = lastAndroidVersionString.split('.');
  final lastAndroidVersionNumberString = lastAndroidVersionStringSegments.last;
  final lastAndroidVersionPrefixString = lastAndroidVersionStringSegments.take(lastAndroidVersionStringSegments.length - 1).join('.');

  final lastAndroidVersionNumber = int.parse(lastAndroidVersionNumberString);
  final newAndroidVersionNumber = lastAndroidVersionNumber + 1;

  final infoPlist = File('ios/Runner/Info.plist');
  final infoPlistLines = infoPlist.readAsLinesSync();

  int lastIosVersionNumber;
  String lastIosVersionPrefixString;

  try {
    final lastIosVersionNumberStringRaw = infoPlistLines
        .elementAt(infoPlistLines.indexWhere((element) => element.contains('CFBundleShortVersionString')) + 1)
        .trim()
        .replaceFirst('<string>', '')
        .replaceFirst('</string>', '');
    final lastIosVersionNumberStringSegments = lastIosVersionNumberStringRaw.split('.');
    final lastIosVersionNumberString = lastIosVersionNumberStringSegments.last;
    lastIosVersionPrefixString = lastIosVersionNumberStringSegments.take(lastIosVersionNumberStringSegments.length - 1).join('.');
    lastIosVersionNumber = int.parse(lastIosVersionNumberString);
  } catch (e) {
    return null;
  }

  final newIosVersionNumber = lastIosVersionNumber + 1;

  return {
    "android": '$lastAndroidVersionPrefixString.$newAndroidVersionNumber+${newAndroidVersionNumber + 1}',
    "ios": '$lastIosVersionPrefixString.$newIosVersionNumber',
  };
}
