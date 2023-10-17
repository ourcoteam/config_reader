import 'dart:io';

Future<void> changeGradleProperties() async {
  final file = File('android/gradle/wrapper/gradle-wrapper.properties');
  if (file.existsSync() == false) {
    file.createSync();
  }

  file.writeAsStringSync('''
distributionBase=GRADLE_USER_HOME
distributionPath=wrapper/dists
zipStoreBase=GRADLE_USER_HOME
zipStorePath=wrapper/dists
distributionUrl=https://services.gradle.org/distributions/gradle-7.5-all.zip
''');
}
