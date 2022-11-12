// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mochigo/presentation/home_screen.dart';
import 'package:mochigo/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class AdminOrderPage extends StatefulWidget {
  const AdminOrderPage({
    Key? key,
    required this.title,
    required this.price,
    required this.email,
  }) : super(key: key);

  final String title;
  final double price;
  final String email;

  @override
  State<AdminOrderPage> createState() => _AdminOrderPageState();
}

Color themeColor = const Color(0xFF43D19E);

class _AdminOrderPageState extends State<AdminOrderPage> {
  double screenWidth = 600;
  double screenHeight = 400;
  Color textColor = const Color(0xFF32567A);

  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider = context.watch<CartProvider>();

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: avoid_redundant_argument_values
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 170,
              padding: EdgeInsets.all(35),
              decoration: BoxDecoration(
                color: themeColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.done_all),
            ),
            SizedBox(height: screenHeight * 0.1),
            Text(
              "New order prepared",
              style: TextStyle(
                color: Color.fromARGB(255, 172, 80, 247),
                fontWeight: FontWeight.w600,
                fontSize: 36,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              'Product name: ${widget.title}',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                fontSize: 17,
              ),
            ),
            Text(
              'Total of the order is ${widget.price}€',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                fontSize: 17,
              ),
            ),
            Text(
              'User ordered using: ${widget.email}',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                fontSize: 17,
              ),
            ),
            SizedBox(height: screenHeight * 0.06),
            Flexible(
              child: IconButton(
                icon: const Icon(Icons.home),
                onPressed: () {
                  cartProvider.deleteAllCartProvider();
                  Get.off(() => HomeScreen());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
