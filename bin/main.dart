import 'package:config_reader/init.dart';

void main(List<String> args) {
  print('v.1.0.73');

  if (args.any((e) => e == '--v')) {
    return;
  }

  init(
    local: args.any((e) => e == '--local'),
    localConfig: args.any((e) => e == '--local-config'),
    addToGit: !args.any((e) => e == '--no-git'),
    incrementIOS: args.any((e) => e == '--inc' || e == '--inc-ios'),
    incrementAndroid: args.any((e) => e == '--inc' || e == '--inc-android'),
  );
}
