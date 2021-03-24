import 'package:config_reader/init.dart';

void main(List<String> args) {
  print('v.1.0.4');

  init(
    addToGit: !args.any((e) => e == '--no-git'),
    incrementIOS: args.any((e) => e == '--inc' || e == '--inc-ios'),
    incrementAndroid: args.any((e) => e == '--inc' || e == '--inc-android'),
  );
}
