import 'package:get/get.dart';
import 'package:mochigo/providers/login_provider.dart';
import 'package:mochigo/providers/mochi_provider.dart';
import 'package:mochigo/providers/user_provider.dart';

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
