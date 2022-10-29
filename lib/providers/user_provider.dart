// ignore_for_file: always_specify_types, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:mochigo/core/models/user_model.dart';
import 'package:mochigo/providers/login_provider.dart';

class UserProvider extends GetxController {
  final LoginProvider _loginProvider = Get.find<LoginProvider>();

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
      print(PlatformException.toString());

      Get.snackbar('Error', PlatformException.toString());
    }
  }

  //get user location
  Future<void> getUserLocation() async {
    late bool servicesEnabled;

    final Location location = Location();

    late PermissionStatus permissionStatus;

    servicesEnabled = await location.serviceEnabled();
    if (!servicesEnabled) {
      servicesEnabled = await location.requestService();
      if (!servicesEnabled) {
        return;
      }
    }
    permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus == PermissionStatus.granted) {
        return;
      }
    }
    update();
  }
}
