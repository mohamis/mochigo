// ignore_for_file: library_private_types_in_public_api, always_specify_types, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:mochigo/core/theme/assets.dart';
import 'package:mochigo/core/theme/mochigo_theme.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentPageIndex = 0;

  List<Map<String, String>> splashScreenData = [
    {
      'image': Assets.ONBOARDING1,
      'title': 'Authentic mochi \nfrom Japan!',
      'subtitle':
          'Order mochi and come to collect \n         it within a few minutes.'
    },
    {
      'image': Assets.ONBOARDING2,
      'title': 'Book Online\n ',
      'subtitle':
          'Book online your favourites mochi \n                    in one click.'
    },
    {
      'image': Assets.ONBOARDING3,
      'title': 'Fast Preparation',
      'subtitle':
          'Our shop will prepare \n   and pack your mochi as soon\n           as we are inform.'
    },
    {
      'image': Assets.ONBOARDING4,
      'title': 'Enjoy !',
      'subtitle': 'When is ready come and get your mochi !\n  '
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            page(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  gradient: const LinearGradient(
                    begin: Alignment(-0.95, 0.0),
                    // ignore: avoid_redundant_argument_values
                    end: Alignment.centerRight,
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
                    await Get.toNamed('LoginScreen');

                    // await Get.to(() => LoginScreen());
                  },
                  child: const Text(
                    '👉🏻 Go to login',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xffffffff),
                      letterSpacing: -0.3858822937011719,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded page() {
    return Expanded(
      child: PageView.builder(
        itemCount: splashScreenData.length,
        onPageChanged: (int value) {
          setState(() {
            currentPageIndex = value;
          });
        },
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              const Spacer(),
              const Spacer(),
              const SizedBox(height: 20),
              SizedBox(
                child: Image.asset(
                  Assets.LOGOVECTOR,
                  scale: 1,
                  fit: BoxFit.scaleDown,
                ),
              ),
              const Spacer(),
              SizedBox(
                child: Image.asset(splashScreenData[index]['image'] as String),
              ),
              const Spacer(),
              Text(
                splashScreenData[index]['title'] as String,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(height: 20),
              Text(
                splashScreenData[index]['subtitle'] as String,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  splashScreenData.length,
                  (int index) => buildDots(index),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  AnimatedContainer buildDots(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 5),
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentPageIndex == index ? 25 : 6,
      decoration: BoxDecoration(
        color: currentPageIndex == index
            ? const Color.fromARGB(255, 234, 148, 102)
            : MochigoTheme.COLOR4,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
