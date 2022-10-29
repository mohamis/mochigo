// ignore_for_file: always_specify_types, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mochigo/core/models/user_model.dart';

class UserProvider extends GetxController {
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('user');

//adding new userData to firebase
  Future<void> addUser(UserModel userModel) async {
    try {
      await _userCollection.doc(userModel.userId).get()
          //
          .then((DocumentSnapshot snapshot) async {
        //
        if (!snapshot.exists) {
          await _userCollection
              .doc(userModel.userId)
              .set(userModel.toJson(userModel));
        }
        //
      });
      //

    } catch (PlatformException) {
      Get.snackbar('Error', PlatformException.toString());
    }
  }

  Future<void> findUserType(String email) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('user')
          .where('email', isEqualTo: email)
          .get();
      return snapshot.docs[0].data()['userType'];
    } catch (PlatformException) {
      Get.snackbar('Error', PlatformException.toString());
    }
  }
}
