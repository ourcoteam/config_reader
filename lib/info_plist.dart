import 'dart:io';

import 'package:config_reader/utils/utils.dart';
import 'package:xml/xml.dart';

Future<void> infoPlist({
  String version,
  String bundle,
  String facebookName,
  String facebookId,
  String reversedClientId,
  String adMobId,
  String nSUserTrackingUsageDescription,
}) async {
  final file = File('ios/Runner/Info.plist');
  if (file.existsSync() == false) {
    file.createSync();
  }

  final content = file.readAsStringSync();
  final xml = XmlDocument.parse(content);

  XmlElement plist() => xml.getElement('plist');
  XmlElement dict() => plist().getElement('dict');

  final gADApplicationIdentifierElement = XmlElement(XmlName('string'), [], [XmlText(adMobId)]);
  final gADApplicationIdentifierKey = dict().children.firstWhere((e) => e.text == 'GADApplicationIdentifier', orElse: () => null);
  if (gADApplicationIdentifierKey == null) {
    dict().children.add(XmlElement(XmlName('key'), [], [XmlText('GADApplicationIdentifier')]));
    dict().children.add(gADApplicationIdentifierElement);
  } else {
    dict().children[dict().children.indexOf(gADApplicationIdentifierKey) + 1] = gADApplicationIdentifierElement;
  }

  final sKAdNetworkItemsElement = XmlElement(XmlName('array'), [], [
    XmlElement(XmlName('dict'), [], [
      XmlElement(XmlName('key'), [], [XmlText('SKAdNetworkIdentifier')]),
      XmlElement(XmlName('string'), [], [XmlText('cstr6suwn9.skadnetwork')]),
    ]),
  ]);
  final sKAdNetworkItemsKey = dict().children.firstWhere((e) => e.text == 'SKAdNetworkItems', orElse: () => null);
  if (sKAdNetworkItemsKey == null) {
    dict().children.add(XmlElement(XmlName('key'), [], [XmlText('SKAdNetworkItems')]));
    dict().children.add(sKAdNetworkItemsElement);
  } else {
    dict().children.removeAt(dict().children.indexOf(sKAdNetworkItemsKey) + 1);
    dict().children[dict().children.indexOf(sKAdNetworkItemsKey) + 1] = sKAdNetworkItemsElement;
  }

  if (version != null) {
    final cfBundleShortVersionStringElement = XmlElement(XmlName('string'), [], [XmlText(version)]);
    final cfBundleShortVersionStringKey = dict().children.firstWhere((e) => e.text == 'CFBundleShortVersionString', orElse: () => null);
    if (cfBundleShortVersionStringKey == null) {
      dict().children.add(XmlElement(XmlName('key'), [], [XmlText('CFBundleShortVersionString')]));
      dict().children.add(cfBundleShortVersionStringElement);
    } else {
      dict().children.removeAt(dict().children.indexOf(cfBundleShortVersionStringKey) + 1);
      dict().children[dict().children.indexOf(cfBundleShortVersionStringKey) + 1] = cfBundleShortVersionStringElement;
    }
  }

  final cFBundleIdentifierElement = XmlElement(XmlName('string'), [], [XmlText(bundle)]);
  final cFBundleIdentifierKey = dict().children.firstWhere((e) => e.text == 'CFBundleIdentifier', orElse: () => null);
  if (cFBundleIdentifierKey == null) {
    dict().children.add(XmlElement(XmlName('key'), [], [XmlText('CFBundleIdentifier')]));
    dict().children.add(cFBundleIdentifierElement);
  } else {
    dict().children.removeAt(dict().children.indexOf(cFBundleIdentifierKey) + 1);
    dict().children[dict().children.indexOf(cFBundleIdentifierKey) + 1] = cFBundleIdentifierElement;
  }

  final facebookAppIDKey = dict().children.firstWhere((e) => e.text == 'FacebookAppID', orElse: () => null);
  final facebookDisplayNameKey = dict().children.firstWhere((e) => e.text == 'FacebookDisplayName', orElse: () => null);
  if (stringNotNullOrEmpty(facebookId) && stringNotNullOrEmpty(facebookName)) {
    final facebookAppIDElement = XmlElement(XmlName('string'), [], [XmlText(facebookId)]);
    if (facebookAppIDKey == null) {
      dict().children.add(XmlElement(XmlName('key'), [], [XmlText('FacebookAppID')]));
      dict().children.add(facebookAppIDElement);
    } else {
      dict().children.removeAt(dict().children.indexOf(facebookAppIDKey) + 1);
      dict().children[dict().children.indexOf(facebookAppIDKey) + 1] = facebookAppIDElement;
    }

    final facebookDisplayNameElement = XmlElement(XmlName('string'), [], [XmlText(facebookName)]);
    if (facebookDisplayNameKey == null) {
      dict().children.add(XmlElement(XmlName('key'), [], [XmlText('FacebookDisplayName')]));
      dict().children.add(facebookDisplayNameElement);
    } else {
      dict().children.removeAt(dict().children.indexOf(facebookDisplayNameKey) + 1);
      dict().children[dict().children.indexOf(facebookDisplayNameKey) + 1] = facebookDisplayNameElement;
    }
  } else {
    if (facebookAppIDKey != null) {
      final index = dict().children.indexOf(facebookAppIDKey);
      dict().children.removeAt(index);
      dict().children.removeAt(index + 1);
    }
    if (facebookDisplayNameKey != null) {
      final index = dict().children.indexOf(facebookDisplayNameKey);
      dict().children.removeAt(index);
      dict().children.removeAt(index + 1);
    }
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
    dict().children.removeAt(dict().children.indexOf(lSApplicationQueriesSchemesKey) + 1);
    dict().children[dict().children.indexOf(lSApplicationQueriesSchemesKey) + 1] = lSApplicationQueriesSchemesElement;
  }

  final cFBundleURLTypesElement = XmlElement(XmlName('array'), [], [
    if (stringNotNullOrEmpty(facebookId))
      XmlElement(XmlName('dict'), [], [
        XmlElement(XmlName('key'), [], [XmlText('CFBundleURLSchemes')]),
        XmlElement(XmlName('array'), [], [
          XmlElement(XmlName('string'), [], [XmlText('fb$facebookId')]),
        ]),
      ]),
    if (reversedClientId != null)
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
    dict().children.removeAt(dict().children.indexOf(cFBundleURLTypesKey) + 1);
    dict().children[dict().children.indexOf(cFBundleURLTypesKey) + 1] = cFBundleURLTypesElement;
  }

  final nSUserTrackingUsageDescriptionElement = XmlElement(XmlName('string'), [], [XmlText(nSUserTrackingUsageDescription)]);
  final nSUserTrackingUsageDescriptionKey = dict().children.firstWhere((e) => e.text == 'NSUserTrackingUsageDescription', orElse: () => null);
  if (nSUserTrackingUsageDescriptionKey == null) {
    dict().children.add(XmlElement(XmlName('key'), [], [XmlText('NSUserTrackingUsageDescription')]));
    dict().children.add(nSUserTrackingUsageDescriptionElement);
  } else {
    dict().children.removeAt(dict().children.indexOf(nSUserTrackingUsageDescriptionKey) + 1);
    dict().children[dict().children.indexOf(nSUserTrackingUsageDescriptionKey) + 1] = nSUserTrackingUsageDescriptionElement;
  }

  final String newContent = xml.toXmlString(pretty: true);
  file.writeAsStringSync(newContent);
}
