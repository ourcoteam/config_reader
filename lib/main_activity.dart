import 'dart:io';

fixMainActivityPackageName() async {
  final file = File('android/app/src/main/kotlin/discy/main/MainActivity.kt');
  if (file.existsSync()) {
    final content = [...file.readAsLinesSync()];
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
          final newBundle = parts.join('.');
          final newPackage = 'package $newBundle';
          content[0] = newPackage;
          file.writeAsStringSync(content.join('\n'));
        }
      }
    }
  }
}
