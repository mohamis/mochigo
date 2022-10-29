// ignore_for_file: always_specify_types, non_constant_identifier_names

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
//  as storage_service;

class StorageService {
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<List<String>> uploadFiles(List<File> files, String id) async {
    final List<String> allUrl = [];
    String current;

    files.forEach((File file) async {
      final int index = files.indexOf(file);
      print(index);
      current = await uploadSingleFile(file, id, index);
      allUrl.add(current);
    });

    print(allUrl);
    return allUrl;
  }

  Future<String> uploadSingleFile(File file, String id, int index) async {
    try {
      print(file);
      print("*********");
      final Reference reference = storage
          .ref()
          .child('mochi images')
          .child(id)
          .child(id + "_" + index.toString());

      final UploadTask uploadTask = reference.putFile(file);

      final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

      final String url = await taskSnapshot.ref.getDownloadURL();

      return url;
    } catch (PlatFormException) {
      print(PlatFormException.toString());
      return 'Problem while uploading';
    }
  }
}
