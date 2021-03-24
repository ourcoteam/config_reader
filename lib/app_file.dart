import 'dart:io';

Future appFile(String bundle) async {
  if (Directory('android/fastlane').existsSync() == false) {
    Directory('android/fastlane').createSync(recursive: true);
  }
  final file = File('android/fastlane/Appfile');
  if (file.existsSync() == false) {
    file.createSync();
  }
  file.writeAsStringSync('''
json_key_file("api_access.json") # Path to the json secret file - Follow https://docs.fastlane.tools/actions/supply/#setup to get one
package_name("$bundle") # e.g. com.krausefx.app    
''');
}
