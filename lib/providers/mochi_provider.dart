// ignore_for_file: always_specify_types

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mochigo/core/models/mochi_model.dart';
import 'package:mochigo/providers/storage_service.dart';

class MochiProvider extends GetxController {
  Future<void> addMochiForSell(MochiModel mochiModel, List<File> files) async {
    try {
      final CollectionReference reference =
          FirebaseFirestore.instance.collection(mochiModel.category);

      await reference
          .add(mochiModel.toJson(mochiModel))
          .then((DocumentReference<Object?> value) {
        final StorageService service = StorageService();
        service.uploadFiles(files, value.id).then((List<String> list) {
          print(list);
          reference.doc(value.id).update({'images': list, 'id': value.id});
        });
      });

      // reference.
    } catch (PlatFormException) {
      print(PlatFormException.toString());
    }
  }

  // Future<List<PetModel>> getPetFromCategory(String category) async {
  //   try {
  //     List<PetModel> petList = [];
  //     DocumentSnapshot snapshot = await _petCollection.doc(category).get();
  //     // QuerySnapshot snap = snapshot.data() as QuerySnapshot;

  //   } catch (PlatFormExceptio) {
  //     print(PlatFormExceptio.toString());
  //   }
  // }
}
