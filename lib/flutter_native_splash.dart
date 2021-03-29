import 'dart:io';

Future flutterNativeSplash(String color) async {
  final file = File('flutter_native_splash.yaml');
  if (file.existsSync() == false) {
    file.createSync();
    file.writeAsStringSync(body(color ?? 'FFFFFF'));
  } else {
    if (color != null) {
      file.writeAsStringSync(body(color));
    }
  }
}

String body(String color) => '''
flutter_native_splash:
  image: assets/images/discy_splash_logo.png
  color: "$color"
  ''';
