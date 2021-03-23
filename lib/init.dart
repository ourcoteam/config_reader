import 'package:config_reader/pubspec.dart';
import 'package:config_reader/strings_xml.dart';
import 'package:process_run/shell_run.dart';

import 'android_manifest.dart';
import 'config_reader.dart';
import 'download_images.dart';
import 'flutter_launcher_icons.dart';
import 'flutter_launcher_name.dart';
import 'flutter_native_splash.dart';
import 'gitIgnore.dart';
import 'google_services_plist.dart';
import 'info_plist.dart';
import 'utils.dart';

Future<void> init() async {
  final staticConfig = await getStaticConfig();
  final config = await getConfig(staticConfig);

  final facebookId = config.getMap('socialLogin')?.getMap('facebook')?.get('id') ?? 'FACE_ID';
  final facebookName = config.getMap('socialLogin')?.getMap('facebook')?.get('name') ?? 'FACE_NAME';
  final appName = config.getMap('app')?.get('appName') ?? staticConfig.get('appName');
  final appBundleAndroid = staticConfig.get('appIdAndroid');
  // final appBundleIOS = staticConfig.get('appIdIOS');
  final baseUrl = config.get('baseUrl') ?? staticConfig.get('serviceUrl') ?? staticConfig.get('baseUrl');

  final adMobIdAndroid = config.getMap('adMob')?.get('androidID') ?? 'GAD_Android';
  final adMobIdIOS = config.getMap('adMob')?.get('IosID') ?? 'GAD_IOS';

  final splashColor = config.getMap('splash')?.get('color') ?? '';
  final splashUrl = config.getMap('splash')?.get('image') ?? '';

  final iconUrl = config.getMap('app')?.get('appIcon') ?? '';

  await downloadImages(
    splashUrl: splashUrl,
    iconUrl: iconUrl,
  );

  // await createSplash('FF0000');
  // await createIconsFromArguments([]);

  // await changeGradle(staticConfig['appIdAndroid']);
  // await changePackageName(staticConfig['appIdAndroid']);
  // await debugAndroidManifest(staticConfig['appIdAndroid']);
  // await profileAndroidManifest(staticConfig['appIdAndroid']);

  await androidManifest(
    bundle: appBundleAndroid,
    name: appName,
    adMobId: adMobIdAndroid,
    siteUrl: baseUrl,
  );

  await infoPlist(
    name: appName,
    adMobId: adMobIdIOS,
    facebookId: facebookId,
    facebookName: facebookName,
    reversedClientId: await getReversedClientId(),
  );

  await parseFacebook(
    facebookId: facebookId,
    facebookName: facebookName,
  );

  await changePubspec();

  await flutterLauncherIcons();
  await flutterLauncherName(appName);
  await flutterNativeSplash(splashColor);

  final clean = 'flutter clean';
  final pubGet = 'flutter pub get';
  final splash = 'flutter pub pub run flutter_native_splash:create';
  final icons = 'flutter pub run flutter_launcher_icons:main';
  final name = 'flutter pub run custom_flutter_launcher_name:main';
  final bundle = 'flutter pub run change_app_package_name:main $appBundleAndroid';
  final gitAdd = 'git add .';

  final shell = Shell();

  await shell.run([
    clean,
    pubGet,
    bundle,
    splash,
    icons,
    name,
  ].join(' && '));

  await commentGitIgnore();
  await shell.run(gitAdd);
  await commentGitIgnore(reverse: true);
}
