import 'dart:io';

Future<void> changeGradle() async {
  final file = File('android/app/build.gradle');
  if (file.existsSync() == false) {
    file.createSync();
  }

  //get old bundle id
  final bundle =
      RegExp('applicationId "(.*)"', caseSensitive: true, multiLine: false)
          .firstMatch(file.readAsStringSync())
          ?.group(1);

  file.writeAsStringSync('''
def localProperties = new Properties()
def localPropertiesFile = rootProject.file('local.properties')
if (localPropertiesFile.exists()) {
    localPropertiesFile.withReader('UTF-8') { reader ->
        localProperties.load(reader)
    }
}

def flutterRoot = localProperties.getProperty('flutter.sdk')
if (flutterRoot == null) {
    throw new GradleException("Flutter SDK not found. Define location with flutter.sdk in the local.properties file.")
}

def flutterVersionCode = localProperties.getProperty('flutter.versionCode')
if (flutterVersionCode == null) {
    flutterVersionCode = '1'
}

def flutterVersionName = localProperties.getProperty('flutter.versionName')
if (flutterVersionName == null) {
    flutterVersionName = '1.0'
}

apply plugin: 'com.android.application'
apply plugin: 'com.google.gms.google-services'
apply plugin: 'com.google.firebase.crashlytics'
apply plugin: 'kotlin-android'
apply from: "\$flutterRoot/packages/flutter_tools/gradle/flutter.gradle"

def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    compileSdkVersion 34

    sourceSets {
        main.java.srcDirs += 'src/main/kotlin'
    }

    lintOptions {
        disable 'InvalidPackage'
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId "$bundle"
        minSdkVersion 22
        targetSdkVersion 34
        multiDexEnabled true
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
    }

    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword keystoreProperties['storePassword']
        }
    }
    
    buildTypes {
        release {
            minifyEnabled true
            shrinkResources true
            signingConfig signingConfigs.release
        }
    }
}

flutter {
    source '../..'
}

dependencies {
    implementation "androidx.multidex:multidex:2.0.1"
    implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk7:\$kotlin_version"

}
''');
}
