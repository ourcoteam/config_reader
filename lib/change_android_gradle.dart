import 'dart:io';

Future<void> changeAndroidGradle() async {
  final file = File('android/build.gradle');
  if (file.existsSync() == false) {
    file.createSync();
  }
  file.writeAsStringSync('''
buildscript {
    ext.kotlin_version = '2.0.0'
    repositories {
        google()
        jcenter()
    }

    dependencies {
classpath 'com.android.tools.build:gradle:7.3.1'
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:\$kotlin_version"
        classpath 'com.google.gms:google-services:4.3.3'
        classpath 'com.google.firebase:firebase-crashlytics-gradle:2.2.0'
    }
}

subprojects {
  afterEvaluate { project ->
    if (project.hasProperty("android")) {
      project.android.compileSdkVersion = 35
      project.android.defaultConfig.targetSdkVersion = 35
      
      // Set Java compatibility
      project.android.compileOptions {
        sourceCompatibility JavaVersion.VERSION_11
        targetCompatibility JavaVersion.VERSION_11
      }
      
      // Set Kotlin JVM target
      project.tasks.withType(org.jetbrains.kotlin.gradle.tasks.KotlinCompile).configureEach {
        kotlinOptions {
          jvmTarget = '11'
        }
      }
    }
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
