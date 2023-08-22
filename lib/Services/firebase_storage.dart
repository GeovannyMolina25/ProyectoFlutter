import "dart:io";

import "package:firebase_storage/firebase_storage.dart";
import "package:flutter/widgets.dart";

final FirebaseStorage storage = FirebaseStorage.instance;

Future<String> uploadImage(File image) async{
  final String namefile= image.path.split("/").last;
  
  final Reference ref = storage.ref().child("images").child(namefile);
  final UploadTask uploadTask = ref.putFile(image);
  final TaskSnapshot snapshot = await uploadTask.whenComplete(() => true);
  final String url= await snapshot.ref.getDownloadURL();
  return url;
}