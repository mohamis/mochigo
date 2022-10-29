// ignore_for_file: always_specify_types

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mochigo/core/theme/assets.dart';
import 'package:mochigo/presentation/home_screen.dart';
import 'package:mochigo/presentation/signup_screen.dart';
import 'package:mochigo/providers/login_provider.dart';

class LoginScreen extends StatelessWidget {
  final LoginProvider loginProvider = Get.find<LoginProvider>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            Positioned(
              top: -10,
              left: -50,
              child: Container(
                width: size.width * 0.4,
                height: size.width * 0.4,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment(0.8, 1),
                    colors: [
                      Color.fromARGB(255, 244, 219, 223),
                      Color.fromARGB(255, 255, 211, 245),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -200,
              right: -100,
              child: Container(
                width: size.width * 0.8,
                height: size.width * 0.8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment(0.8, 1),
                    colors: [
                      Color.fromARGB(255, 255, 211, 245),
                      Color.fromARGB(255, 244, 219, 223),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Assets.LOGOVECTOR,
                    scale: 1,
                    fit: BoxFit.scaleDown,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Text(
                      "Welcome Back!",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  loginUi(size: size, context: context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget loginUi({required Size size, required BuildContext context}) {
    return Column(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30.0,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(hintText: 'Email'),
                  textCapitalization: TextCapitalization.none,
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                  textCapitalization: TextCapitalization.none,
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  gradient: const LinearGradient(
                    begin: Alignment(-0.95, 0.0),
                    end: Alignment(1.0, 0.0),
                    colors: [
                      Color.fromARGB(255, 234, 148, 102),
                      Color.fromARGB(255, 255, 175, 100)
                    ],
                    stops: [0.0, 1.0],
                  ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    disabledForegroundColor:
                        Colors.transparent.withOpacity(0.38),
                    disabledBackgroundColor:
                        Colors.transparent.withOpacity(0.12),
                    shadowColor: Colors.transparent,
                  ),
                  onPressed: () async {
                    final bool outCome =
                        await loginProvider.signInWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );

                    //route if sign in successful
                    if (outCome) {
                      await Get.to(() => const HomeScreen());
                    }
                  },
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xffffffff),
                      letterSpacing: -0.3858822937011719,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              RichText(
                text: TextSpan(
                  // Note: Styles for TextSpans must be explicitly defined.
                  // Child text spans will inherit styles from parent
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    const TextSpan(text: 'Don’t have an account? '),
                    TextSpan(
                      text: 'Sign Up',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap =
                            () async => await Get.to(() => SignUpScreen()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
