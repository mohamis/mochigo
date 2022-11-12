import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mochigo/presentation/cart_screen.dart';
import 'package:mochigo/presentation/home_screen.dart';
import 'package:mochigo/presentation/loading_splash_screen.dart';
import 'package:mochigo/presentation/login_screen.dart';
import 'package:mochigo/presentation/on_boarding_screen.dart';
import 'package:mochigo/presentation/signup_screen.dart';
import 'package:mochigo/presentation/user_details_screen.dart';

dynamic appRoutes() => <GetPage<dynamic>>[
      GetPage<dynamic>(
        name: '/',
        page: () => const MyExplicitAnimation(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage<dynamic>(
        name: '/LoginScreen',
        page: () => LoginScreen(),
        middlewares: <GetMiddleware>[MyMiddelware()],
        transition: Transition.leftToRightWithFade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage<dynamic>(
        name: '/OnBoardingScreen',
        page: () => const OnBoardingScreen(),
        middlewares: <GetMiddleware>[MyMiddelware()],
        transition: Transition.leftToRightWithFade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage<dynamic>(
        name: '/SignUpScreen',
        page: () => SignUpScreen(),
        middlewares: <GetMiddleware>[MyMiddelware()],
        transition: Transition.leftToRightWithFade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage<dynamic>(
        name: '/HomeScreen',
        page: () => const HomeScreen(),
        middlewares: <GetMiddleware>[MyMiddelware()],
        transition: Transition.leftToRightWithFade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage<dynamic>(
        name: '/MyCart',
        page: () => const MyCart(),
        middlewares: <GetMiddleware>[MyMiddelware()],
        transition: Transition.leftToRightWithFade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage<dynamic>(
        name: '/UserDetailsScreen',
        page: () => const UserDetailsScreen(),
        middlewares: <GetMiddleware>[MyMiddelware()],
        transition: Transition.leftToRightWithFade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
    ];

class MyMiddelware extends GetMiddleware {
  @override
  // ignore: always_specify_types
  GetPage? onPageCalled(GetPage? page) {
    if (kDebugMode) {
      print(page?.name);
    }
    return super.onPageCalled(page);
  }
}
