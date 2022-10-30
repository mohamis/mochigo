import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mochigo/presentation/order_screen.dart';
import 'package:mochigo/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class MyCart extends StatelessWidget {
  const MyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: const Color.fromARGB(255, 255, 211, 245),
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: _CartList(),
            ),
          ),
          const Divider(height: 4, color: Colors.black),
          _CartTotal()
        ],
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextStyle? itemNameStyle = Theme.of(context).textTheme.headline6;
    // This gets the current state of CartModel and also tells Flutter
    // to rebuild this widget when CartModel notifies listeners (in other words,
    // when it changes).
    // var cart = context.watch<CartModel>();
    final CartProvider cartProvider = context.watch<CartProvider>();

    return ListView.builder(
      itemCount: cartProvider.flutterCart.cartItem.length,
      itemBuilder: (BuildContext context, int index) => ListTile(
        leading: IconButton(
          icon: const Icon(Icons.add_circle_outline),
          onPressed: () {
            cartProvider.incrementItemToCartProvider(index);
          },
        ),
        trailing: IconButton(
          icon: cartProvider.flutterCart.cartItem[index].quantity.toString() ==
                  "1"
              ? const Icon(Icons.delete_forever)
              : const Icon(Icons.remove_circle_outline),
          onPressed: () {
            cartProvider.decrementItemFromCartProvider(index);
          },
        ),
        title: Text(
          '${cartProvider.flutterCart.cartItem[index].quantity.toString()} x ${cartProvider.flutterCart.cartItem[index].productName.toString()} ',
          style: itemNameStyle,
        ),
        subtitle: Text(
          '\$${cartProvider.flutterCart.cartItem[index].unitPrice.toString()}',
        ),
      ),
    );
  }
}

class _CartTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextStyle hugeStyle =
        Theme.of(context).textTheme.headline1!.copyWith(fontSize: 28);

    return SizedBox(
      height: 200,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Another way to listen to a model's change is to include
            // the Consumer widget. This widget will automatically listen
            // to CartModel and rerun its builder on every change.
            //
            // The important thing is that it will not rebuild
            // the rest of the widgets in this build method.
            Consumer<CartProvider>(
              builder:
                  (BuildContext context, CartProvider cart, Widget? child) =>
                      Text(
                'TOTAL: \$${cart.getTotalAmount().toString()}',
                style: hugeStyle,
              ),
            ),

            const SizedBox(width: 24),
            TextButton(
              onPressed: () {
                // ScaffoldMessenger.of(context).showSnackBar(
                //   const SnackBar(content: Text('Buying not supported yet.')),
                // );
                Get.to(
                  () => const PaymentScreen(),
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 211, 245),
                foregroundColor: Colors.black,
              ),
              child: const Text(
                'BUY',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
