import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageRepository {
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> uploadAvatar(String uid, File file) async {
    final String _path = '$uid/profile/avatar';
    try {
      await storage.ref().child(_path).putFile(file);
    } on FirebaseException catch (e) {
      print(e.code);
    }
  }

  Future<Uint8List?> getAvatarById(String id) async {
    final String _path = '$id/profile/avatar';
    try {
      final Uint8List? _listFile =
          await storage.ref().child(_path).getData(100000000);
      return _listFile;
    } on FirebaseException catch (e) {
      print(e.message);
    } finally {}
  }

  Future<String> getAvatarUrlById(String id) async {
    final String _path = '$id/profile/avatar';
    final String downloadURL =
        await FirebaseStorage.instance.ref(_path).getDownloadURL();
    return downloadURL;
  }

  Future<String> getAvatarPlaceholderUrl() async {
    const String _path = 'default/avatar-placeholder';
    final String downloadURL =
        await FirebaseStorage.instance.ref(_path).getDownloadURL();
    return downloadURL;
  }

  Future<Uint8List?> getAvatarPlaceholder() async {
    const String _path = 'default/avatar-placeholder ';
    try {
      final Uint8List? _listFile =
          await storage.ref().child(_path).getData(100000000);
      return _listFile;
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }
}
