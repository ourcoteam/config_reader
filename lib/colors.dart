import 'dart:io';

import 'package:xml/xml.dart';
import 'package:collection/collection.dart';

Future colors({
  String? notiColor,
}) async {
  if (notiColor == null) return;

  if (!notiColor.startsWith('#')) {
    notiColor = '#$notiColor';
  }

  final file = File('android/app/src/main/res/values/colors.xml');
  final contents = file.readAsStringSync();
  final xml = XmlDocument.parse(contents);
  if (contents.contains('noti_color')) {
    xml
        .findAllElements('color')
        .firstWhereOrNull((element) =>
            element.attributes.any((e) => e.name.local == 'noti_color'))
        ?.innerText = notiColor;
  } else {
    xml.rootElement.children.add(
      XmlElement(
        XmlName('color'),
        [XmlAttribute(XmlName('name'), 'noti_color')],
        [XmlText(notiColor)],
      ),
    );
  }
  file.writeAsStringSync(xml.toXmlString(pretty: true));
}
