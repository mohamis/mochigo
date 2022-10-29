import 'dart:async';

import 'package:get/get.dart';

class ProductController extends GetxController {
  RxBool isAddLoading = false.obs;

  void addToCart() {
    isAddLoading.value = true;
    update();
    Timer(const Duration(seconds: 2), () {
      isAddLoading.value = false;
      update();
    });
  }
}
