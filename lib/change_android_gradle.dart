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
        mavenCentral()
    }

    dependencies {
classpath 'com.android.tools.build:gradle:8.10.0'
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:\$kotlin_version"
        classpath 'com.google.gms:google-services:4.3.14'
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
        mavenCentral()
    }
    subprojects {
        afterEvaluate { project ->
            if (project.hasProperty('android')) {
                project.android {
                    if (namespace == null) {
                        namespace project.group
                    }
                }
            }
             if (project.plugins.hasPlugin("com.android.application") ||
                project.plugins.hasPlugin("com.android.library")) {
            project.android {
                compileSdkVersion 35
                buildToolsVersion "35.0.0"
            }
        }
        }
    }
}

rootProject.buildDir = '../build'
subprojects {
    project.buildDir = "\${rootProject.buildDir}/\${project.name}"
}
subprojects {
    project.evaluationDependsOn(':app')
}

tasks.register("clean", Delete) {
    delete rootProject.buildDir
}
''');
}
