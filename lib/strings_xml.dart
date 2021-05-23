import 'dart:io';

import 'package:config_reader/utils/utils.dart';
import 'package:xml/xml.dart';

Future<void> parseFacebook({String facebookName, String facebookId}) async {
  final path = 'android/app/src/main/res/values';

  final file = File('$path/strings.xml');
  if (file.existsSync() == false) {
    file.createSync();
  }

  final builder = XmlBuilder();
  builder.processing('xml', 'version="1.0" encoding="utf-8"');

  builder.element('resources', nest: () {
    builder.element('string', attributes: {
      'name': 'app_name',
    }, nest: () {
      builder.text(facebookName??'FACEBOOK_NAME');
    });

    builder.element('string', attributes: {
      'name': 'facebook_app_id',
    }, nest: () {
      builder.text(facebookId??'FACEBOOK_ID');
    });

    builder.element('string', attributes: {
      'name': 'fb_login_protocol_scheme',
    }, nest: () {
      builder.text('fb${facebookId??'FACEBOOK_ID'}');
    });
  });

  final doc = builder.buildDocument();
  String content = doc.toXmlString(pretty: true);

  file.writeAsStringSync(content);
}
