// ignore_for_file: always_specify_types

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mochigo/core/models/mochi_model.dart';
import 'package:mochigo/services/storage_service.dart';

class MochiProvider extends GetxController {
  Future<void> addMochiForSell(MochiModel mochiModel, File files) async {
    try {
      final CollectionReference reference =
          FirebaseFirestore.instance.collection(mochiModel.category);

      await reference
          .add(mochiModel.toJson(mochiModel))
          .then((DocumentReference<Object?> value) {
        final StorageService service = StorageService();
        service.uploadSingleFile(files, value.id, 0).then((String list) {
          reference.doc(value.id).update({'images': list, 'id': value.id});
        });
      });

      // reference.
    } catch (platFormException) {
      Get.snackbar(
        'An error occurred when adding mochi to the database!',
        platFormException.toString(),
      );
    }
  }

  Future<List> getMochisFromCategory(String category) async {
    final snapshot =
        await FirebaseFirestore.instance.collection(category).get();
    return snapshot.docs;
  }
}