import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  String? image;
  final Reference _storage = FirebaseStorage.instance.ref();
  Future<String> uploadJobImage(File file) async {
    image = const Uuid().v4();
    UploadTask uploadImageTask =
        _storage.child("images/jobs/job_$image.jpg").putFile(file);
    TaskSnapshot snapshot = await uploadImageTask;
    String imageLink = await snapshot.ref.getDownloadURL();
    return imageLink;
  }

  Future<String> uploadProfileImage(File file) async {
    image = const Uuid().v4();
    UploadTask uploadImageTask =
        _storage.child("images/profiles/profile_$image.jpg").putFile(file);
    TaskSnapshot snapshot = await uploadImageTask;
    String imageLink = await snapshot.ref.getDownloadURL();
    return imageLink;
  }
}
