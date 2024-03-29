import 'dart:io';

Future<void> changeAndroidGradle()async{
  final file = File('android/build.gradle');
  if(file.existsSync()==false){
    file.createSync();
  }
  file.writeAsStringSync('''
buildscript {
    ext.kotlin_version = '1.6.0'
    repositories {
        google()
        jcenter()
    }

    dependencies {
classpath 'com.android.tools.build:gradle:3.6.4'
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:\$kotlin_version"
        classpath 'com.google.gms:google-services:4.3.3'
        classpath 'com.google.firebase:firebase-crashlytics-gradle:2.2.0'
    }
}

allprojects {
    repositories {
        google()
        jcenter()
    }
}

rootProject.buildDir = '../build'
subprojects {
    project.buildDir = "\${rootProject.buildDir}/\${project.name}"
}
subprojects {
    project.evaluationDependsOn(':app')
}

task clean(type: Delete) {
    delete rootProject.buildDir
}
''');
}
