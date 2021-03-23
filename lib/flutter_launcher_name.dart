import 'dart:io';

Future flutterLauncherName(String name)async{
  final file = File('custom_flutter_launcher_name.yaml');
  if(file.existsSync()){
    file.deleteSync();
  }
  file.createSync();
  file.writeAsStringSync('''
custom_flutter_launcher_name:
  name: "$name"
  ''');
}