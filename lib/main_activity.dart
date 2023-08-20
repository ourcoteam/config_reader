import 'dart:io';

Future fixMainActivityPackageName(String bundle) async {
  String bundlePath;
  if (bundle.contains('.')) {
    bundlePath = bundle.split('.').join('/');
  } else {
    bundlePath = '$bundle';
  }
  final file = File('android/app/src/main/kotlin/$bundlePath/MainActivity.kt');
  if (await file.exists()) {
    final content = [...await file.readAsLines()];
    if (content.isNotEmpty) {
      final package = content.first;
      if (package.isNotEmpty && package.startsWith('package ')) {
        final bundle = package.replaceFirst('package ', '');
        if (bundle.isNotEmpty && bundle.contains('.')) {
          final parts = [...bundle.split('.')];
          for (int i = 0; i < parts.length; i++) {
            final part = parts[i];
            if (part == 'in') {
              parts[i] = r'`in`';
            }
          }
          print(parts);
          final newBundle = parts.join('.');
          print(newBundle);
          final newPackage = 'package $newBundle';
          print(newPackage);
          content[0] = newPackage;
          print(content[0]);
          await file.writeAsString(content.join('\n'));
        }
      }
    }
  }
}
