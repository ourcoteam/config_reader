import 'dart:io';

Future<String> getReversedClientId() async {
  final file = File('ios/Runner/GoogleService-Info.plist');
  if (file.existsSync() == false) {
    print('GoogleInfo.plist not found in ios/Runner');
    return null;
  }

  final lines = file.readAsLinesSync();
  for (int i = 0; i < lines.length; i++) {
    if (lines[i].contains('REVERSED_CLIENT_ID')) {
      return lines[i + 1].replaceAll('<string>', '').replaceAll('</string>', '').trim();
    }
  }

  print('no REVERSED_CLIENT_ID found in GoogleInfo.plist ');
  return null;
}
