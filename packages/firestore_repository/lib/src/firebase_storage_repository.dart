import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FirebaseStorageRepository {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  uploadImage(String uid, File file) async {
    //  var storageRef = storage.ref().child(path)
  }
}
