import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cart/model/cart_model.dart';
import 'package:get/get.dart';
import 'package:mochigo/controller/login_controller.dart';
import 'package:mochigo/controller/mochi_controller.dart';
import 'package:mochigo/core/models/mochi_model.dart';
import 'package:mochigo/presentation/order_complete.dart';
import 'package:mochigo/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        backgroundColor: const Color.fromARGB(255, 255, 211, 245),
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [PaymentWidget()],
      ),
    );
  }
}

class PaymentWidget extends StatefulWidget {
  @override
  _PaymentWidgetState createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _cardNumberTextController =
      TextEditingController();
  final TextEditingController _cvcTextController = TextEditingController();
  final TextEditingController _expiryDateTextController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider = context.watch<CartProvider>();

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text("Name on Card"),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: TextFormField(
                    autofocus: true,
                    controller: _nameTextController,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[200],
                      filled: true,
                      border: InputBorder.none,
                      hintText: "JOHN SMITH",
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text("Card Number"),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: TextFormField(
                    autofocus: true,
                    controller: _cardNumberTextController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(19),
                      CardNumberInputFormatter(),
                    ],
                    decoration: InputDecoration(
                      fillColor: Colors.grey[200],
                      filled: true,
                      border: InputBorder.none,
                      hintText: "5642 4418 1234 5678",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12, left: 12),
                  child: Row(
                    children: [
                      const Expanded(flex: 1, child: Text("Expiration")),
                      Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: Text("CVC"),
                              ),
                              Tooltip(
                                message: "3 digit security number",
                                preferBelow: false,
                                verticalOffset: 8.0,
                                child: Icon(
                                  Icons.help_outline,
                                  color: Colors.grey[400],
                                  size: 18.0,
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        autofocus: true,
                        inputFormatters: [
                          new LengthLimitingTextInputFormatter(6),
                          ExpiryDateInputFormatter()
                        ],
                        controller: _expiryDateTextController,
                        decoration: InputDecoration(
                          fillColor: Colors.grey[200],
                          filled: true,
                          border: InputBorder.none,
                          hintText: "MM / YYYY",
                        ),
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        autofocus: true,
                        controller: _cvcTextController,
                        inputFormatters: [
                          new LengthLimitingTextInputFormatter(6),
                        ],
                        decoration: InputDecoration(
                          fillColor: Colors.grey[200],
                          filled: true,
                          border: InputBorder.none,
                          hintText: "987",
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 12,
                    left: 12,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Consumer<CartProvider>(
                          builder: (BuildContext context, CartProvider cart,
                                  Widget? child) =>
                              Text(
                            'TOTAL: \$${cart.getTotalAmount().toString()}',
                            style: const TextStyle(fontSize: 20.0),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Expanded(
                        flex: 2,
                        child: TextButton(
                          onPressed: () async {
                            await addMochiForOrder(cartProvider);
                          },
                          child: Ink(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.0),
                              gradient: const LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 234, 148, 102),
                                  Color.fromARGB(255, 255, 175, 100)
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 36.0,
                                vertical: 18.0,
                              ),
                              child: Text(
                                "Pay",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  final LoginProvider _loginProvider = Get.find<LoginProvider>();
  final MochiProvider _mochiProvider = Get.find<MochiProvider>();

  Future<void> addMochiForOrder(CartProvider cartProvider) async {
    if (cartProvider != null) {
      //creating new instance of mochimodel
      final List<MochiOrder> newMochi = [];
      for (CartItem f in cartProvider.flutterCart.cartItem) {
        newMochi.add(
          MochiOrder(
            name: f.productName ?? '',
            ownerId: _loginProvider.userData.email,
            price: f.unitPrice ?? 0,
            orderStatus: 'preparing',
            items: f.subTotal ?? 0,
          ),
        );
      }
      await _mochiProvider.addMochiOrder(newMochi);

      await Get.off(ThankYouPage(title: _loginProvider.userData.email));
    } else {
      Get.snackbar('Error', 'Order cannot be completed');
    }
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _cardNumberTextController.dispose();
    _cvcTextController.dispose();
    super.dispose();
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    StringBuffer buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      int nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write('  '); // Add double spaces.
      }
    }

    String string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}

class ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    String updatedString = text;
    if (text.length >= 2) {
      updatedString = text.substring(0, 2) + " / " + text.substring(2);
    }

    return newValue.copyWith(
        text: updatedString,
        selection: new TextSelection.collapsed(offset: updatedString.length));
  }
}
