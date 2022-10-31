import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mochigo/core/theme/assets.dart';
import 'package:mochigo/presentation/on_boarding_screen.dart';

class MyExplicitAnimation extends StatefulWidget {
  const MyExplicitAnimation({Key? key}) : super(key: key);

  @override
  State<MyExplicitAnimation> createState() => _MyExplicitAnimationState();
}

class _MyExplicitAnimationState extends State<MyExplicitAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..addStatusListener((AnimationStatus status) async {
            if (status == AnimationStatus.completed) {
              await Get.to(() => const OnBoardingScreen());
            }
          });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Transform.scale(
                  scale: _animationController.value,
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.asset(
                      Assets.LOGOVECTOR,
                      scale: 1,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        child: const Text("Loading..."),
      ),
    );
  }
}
