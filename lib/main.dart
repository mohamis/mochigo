import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mochigo/core/theme/mochigo_theme.dart';
import 'package:mochigo/firebase_options.dart';
import 'package:mochigo/presentation/on_boarding_screen.dart';
import 'package:mochigo/providers/login_provider.dart';
import 'package:mochigo/providers/mochi_provider.dart';
import 'package:mochigo/providers/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Default [FirebaseOptions] for use with your Firebase apps.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final LoginProvider controller = Get.put(LoginProvider());
  final UserProvider controllers = Get.put(UserProvider());
  final MochiProvider controllersP = Get.put(MochiProvider());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
        home: const OnBoardingScreen(),
      ),
    );
  }
}
