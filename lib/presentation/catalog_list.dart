// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/model/cart_model.dart';
import 'package:get/get.dart';
import 'package:mochigo/controller/login_controller.dart';
import 'package:mochigo/core/theme/mochigo_theme.dart';
import 'package:mochigo/presentation/mochi_details_screen.dart';
import 'package:mochigo/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class MyCatalog extends StatelessWidget {
  MyCatalog({
    super.key,
    required this.streamSnapshot,
  });

  final AsyncSnapshot<QuerySnapshot> streamSnapshot;
  final LoginProvider loginProvider = Get.find<LoginProvider>();

  @override
  Widget build(BuildContext context) {
    final TextStyle? textTheme = Theme.of(context).textTheme.headline6;

    return ListView.builder(
      itemCount: streamSnapshot.data?.docs.length,
      itemBuilder: (BuildContext ctx, int index) => Container(
        height: 180,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2.0,
            color: const Color.fromARGB(255, 255, 211, 245),
          ),
          borderRadius: BorderRadius.circular(10),
          color: MochigoTheme.PRIMARY_COLOR,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.all(7),
                height: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    streamSnapshot.data?.docs[index].get('images'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            // Spacer(),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.only(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            streamSnapshot.data?.docs[index].get('name'),
                            style: textTheme!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ],
                    ),
                    Flexible(
                      child: Text(
                        streamSnapshot.data?.docs[index].get('description'),
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => Get.to(
                        () => MochiDetailsScreen(
                          id: streamSnapshot.data?.docs[index].get('id'),
                          title: streamSnapshot.data?.docs[index].get('name'),
                          description: streamSnapshot.data?.docs[index]
                              .get('description'),
                          image: streamSnapshot.data?.docs[index].get('images'),
                          price: streamSnapshot.data?.docs[index].get('price'),
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 255, 216, 216),
                        ),
                      ),
                      child: Text(
                        "Product Details",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (loginProvider.userData.userType.compareTo('admin') == 0)
              const SizedBox(
                height: 30,
              )
            else
              Consumer<CartProvider>(
                builder:
                    (BuildContext context, CartProvider cart, Widget? child) {
                  return _AddButton(
                    id: streamSnapshot.data?.docs[index].get('id'),
                    price: streamSnapshot.data?.docs[index].get('price'),
                    title: streamSnapshot.data?.docs[index].get('name'),
                    description:
                        streamSnapshot.data?.docs[index].get('description'),
                    image: '',
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}

class _AddButton extends StatefulWidget {
  const _AddButton({
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.id,
    Key? key,
  }) : super(key: key);
  final String title;
  final double price;
  final String description;
  final String image;
  final String id;

  @override
  __AddButtonState createState() => __AddButtonState();
}

class __AddButtonState extends State<_AddButton> {
  late CartProvider _cartProvider;
  late CartItem? _cartItem;
  late int _isInCart;

  @override
  void initState() {
    _cartProvider = Provider.of<CartProvider>(context, listen: false);
    super.initState();
  }

  int _checkItemisInCart() {
    _cartItem = _cartProvider.getSpecificItemFromCartProvider(widget.id);
    return _cartItem?.quantity ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    // The context.select() method will let you listen to changes to
    // a *part* of a model. You define a function that "selects" (i.e. returns)
    // the part you're interested in, and the provider package will not rebuild
    // this widget unless that particular part of the model changes.
    //
    // This can lead to significant performance improvements.

    _isInCart = _checkItemisInCart();

    /* return Row(
      children: [
        _itemCount != 0
            ? new IconButton(
                icon: new Icon(Icons.remove),
                onPressed: () {
                  setState(() {
                    _cartProvider.decrementItemFromCartProvider(
                        _cartItem!.itemCartIndex);
                    _itemCount--;
                  });
                },
              )
            : new Container(),
        new Text(_itemCount.toString()),
        new IconButton(
            icon: new Icon(Icons.add),
            onPressed: () {
              setState(() {
                _cartProvider
                    .incrementItemToCartProvider(_cartItem!.itemCartIndex);
                _itemCount++;
              });
            })
      ],
    ); */

    return TextButton(
      onPressed: _isInCart != 0
          ? null
          : () {
              // If the item is not in cart, we let the user add it.
              // We are using context.read() here because the callback
              // is executed whenever the user taps the button. In other
              // words, it is executed outside the build method.
              /*    var cart = context.read<CartModel>();
              cart.add(item); */
              _cartProvider.addToCart(
                funcQuantity: 1,
                id: widget.id,
                price: widget.price,
                name: widget.title,
                description: widget.description,
              );
            },
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
            return Theme.of(context).primaryColor;
          }
          return null; // Defer to the widget's default.
        }),
      ),
      child: _isInCart != 0
          ? const Icon(
              Icons.check,
              semanticLabel: 'ADDED',
              color: Color.fromARGB(255, 255, 211, 245),
            )
          : const Icon(
              Icons.add_shopping_cart,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
    );
  }
}
