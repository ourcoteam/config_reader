library plist;

import 'dart:convert';
import 'dart:typed_data';

import 'package:xml/xml.dart';

/// Takes a xml string of Property list.
/// Will in most praticaly situation return an Map.
/// Coverts property list types to these dart types:
///
/// * <string> to [String].
/// * <real> to [double].
/// * <integer> to [int].
/// * <true> to true.
/// * <false> to false.
/// * <date> to [DateTime].
/// * <data> to [Uint8List].
/// * <array> to [List].
/// * <dict> to [Map].
Object parseXml(String xml) {
  var doc = XmlDocument.parse(xml);
  return _handleElem(
      doc.rootElement.children.where(_isElemet).first as XmlElement);
}

_handleElem(XmlElement elem) {
  switch (elem.name.local) {
    case 'string':
      return elem.text;
    case 'real':
      return double.parse(elem.text);
    case 'integer':
      return int.parse(elem.text);
    case 'true':
      return true;
    case 'false':
      return false;
    case 'date':
      return DateTime.parse(elem.text);
    case 'data':
      return new Uint8List.fromList(base64Decode(elem.text));
    case 'array':
      return elem.children
          .where(_isElemet)
          .map((e) => _handleElem(e as XmlElement))
          .toList();
    case 'dict':
      return _handleDict(elem);
  }
}

Map _handleDict(XmlElement elem) {
  var children = elem.children.where(_isElemet);
  var key = children
      .where((XmlNode elem) => (elem as XmlElement).name.local == 'key')
      .map((elem) => elem.text);
  var values = children
      .where((elem) => (elem as XmlElement).name.local != 'key')
      .map((e) => _handleElem(e as XmlElement));
  return new Map.fromIterables(key, values);
}

bool _isElemet(XmlNode node) => node is XmlElement;
