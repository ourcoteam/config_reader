import 'package:config_reader/init.dart';

void main(List<String> args) {
  print('v.1.0.3');

  init(
    addToGit: !args.any((e) => e == '--no-git'),
  );
}
