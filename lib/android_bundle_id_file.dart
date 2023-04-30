import 'dart:io';

Future androidBundleIDFile(String id)async{
  final file = File('android/android_bundle_id');
  final exists = await file.exists();
  if(!exists){
    await file.create();
  }
  await file.writeAsString(id);
}