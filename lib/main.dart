// ignore_for_file: always_specify_types

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mochigo/controller/login_controller.dart';
import 'package:mochigo/controller/mochi_controller.dart';
import 'package:mochigo/controller/user_controller.dart';
import 'package:mochigo/core/models/cart.dart';
import 'package:mochigo/core/models/catelog.dart';
import 'package:mochigo/core/theme/mochigo_theme.dart';
import 'package:mochigo/firebase_options.dart';
import 'package:mochigo/routes.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

import 'providers/cart_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Default [FirebaseOptions] for use with your Firebase apps.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
// Here we set the URL strategy for our web app.
  // It is safe to call this function when running on mobile or desktop as well.
  setPathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final LoginProvider controller = Get.put(LoginProvider());
  final UserProvider controllers = Get.put(UserProvider());
  final MochiProvider controllersP = Get.put(MochiProvider());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // CatalogModel never changes, so a simple Provider
        // is sufficient.
        Provider(create: (BuildContext context) => CatalogModel()),
        // CartModel is implemented as a ChangeNotifier, which calls for the use
        // of ChangeNotifierProvider. Moreover, CartModel depends
        // on CatalogModel, so a ProxyProvider is needed.
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
          create: (BuildContext context) => CartModel(),
          update:
              (BuildContext context, CatalogModel catalog, CartModel? cart) {
            if (cart == null) throw ArgumentError.notNull('cart');
            cart.catalog = catalog;
            return cart;
          },
        ),
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
      ],
      child: GestureDetector(
        onTap: () {
          final FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            currentFocus.focusedChild!.unfocus();
          }
        },
        child: GetMaterialApp(
          theme: MochigoTheme.mytheme,
          title: 'Mochigo: All taste good',
          initialRoute: '/',
          getPages: appRoutes(),
        ),
      ),
    );
  }
}
