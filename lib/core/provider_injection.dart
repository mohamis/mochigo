import 'package:get/get.dart';
import 'package:mochigo/controller/login_controller.dart';
import 'package:mochigo/controller/mochi_controller.dart';
import 'package:mochigo/controller/user_controller.dart';

void initProvider() {
  //login provider
  // ignore: unused_local_variable
  final LoginProvider loginProvider = Get.put(LoginProvider());

  //User provider injection
  // ignore: unused_local_variable
  final UserProvider userProvider = Get.put(UserProvider());

  //Mochi provider
  // ignore: unused_local_variable
  final MochiProvider mochiProvider = Get.put(MochiProvider());
}
