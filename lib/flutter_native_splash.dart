import 'dart:io';

Future flutterNativeSplash(String color)async{
  final file = File('flutter_native_splash.yaml');
  if(file.existsSync()){
    file.deleteSync();
  }
  file.createSync();
  file.writeAsStringSync('''
flutter_native_splash:
  image: assets/images/discy_splash_logo.png
  color: "$color"
  ''');
}