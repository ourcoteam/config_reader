library config_reader;

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

Future<Map<String, dynamic>> getStaticConfig() async {
  final file = File('assets/static_config.json');
  if (file.existsSync() == false) {
    throw 'no static_config.json found';
  }
  final staticConfigContent = file.readAsStringSync();
  final staticConfigJson = jsonDecode(staticConfigContent) as Map<String,dynamic>;

  return staticConfigJson;
}

Future<Map<String, dynamic>> getConfig(Map<String,dynamic> staticConfigJson) async {
  String url;
  if (staticConfigJson?.containsKey('serviceUrl') ?? false) {
    url = staticConfigJson['serviceUrl'];
  } else if (staticConfigJson?.containsKey('baseUrl') ?? false) {
    url = staticConfigJson['baseUrl'];
  }
  if(url == null){
    throw 'no serviceUrl or baseUrl found';
  }

  if (staticConfigJson?.containsKey('configApi') ?? false) {
    url += staticConfigJson['configApi'];
  }

  print('fetching config from $url');

  final response = await get(url);
  final responseString = response.body;
  final responseJson = jsonDecode(responseString) as Map<String, dynamic>;

  return responseJson;
}
