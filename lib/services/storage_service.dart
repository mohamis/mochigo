// ignore_for_file: always_specify_types, non_constant_identifier_names

import 'dart:io';
import 'dart:ui';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
//  as storage_service;

class StorageService {
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<List<String>> uploadFiles(List<File> files, String id) async {
    final List<String> allUrl = [];
    String current;

    // ignore: avoid_function_literals_in_foreach_calls
    files.forEach((File file) async {
      final int index = files.indexOf(file);
      current = await uploadSingleFile(file, id, index);
      allUrl.add(current);
    });

    return allUrl;
  }

  Future<String> uploadSingleFile(File file, String id, int index) async {
    try {
      final Reference reference =
          storage.ref().child('mochi images').child(id).child("${id}_$index");

      final UploadTask uploadTask = reference.putFile(file);

      final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

      final String url = await taskSnapshot.ref.getDownloadURL();

      return url;
    } catch (PlatFormException) {
      Get.snackbar(
        'Problem while uploading',
        PlatFormException.toString(),
        colorText: const Color.fromARGB(255, 255, 0, 0),
      );
      return 'Problem while uploading';
    }
  }
}
