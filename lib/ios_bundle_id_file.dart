import 'dart:io';

Future iosBundleIDFile(String id)async{
  final file = File('ios/ios_bundle_id');
  final exists = await file.exists();
  if(!exists){
    await file.create();
  }
  await file.writeAsString(id);
}