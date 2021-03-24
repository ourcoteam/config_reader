import 'dart:io';

Future<Map<String, String>> versions() async {
  final pubFileYaml = File('pubspec.yaml');

  final lastAndroidVersionString = pubFileYaml.readAsLinesSync().firstWhere((element) => element.contains('version:'));
  final lastAndroidVersionNumberString = lastAndroidVersionString.trim().replaceFirst('version: ', '').split('+').first.split('.').last;

  final lastAndroidVersionNumber = int.parse(lastAndroidVersionNumberString);
  final newAndroidVersionNumber = lastAndroidVersionNumber + 1;

  final infoPlist = File('ios/Runner/Info.plist');
  final infoPlistLines = infoPlist.readAsLinesSync();

  int lastIosVersionNumber;

  try {
    final lastIosVersionNumberString = infoPlistLines
        .elementAt(infoPlistLines.indexWhere((element) => element.contains('CFBundleShortVersionString')) + 1)
        .trim()
        .replaceFirst('<string>', '')
        .replaceFirst('</string>', '')
        .split('.')
        .last;
    lastIosVersionNumber = int.parse(lastIosVersionNumberString);
  } catch (e) {
    return null;
  }

  final newIosVersionNumber = lastIosVersionNumber + 1;

  return {
    "android": '1.0.$newAndroidVersionNumber+${newAndroidVersionNumber + 1}',
    "ios": '1.0.$newIosVersionNumber',
  };
}
