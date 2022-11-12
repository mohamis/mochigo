import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:flutter_cart/model/cart_model.dart';
import 'package:flutter_cart/model/cart_response_wrapper.dart';

class CartProvider extends ChangeNotifier {
  FlutterCart flutterCart = FlutterCart();
  late CartResponseWrapper cartResponseWrapper;
  void addToCart({
    int funcQuantity = 0,
    required String name,
    required String description,
    required String id,
    required double price,
  }) async {
    cartResponseWrapper = flutterCart.addToCart(
      productId: id,
      unitPrice: price,
      productName: name,
      quantity: funcQuantity == 0 ? 1 : funcQuantity,
      productDetailsObject: description,
    );
    notifyListeners();
  }

  bool cartIsEmpty() {
    return flutterCart.cartItem.isEmpty;
  }

  void deleteItemFromCart(int index) async {
    cartResponseWrapper = flutterCart.deleteItemFromCart(index);
    notifyListeners();
  }

  void decrementItemFromCartProvider(int index) async {
    cartResponseWrapper = flutterCart.decrementItemFromCart(index);
    notifyListeners();
  }

  void incrementItemToCartProvider(int index) async {
    cartResponseWrapper = flutterCart.incrementItemToCart(index);
    notifyListeners();
  }

  int? findItemIndexFromCartProvider(dynamic cartId) {
    final int? index = flutterCart.findItemIndexFromCart(cartId);
    return index;
  }

  //show already added items with their quantity on servicelistdetail screen
  CartItem? getSpecificItemFromCartProvider(dynamic id) {
    final CartItem? cartItem = flutterCart.getSpecificItemFromCart(id);

    if (cartItem != null) {
      return cartItem;
    }
    return cartItem;
  }

  double getTotalAmount() {
    return flutterCart.getTotalAmount();
  }

  List<CartItem> getCartItems() {
    return flutterCart.cartItem;
  }

  void deleteAllCartProvider() {
    flutterCart.deleteAllCart();
  }
}
