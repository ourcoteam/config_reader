import 'dart:io';

Future<void> changePackageName(String bundle) async {
  final path = 'android/app/src/main/kotlin';
  final dir = Directory(path);

  if (dir.existsSync()) {
    dir.deleteSync(recursive: true);
  }

  final newPath = '$path/${bundle.split('.').join('/')}';

  Directory(newPath).createSync(recursive: true);
  final file = File(newPath);

  file.createSync();

  file.writeAsStringSync('''
package $bundle
import io.flutter.embedding.android.FlutterActivity

import android.os.Build
import android.view.ViewTreeObserver
import android.view.WindowManager
class MainActivity: FlutterActivity() {
}
  ''');
}
