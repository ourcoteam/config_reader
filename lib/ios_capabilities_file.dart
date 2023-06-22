import 'dart:io';

import 'package:config_reader/utils.dart';

Future iosCapabilitiesFile(Map<String, dynamic> config) async {
  final file = File('ios/ios_capabilities');
  final exists = await file.exists();
  if (!exists) {
    await file.create();
  }

  final hasApple = config?.getMap('socialLogin')?.get('apple') != null;
  final hasDomain = config?.get('associatedDomain')?.toString() == 'true';

  final content = [
    'notification',
    if (hasApple) 'sign',
    if (hasDomain) 'domain',
  ].join('_');
  await file.writeAsString(content);
}
