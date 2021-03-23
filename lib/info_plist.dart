import 'dart:io';

import 'package:xml/xml.dart';

Future<void> infoPlist({
  String facebookName,
  String facebookId,
  String reversedClientId,
}) async {
  final file = File('ios/Runner/Info.plist');
  if (file.existsSync() == false) {
    file.createSync();
  }

  final content = file.readAsStringSync();
  final xml = XmlDocument.parse(content);

  XmlElement plist() => xml.getElement('plist');
  XmlElement dict() => plist().getElement('dict');

  // final gADApplicationIdentifierElement = XmlElement(XmlName('string'), [], [XmlText(adMobId)]);
  // final gADApplicationIdentifierKey = dict().children.firstWhere((e) => e.text == 'GADApplicationIdentifier', orElse: () => null);
  // if (gADApplicationIdentifierKey == null) {
  //   dict().children.add(XmlElement(XmlName('key'), [], [XmlText('GADApplicationIdentifier')]));
  //   dict().children.add(gADApplicationIdentifierElement);
  // } else {
  //   dict().children[dict().children.indexOf(gADApplicationIdentifierKey) + 1] = gADApplicationIdentifierElement;
  // }

  final facebookAppIDElement = XmlElement(XmlName('string'), [], [XmlText(facebookId)]);
  final facebookAppIDKey = dict().children.firstWhere((e) => e.text == 'FacebookAppID', orElse: () => null);
  if (facebookAppIDKey == null) {
    dict().children.add(XmlElement(XmlName('key'), [], [XmlText('FacebookAppID')]));
    dict().children.add(facebookAppIDElement);
  } else {
    dict().children[dict().children.indexOf(facebookAppIDKey) + 1] = facebookAppIDElement;
  }

  final facebookDisplayNameElement = XmlElement(XmlName('string'), [], [XmlText(facebookName)]);
  final facebookDisplayNameKey = dict().children.firstWhere((e) => e.text == 'FacebookDisplayName', orElse: () => null);
  if (facebookDisplayNameKey == null) {
    dict().children.add(XmlElement(XmlName('key'), [], [XmlText('FacebookDisplayName')]));
    dict().children.add(facebookDisplayNameElement);
  } else {
    dict().children[dict().children.indexOf(facebookDisplayNameKey) + 1] = facebookDisplayNameElement;
  }

  final lSApplicationQueriesSchemesElement = XmlElement(XmlName('array'), [], [
    XmlElement(XmlName('string'), [], [XmlText('fbapi')]),
    XmlElement(XmlName('string'), [], [XmlText('fb-messenger-share-api')]),
    XmlElement(XmlName('string'), [], [XmlText('fbauth2')]),
    XmlElement(XmlName('string'), [], [XmlText('fbshareextension')]),
  ]);
  final lSApplicationQueriesSchemesKey = dict().children.firstWhere((e) => e.text == 'LSApplicationQueriesSchemes', orElse: () => null);
  if (lSApplicationQueriesSchemesKey == null) {
    dict().children.add(XmlElement(XmlName('key'), [], [XmlText('LSApplicationQueriesSchemes')]));
    dict().children.add(lSApplicationQueriesSchemesElement);
  } else {
    dict().children[dict().children.indexOf(facebookDisplayNameKey) + 1] = lSApplicationQueriesSchemesElement;
  }

  final cFBundleURLTypesElement = XmlElement(XmlName('array'), [], [
    XmlElement(XmlName('dict'), [], [
      XmlElement(XmlName('key'), [], [XmlText('CFBundleURLSchemes')]),
      XmlElement(XmlName('array'), [], [
        XmlElement(XmlName('string'), [], [XmlText('fb$facebookId')]),
      ]),
    ]),
    XmlElement(XmlName('dict'), [], [
      XmlElement(XmlName('key'), [], [XmlText('CFBundleTypeRole')]),
      XmlElement(XmlName('string'), [], [XmlText('Editor')]),
      XmlElement(XmlName('key'), [], [XmlText('CFBundleURLSchemes')]),
      XmlElement(XmlName('array'), [], [
        XmlElement(XmlName('string'), [], [XmlText(reversedClientId)]),
      ]),
    ]),
  ]);
  final cFBundleURLTypesKey = dict().children.firstWhere((e) => e.text == 'CFBundleURLTypes', orElse: () => null);
  if (cFBundleURLTypesKey == null) {
    dict().children.add(XmlElement(XmlName('key'), [], [XmlText('CFBundleURLTypes')]));
    dict().children.add(cFBundleURLTypesElement);
  } else {
    dict().children[dict().children.indexOf(facebookDisplayNameKey) + 1] = cFBundleURLTypesElement;
  }

  final String newContent = xml.toXmlString(pretty: true);
  file.writeAsStringSync(newContent);
}
