import 'dart:io';

import 'package:config_reader/utils/utils.dart';
import 'package:xml/xml.dart';
import 'package:collection/collection.dart';

Future<void> infoPlist({
  String? version,
  String? bundle,
  String? facebookName,
  String? facebookId,
  String? reversedClientId,
  String? adMobId,
  String? nSUserTrackingUsageDescription,
  String? deeplink,
}) async {
  final file = File('ios/Runner/Info.plist');
  if (file.existsSync() == false) {
    file.createSync();
  }

  final content = file.readAsStringSync();
  final xml = XmlDocument.parse(content);

  XmlElement? plist() => xml.getElement('plist');
  XmlElement? dict() => plist()?.getElement('dict');

  final gADApplicationIdentifierElement =
      XmlElement(XmlName('string'), [], [XmlText(adMobId ?? "")]);
  final gADApplicationIdentifierKey = dict()?.children.firstWhereOrNull(
        (e) => e.text == 'GADApplicationIdentifier',
      );
  if (gADApplicationIdentifierKey == null) {
    dict()?.children.add(
        XmlElement(XmlName('key'), [], [XmlText('GADApplicationIdentifier')]));
    dict()?.children.add(gADApplicationIdentifierElement);
  } else {
    dict()?.children.removeAt(
        (dict()?.children.indexOf(gADApplicationIdentifierKey) ?? 0) + 1);

    dict()?.children[
            (dict()?.children.indexOf(gADApplicationIdentifierKey) ?? 0) + 1] =
        gADApplicationIdentifierElement;
  }

  final sKAdNetworkItemsElement = XmlElement(XmlName('array'), [], [
    XmlElement(XmlName('dict'), [], [
      XmlElement(XmlName('key'), [], [XmlText('SKAdNetworkIdentifier')]),
      XmlElement(XmlName('string'), [], [XmlText('cstr6suwn9.skadnetwork')]),
    ]),
  ]);
  final sKAdNetworkItemsKey =
      dict()?.children.firstWhereOrNull((e) => e.text == 'SKAdNetworkItems');
  if (sKAdNetworkItemsKey == null) {
    dict()
        ?.children
        .add(XmlElement(XmlName('key'), [], [XmlText('SKAdNetworkItems')]));
    dict()?.children.add(sKAdNetworkItemsElement);
  } else {
    dict()
        ?.children
        .removeAt((dict()?.children.indexOf(sKAdNetworkItemsKey) ?? 0) + 1);
    dict()?.children[(dict()?.children.indexOf(sKAdNetworkItemsKey) ?? 0) + 1] =
        sKAdNetworkItemsElement;
  }

  if (version != null) {
    final cfBundleShortVersionStringElement =
        XmlElement(XmlName('string'), [], [XmlText(version)]);
    final cfBundleShortVersionStringKey = dict()?.children.firstWhereOrNull(
          (e) => e.text == 'CFBundleShortVersionString',
        );
    if (cfBundleShortVersionStringKey == null) {
      dict()?.children.add(XmlElement(
          XmlName('key'), [], [XmlText('CFBundleShortVersionString')]));
      dict()?.children.add(cfBundleShortVersionStringElement);
    } else {
      dict()?.children.removeAt(
          (dict()?.children.indexOf(cfBundleShortVersionStringKey) ?? 0) + 1);
      dict()?.children[
          (dict()?.children.indexOf(cfBundleShortVersionStringKey) ?? 0) +
              1] = cfBundleShortVersionStringElement;
    }
  }

  final cFBundleIdentifierElement =
      XmlElement(XmlName('string'), [], [XmlText(bundle ?? "")]);
  final cFBundleIdentifierKey =
      dict()?.children.firstWhereOrNull((e) => e.text == 'CFBundleIdentifier');
  if (cFBundleIdentifierKey == null) {
    dict()
        ?.children
        .add(XmlElement(XmlName('key'), [], [XmlText('CFBundleIdentifier')]));
    dict()?.children.add(cFBundleIdentifierElement);
  } else {
    dict()
        ?.children
        .removeAt((dict()?.children.indexOf(cFBundleIdentifierKey) ?? 0) + 1);
    dict()?.children[(dict()?.children.indexOf(cFBundleIdentifierKey) ?? 0) +
        1] = cFBundleIdentifierElement;
  }

  final facebookAppIDKey = dict()?.children.firstWhereOrNull(
        (e) => e.text == 'FacebookAppID',
      );
  final facebookDisplayNameKey =
      dict()?.children.firstWhereOrNull((e) => e.text == 'FacebookDisplayName');
  if (stringNotNullOrEmpty(facebookId) && stringNotNullOrEmpty(facebookName)) {
    final facebookAppIDElement =
        XmlElement(XmlName('string'), [], [XmlText(facebookId ?? "")]);
    if (facebookAppIDKey == null) {
      dict()
          ?.children
          .add(XmlElement(XmlName('key'), [], [XmlText('FacebookAppID')]));
      dict()?.children.add(facebookAppIDElement);
    } else {
      dict()
          ?.children
          .removeAt((dict()?.children.indexOf(facebookAppIDKey) ?? 0) + 1);
      dict()?.children[(dict()?.children.indexOf(facebookAppIDKey) ?? 0) + 1] =
          facebookAppIDElement;
    }

    final facebookDisplayNameElement =
        XmlElement(XmlName('string'), [], [XmlText(facebookName ?? "")]);
    if (facebookDisplayNameKey == null) {
      dict()?.children.add(
          XmlElement(XmlName('key'), [], [XmlText('FacebookDisplayName')]));
      dict()?.children.add(facebookDisplayNameElement);
    } else {
      dict()?.children.removeAt(
          (dict()?.children.indexOf(facebookDisplayNameKey) ?? 0) + 1);
      dict()?.children[(dict()?.children.indexOf(facebookDisplayNameKey) ?? 0) +
          1] = facebookDisplayNameElement;
    }
  } else {
    if (facebookAppIDKey != null) {
      final index = dict()?.children.indexOf(facebookAppIDKey);
      if (index != null) {
        dict()?.children.removeAt(index);
        dict()?.children.removeAt(index + 1);
      }
    }
    if (facebookDisplayNameKey != null) {
      final index = dict()?.children.indexOf(facebookDisplayNameKey);
      if (index != null) {
        dict()?.children.removeAt(index);
        dict()?.children.removeAt(index + 1);
      }
    }
  }

  final lSApplicationQueriesSchemesElement = XmlElement(XmlName('array'), [], [
    XmlElement(XmlName('string'), [], [XmlText('fbapi')]),
    XmlElement(XmlName('string'), [], [XmlText('fb-messenger-share-api')]),
    XmlElement(XmlName('string'), [], [XmlText('fbauth2')]),
    XmlElement(XmlName('string'), [], [XmlText('fbshareextension')]),
  ]);
  final lSApplicationQueriesSchemesKey = dict()?.children.firstWhereOrNull(
        (e) => e.text == 'LSApplicationQueriesSchemes',
      );
  if (lSApplicationQueriesSchemesKey == null) {
    dict()?.children.add(XmlElement(
        XmlName('key'), [], [XmlText('LSApplicationQueriesSchemes')]));
    dict()?.children.add(lSApplicationQueriesSchemesElement);
  } else {
    dict()?.children.removeAt(
        (dict()?.children.indexOf(lSApplicationQueriesSchemesKey) ?? 0) + 1);
    dict()?.children[
        (dict()?.children.indexOf(lSApplicationQueriesSchemesKey) ?? 0) +
            1] = lSApplicationQueriesSchemesElement;
  }

  final cFBundleURLTypesElement = XmlElement(XmlName('array'), [], [
    XmlElement(XmlName('dict'), [], [
      XmlElement(XmlName('key'), [], [XmlText('CFBundleURLSchemes')]),
      XmlElement(XmlName('array'), [], [
        XmlElement(XmlName('string'), [], [XmlText(bundle ?? "")]),
      ]),
    ]),
    if (stringNotNullOrEmpty(facebookId))
      XmlElement(XmlName('dict'), [], [
        XmlElement(XmlName('key'), [], [XmlText('CFBundleURLSchemes')]),
        XmlElement(XmlName('array'), [], [
          XmlElement(XmlName('string'), [], [XmlText('fb$facebookId')]),
        ]),
      ]),
    if (stringNotNullOrEmpty(reversedClientId) ||
        stringNotNullOrEmpty(deeplink))
      XmlElement(XmlName('dict'), [], [
        XmlElement(XmlName('key'), [], [XmlText('CFBundleTypeRole')]),
        XmlElement(XmlName('string'), [], [XmlText('Editor')]),
        if (stringNotNullOrEmpty(deeplink))
          XmlElement(XmlName('key'), [], [XmlText('CFBundleURLName')]),
        if (stringNotNullOrEmpty(deeplink))
          XmlElement(XmlName('string'), [],
              [XmlText(Uri.parse(deeplink!).host + Uri.parse(deeplink).path)]),
        if (stringNotNullOrEmpty(reversedClientId) ||
            stringNotNullOrEmpty(deeplink))
          XmlElement(XmlName('key'), [], [XmlText('CFBundleURLSchemes')]),
        if (stringNotNullOrEmpty(reversedClientId) ||
            stringNotNullOrEmpty(deeplink))
          XmlElement(XmlName('array'), [], [
            if (stringNotNullOrEmpty(reversedClientId))
              XmlElement(XmlName('string'), [], [XmlText(reversedClientId!)]),
            if (stringNotNullOrEmpty(deeplink))
              XmlElement(XmlName('string'), [],
                  [XmlText(Uri.parse(deeplink!).scheme)]),
          ]),
      ]),
  ]);
  final cFBundleURLTypesKey =
      dict()?.children.firstWhereOrNull((e) => e.text == 'CFBundleURLTypes');
  if (cFBundleURLTypesKey == null) {
    dict()
        ?.children
        .add(XmlElement(XmlName('key'), [], [XmlText('CFBundleURLTypes')]));
    dict()?.children.add(cFBundleURLTypesElement);
  } else {
    dict()
        ?.children
        .removeAt((dict()?.children.indexOf(cFBundleURLTypesKey) ?? 0) + 1);
    dict()?.children[(dict()?.children.indexOf(cFBundleURLTypesKey) ?? 0) + 1] =
        cFBundleURLTypesElement;
  }

  final nSUserTrackingUsageDescriptionElement = XmlElement(
      XmlName('string'), [], [XmlText(nSUserTrackingUsageDescription ?? "")]);
  final nSUserTrackingUsageDescriptionKey = dict()?.children.firstWhereOrNull(
        (e) => e.text == 'NSUserTrackingUsageDescription',
      );
  if (nSUserTrackingUsageDescriptionKey == null) {
    dict()?.children.add(XmlElement(
        XmlName('key'), [], [XmlText('NSUserTrackingUsageDescription')]));
    dict()?.children.add(nSUserTrackingUsageDescriptionElement);
  } else {
    dict()?.children.removeAt(
        (dict()?.children.indexOf(nSUserTrackingUsageDescriptionKey) ?? 0) + 1);
    dict()?.children[
        (dict()?.children.indexOf(nSUserTrackingUsageDescriptionKey) ?? 0) +
            1] = nSUserTrackingUsageDescriptionElement;
  }

  final String newContent = xml.toXmlString(pretty: true);
  file.writeAsStringSync(newContent);
}
