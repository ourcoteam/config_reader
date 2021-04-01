import 'dart:io';

import 'package:xml/xml.dart';

Future<void> androidManifest({
  String bundle,
  String baseUrl,
  String name,
}) async {
  final path = 'android/app/src/main';

  final file = File('$path/AndroidManifest.xml');
  if (file.existsSync() == false) {
    file.createSync();
  }

  String notiIcon = '';

  final notiFile = File('android/app/src/main/res/drawable/noti_icon.png');
  final colorsFile = File('android/app/src/main/res/values/colors.xml');
  if(notiFile.existsSync() && colorsFile.readAsStringSync().contains('noti_color')){
    notiIcon = '''
<meta-data
          android:name="com.google.firebase.messaging.default_notification_icon"
          android:resource="@drawable/noti_icon"
          />
        <meta-data
          android:name="com.google.firebase.messaging.default_notification_color"
          android:resource="@color/noti_color"
          />''';
  }

  final xml = XmlDocument.parse(file.readAsStringSync());
  final man = xml.rootElement;
  final oldBundle = man.attributes.firstWhere((e) => e.name.local == 'package', orElse: () => null)?.value ?? 'null';
  final app = man.getElement('application');
  final oldName = app.attributes.firstWhere((e) => e.name.local == 'label', orElse: () => null)?.value ?? 'null';

  final prov = r'${applicationId}.provider';

  file.writeAsStringSync('''
<manifest
    xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    package="$oldBundle"
    >

    <uses-permission android:name="android.permission.INTERNET" />
    <!-- io.flutter.app.FlutterApplication is an android.app.Application that
           calls FlutterMain.startInitialization(this); in its onCreate method.
           In most cases you can leave this as-is, but you if you want to provide
           additional functionality it is fine to subclass or reimplement
           FlutterApplication and put your custom class here. -->
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />

    <application
        android:name="io.flutter.app.FlutterApplication"
        android:icon="@mipmap/ic_launcher"
        android:label="$oldName"
        tools:replace="android:label,android:name"
        >
        <activity
            android:name=".MainActivity"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:launchMode="singleTop"
            android:theme="@style/LaunchTheme"
            android:windowSoftInputMode="adjustResize"
            >
            <!-- Specifies an Android theme to apply to this Activity as soon as
                       the Android process has started. This theme is visible to the user
                       while the Flutter UI initializes. After that, this theme continues
                       to determine the Window background behind the Flutter UI. -->
            <!-- <meta-data android:name="io.flutter.embedding.android.NormalTheme" android:resource="@style/NormalTheme" /> -->
            <!-- Displays an Android View that continues showing the launch screen
                       Drawable until Flutter paints its first frame, then this splash
                       screen fades out. A splash screen is useful to avoid any visual
                       gap between the end of Android's launch screen and the painting of
                       Flutter's first frame. -->
            <meta-data
                android:name="io.flutter.embedding.android.SplashScreenDrawable"
                android:resource="@drawable/launch_background"
                />

            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
            <intent-filter>
                <action android:name="FLUTTER_NOTIFICATION_CLICK" />
                <category android:name="android.intent.category.DEFAULT" />
            </intent-filter>
            <!-- Deep Links -->
            <intent-filter>
                <action android:name="android.intent.action.VIEW" />

                <category android:name="android.intent.category.DEFAULT" />
                <category android:name="android.intent.category.BROWSABLE" />

                <data
                    android:host="app.ask.application"
                    android:scheme="appbear"
                    />
            </intent-filter>
            <!-- App Links -->
            <intent-filter>
                <action android:name="android.intent.action.VIEW" />

                <category android:name="android.intent.category.DEFAULT" />
                <category android:name="android.intent.category.BROWSABLE" />

                <data
                    android:host="appstage.tielabs.com"
                    android:scheme="https"
                    />
            </intent-filter>
        </activity>
        <!-- Don't delete the meta-data below.
                 This is used by the Flutter tool to generate GeneratedPluginRegistrant.java -->
        <meta-data
            android:name="flutterEmbedding"
            android:value="2"
            />
        <meta-data
            android:name="com.google.android.gms.ads.APPLICATION_ID"
            android:value="ca-app-pub-3102006508276410~8783578315"
            />

        <provider
            android:name="androidx.core.content.FileProvider"
            android:authorities="$prov"
            android:exported="false"
            android:grantUriPermissions="true"
            >
            <meta-data
                android:name="android.support.FILE_PROVIDER_PATHS"
                android:resource="@xml/provider_paths"
                />
        </provider>

        <meta-data
            android:name="com.facebook.sdk.ApplicationId"
            android:value="@string/facebook_app_id"
            />

        <activity
            android:name="com.facebook.FacebookActivity"
            android:configChanges="keyboard|keyboardHidden|screenLayout|screenSize|orientation"
            android:label="@string/app_name"
            />

        <activity
            android:name="com.facebook.CustomTabActivity"
            android:exported="true"
            >
            <intent-filter>
                <action android:name="android.intent.action.VIEW" />

                <category android:name="android.intent.category.DEFAULT" />
                <category android:name="android.intent.category.BROWSABLE" />

                <data android:scheme="@string/fb_login_protocol_scheme" />
            </intent-filter>
        </activity>
        
        $notiIcon

    </application>
</manifest>

''');
}

Future<void> debugAndroidManifest(String bundle) async {
  final file = File('android/app/src/debug/AndroidManifest.xml');
  if (file.existsSync() == false) {}
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

Future<void> profileAndroidManifest(String bundle) async {
  final file = File('android/app/src/profile/AndroidManifest.xml');
  if (file.existsSync() == false) {}
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

/*
final content = file.readAsStringSync();
  final xml = XmlDocument.parse(content);

  XmlElement manifest() => xml.rootElement;

  manifest().setAttribute('xmlns:tools', 'http://schemas.android.com/tools');

  XmlElement application() => manifest().getElement('application');

  application().setAttribute('tools:replace', 'android:label,android:name');

  final XmlElement faceBookMetaData = application().findElements('meta-data').firstWhere(
        (element) => element.attributes.any(
          (e) => e.name.local == 'android:name' && e.value == 'com.facebook.sdk.ApplicationId',
        ),
        orElse: () => null,
      );

  final faceBookMetaDataElement = XmlElement(
    XmlName('meta-data'),
    [
      XmlAttribute(XmlName("android:name"), "com.facebook.sdk.ApplicationId"),
      XmlAttribute(XmlName("android:value"), "@string/facebook_app_id"),
    ],
  );
  if (faceBookMetaData == null) {
    application().children.add(faceBookMetaDataElement);
  } else {
    application().children[application().children.indexOf(faceBookMetaData)] = faceBookMetaDataElement;
  }

  final XmlElement faceBookActivity = application().findElements('activity').firstWhere(
        (element) => element.attributes.any(
          (e) => e.name.local == 'android:name' && e.value == 'com.facebook.FacebookActivity',
        ),
        orElse: () => null,
      );

  final faceBookActivityElement = XmlElement(
    XmlName('activity'),
    [
      XmlAttribute(XmlName("android:name"), "com.facebook.FacebookActivity"),
      XmlAttribute(XmlName("android:configChanges"), "keyboard|keyboardHidden|screenLayout|screenSize|orientation"),
      XmlAttribute(XmlName("android:label"), "@string/app_name"),
    ],
  );
  if (faceBookActivity == null) {
    application().children.add(faceBookActivityElement);
  } else {
    application().children[application().children.indexOf(faceBookActivity)] = faceBookActivityElement;
  }

  final XmlElement faceBookTabActivity = application().findElements('activity').firstWhere(
        (element) => element.attributes.any(
          (e) => e.name.local == 'android:name' && e.value == 'com.facebook.CustomTabActivity',
        ),
        orElse: () => null,
      );

  final faceBookTabActivityElement = XmlElement(
    XmlName('activity'),
    [
      XmlAttribute(XmlName("android:name"), "com.facebook.FacebookActivity"),
      XmlAttribute(XmlName("android:exported"), "true"),
    ],
    [
      XmlElement(
        XmlName('intent-filter'),
        [],
        [
          XmlElement(
            XmlName('action'),
            [XmlAttribute(XmlName("android:name"), "android.intent.action.VIEW")],
            [],
          ),
          XmlElement(
            XmlName('category'),
            [XmlAttribute(XmlName("android:name"), "android.intent.category.DEFAULT")],
            [],
          ),
          XmlElement(
            XmlName('category'),
            [XmlAttribute(XmlName("android:name"), "android.intent.category.BROWSABLE")],
            [],
          ),
          XmlElement(
            XmlName('data'),
            [XmlAttribute(XmlName("android:scheme"), "@string/fb_login_protocol_scheme")],
            [],
          ),
        ],
      ),
    ],
  );
  if (faceBookTabActivity == null) {
    application().children.add(faceBookTabActivityElement);
  } else {
    application().children[application().children.indexOf(faceBookTabActivity)] = faceBookTabActivityElement;
  }
 */
