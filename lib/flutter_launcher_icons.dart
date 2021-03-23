import 'dart:io';

Future flutterLauncherIcons()async{
  final file = File('flutter_launcher_icons.yaml');
  if(file.existsSync()){
    file.deleteSync();
  }
  file.createSync();
  file.writeAsStringSync('''
flutter_icons:
  android: true
  ios: true
  image_path: "assets/images/discy_app_icon.png"
  ''');
}