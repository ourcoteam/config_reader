import 'dart:io';

Future tempJson({
  String keyId,
  String issuerId,
  String authKey,
}) async {
  if (keyId == null || issuerId == null || authKey == null) return;

  authKey = authKey.replaceAll(RegExp("[\r\n]+"), r"\n");

  final file = File('ios/fastlane/temp.json');
  if (file.existsSync() == false) {
    file.createSync();
  }
  file.writeAsStringSync('''
{
  "key_id": "$keyId",
  "issuer_id": "$issuerId",
  "key": "$authKey",
  "in_house": false
}''');
}
