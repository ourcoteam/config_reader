import 'dart:io';

import 'package:config_reader/utils/utils.dart';

Future runnerEntitlements({
  String applink,
}) async {
  final file = File('ios/Runner/Runner.entitlements');
  if (file.existsSync() == false) {
    file.createSync();
  }
  final fileRelease = File('ios/Runner/RunnerRelease.entitlements');
  if (fileRelease.existsSync() == false) {
    fileRelease.createSync();
  }
  final content = '''
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>aps-environment</key>
	<string>development</string>
	<key>com.apple.developer.associated-domains</key>
	${stringNotNullOrEmpty(applink) ? '''
<array>
      <string>applinks:${Uri.parse(applink).host}</string>
    </array>''' : ''}
    <key>com.apple.developer.applesignin</key>
    <array>
      <string>Default</string>
    </array>
</dict>
</plist>
''';
  file.writeAsStringSync(content);
  fileRelease.writeAsStringSync(content);
}
