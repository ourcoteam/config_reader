import 'dart:io';

import 'package:xml/xml.dart';

Future<void> androidManifest({String bundle, String name, String siteUrl, String adMobId}) async {
  print('putting in manifest : ${{
    'bundle': bundle,
    'name': name,
    'siteUrl': siteUrl,
    'adMobId': adMobId,
  }}');

  final path = 'android/app/src/main';

  final file = File('$path/AndroidManifest.xml');
  if (file.existsSync() == false) {
    file.createSync();
  }

  final builder = XmlBuilder();
  builder.processing('', '');

  builder.element('manifest', attributes: {
    'xmlns:android': 'http://schemas.android.com/apk/res/android',
    'xmlns:tools': 'http://schemas.android.com/tools',
    'package': bundle,
  }, nest: () {
    builder.element('uses-permission', attributes: {
      'android:name': 'android.permission.INTERNET',
    });
    builder.element('uses-permission', attributes: {
      'android:name': 'android.permission.READ_EXTERNAL_STORAGE',
    });

    builder.element('application', attributes: {
      'android:name': 'io.flutter.app.FlutterApplication',
      'android:icon': '@mipmap/ic_launcher',
      'android:label': name,
      'tools:replace': 'android:label,android:name',
    }, nest: () {
      builder.element('activity', attributes: {
        'android:name': '.MainActivity',
        'android:configChanges':
            'orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode',
        'android:hardwareAccelerated': 'true',
        'android:launchMode': 'singleTop',
        'android:theme': '@style/LaunchTheme',
        'android:windowSoftInputMode': 'adjustResize',
      }, nest: () {
        builder.element('meta-data', attributes: {
          'android:name': 'io.flutter.embedding.android.SplashScreenDrawable',
          'android:resource': '@drawable/launch_background',
        });

        builder.element('intent-filter', nest: () {
          builder.element('action', attributes: {
            'android:name': 'android.intent.action.MAIN',
          });
          builder.element('category', attributes: {
            'android:name': 'android.intent.category.LAUNCHER',
          });
        });

        builder.element('intent-filter', nest: () {
          builder.element('action', attributes: {
            'android:name': 'FLUTTER_NOTIFICATION_CLICK',
          });
          builder.element('category', attributes: {
            'android:name': 'android.intent.category.DEFAULT',
          });
        });

        builder.element('intent-filter', nest: () {
          builder.element('action', attributes: {
            'android:name': 'android.intent.action.VIEW',
          });
          builder.element('category', attributes: {
            'android:name': 'android.intent.category.DEFAULT',
          });
          builder.element('category', attributes: {
            'android:name': 'android.intent.category.BROWSABLE',
          });
          builder.element('data', attributes: {
            'android:host': bundle,
            'android:scheme': name.toLowerCase(),
          });
        });

        builder.element('intent-filter', nest: () {
          builder.element('action', attributes: {
            'android:name': 'android.intent.action.VIEW',
          });
          builder.element('category', attributes: {
            'android:name': 'android.intent.category.DEFAULT',
          });
          builder.element('category', attributes: {
            'android:name': 'android.intent.category.BROWSABLE',
          });
          if (siteUrl != null) {
            builder.element('data', attributes: {
              'android:host': Uri.parse(siteUrl).host,
              'android:scheme': 'https',
            });
          }
        });
      });

      builder.element('meta-data', attributes: {
        'android:name': 'flutterEmbedding',
        'android:value': '2',
      });

      if (adMobId != null) {
        builder.element('meta-data', attributes: {
          'android:name': 'com.google.android.gms.ads.APPLICATION_ID',
          'android:value': adMobId,
        });
      }

      builder.element('provider', attributes: {
        'android:name': 'androidx.core.content.FileProvider',
        'android:authorities': r'${applicationId}.provider',
        'android:exported': 'false',
        'android:grantUriPermissions': 'true',
      }, nest: () {
        builder.element('meta-data', attributes: {
          'android:name': 'android.support.FILE_PROVIDER_PATHS',
          'android:resource': '@xml/provider_paths',
        });
      });

      builder.element('meta-data', attributes: {
        'android:name': 'com.facebook.sdk.ApplicationId',
        'android:value': '@string/facebook_app_id',
      });

      builder.element('activity', attributes: {
        'android:name': 'com.facebook.sdk.ApplicationId',
        'android:configChanges': 'keyboard|keyboardHidden|screenLayout|screenSize|orientation',
        'android:label': '@string/app_name',
      });

      builder.element('activity', attributes: {
        'android:name': 'com.facebook.CustomTabActivity',
        'android:exported': 'true',
      }, nest: () {
        builder.element('intent-filter', nest: () {
          builder.element('action', attributes: {
            'android:name': 'android.intent.action.VIEW',
          });
          builder.element('category', attributes: {
            'android:name': 'android.intent.category.DEFAULT',
          });
          builder.element('category', attributes: {
            'android:name': 'android.intent.category.BROWSABLE',
          });
          builder.element('data', attributes: {
            'android:scheme': '@string/fb_login_protocol_scheme',
          });
        });
      });
    });
  });

  final doc = builder.buildDocument();
  String content = doc.toXmlString(pretty: true);

  if (content.contains('<??>')) {
    content = content.replaceFirst('<??>', '');
  }

  file.writeAsStringSync(content);
}

Future<void> debugAndroidManifest(String bundle)async{
  final file = File('android/app/src/debug/AndroidManifest.xml');
  if (file.existsSync()==false) {

  }
  file.writeAsStringSync('''
<manifest
    xmlns:android="http://schemas.android.com/apk/res/android"
    package="$bundle"
    >
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
</manifest>
  ''');
}

Future<void> profileAndroidManifest(String bundle)async{
  final file = File('android/app/src/profile/AndroidManifest.xml');
  if (file.existsSync()==false) {

  }
  file.writeAsStringSync('''
<manifest
    xmlns:android="http://schemas.android.com/apk/res/android"
    package="$bundle"
    >
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
</manifest>
  ''');
}
