import 'dart:io';

Future<void> commentGitIgnore({reverse = false}) async {
  final file = File('.gitignore');

  final lines = file.readAsLinesSync();

  for (int i = 0; i < lines.length; i++) {
    if (lines[i].contains('#our framework')) {
      for (int j = i + 1; j < lines.length; j++) {
        if (reverse) {
          if (lines[j].startsWith('#')) {
            lines[j] = lines[j].replaceFirst('#', '');
          }
        } else {
          lines[j] = '#${lines[j]}';
        }
      }
      break;
    }
  }

  file.writeAsStringSync(lines.join('\n') + "\n");
}
