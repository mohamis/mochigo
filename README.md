# mochigo

An app for mochi lovers.

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Firebase](https://img.shields.io/badge/firebase-%23039BE5.svg?style=for-the-badge&logo=firebase)

## 📍 Getting Started

This project was created on Flutter (Channel stable, 3.3.6, on macOS 13.0 22A380 darwin-arm, locale en-FR).

The Mochigo project is a project that aims to create an app for selling and buying Mochi.
Mochi (餅, もち) is a Japanese rice cake made of mochigome, a short-grain japonica glutinous rice, and sometimes other ingredients such as water, sugar, and cornstarch. The rice is pounded into paste and molded into the desired shape.

We will build an application that will have two users:

- Buyers (clients): They can create an account, buy Mochi and put it in the cart, they will have also the option to see their buying history.
- Sellers (stores): They can put new articles, see the sells and future click and collect orders.

For help getting started with Flutter, view
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## 👩🏻‍💻 How to Use

**Step 1:**

Download or clone this repo by using the link below:

```
https://github.com/mohamis/mochigo.git
```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies:

```
flutter pub get
```

**Step 3:**

In the project root and execute the following command in console to launch the project:

(example for chrome)

```
flutter run -d chrome
```

---

## 🚀 Features:

- Splash Screen
- Login
- Home
- Cart
- Routing
- Get controllers
- Providers
- Firebase
- Logging via Crashlytics

### 🎸 Up-Coming Features:

- Dark Theme Support (new)

### 🧰 Libraries & Tools Used

TO CHANGE

- [Cloud Firestore](https://pub.dartlang.org/packages?q=cloud_firestore)
- [Provider](https://github.com/rrousselGit/provider) (State Management)
- [Cupertino Icons](https://pub.dartlang.org/packages?q=cupertino_icons)
- [Dart Cart](https://pub.dartlang.org/packages?q=dart_cart)
- [Firebase Auth](https://pub.dartlang.org/packages?q=firebase_auth)
- [Firebase Core](https://pub.dartlang.org/packages?q=firebase_core)
- [Firebase Crashlytics](https://pub.dartlang.org/packages?q=firebase_crashlytics)
- [Firebase Storage](https://pub.dartlang.org/packages?q=firebase_storage)
- [Flutter](https://pub.dartlang.org/packages?q=flutter)
- [Flutter Bloc](https://pub.dartlang.org/packages?q=flutter_bloc)
- [Flutter carousel slider](https://pub.dartlang.org/packages?q=flutter_carousel_slider)
- [Flutter Cart](https://pub.dartlang.org/packages?q=flutter_cart)
- [Flutter Facebook Auth](https://pub.dartlang.org/packages?q=flutter_facebook_auth)
- [Get 'Getx'](https://pub.dartlang.org/packages?q=get)
- [Google fonts](https://pub.dartlang.org/packages?q=google_fonts)
- [Hexcolor](https://pub.dartlang.org/packages?q=hexcolor)
- [html](https://pub.dartlang.org/packages?q=html)
- [Image picker](https://pub.dartlang.org/packages?q=image_picker)
- [Image picker web](https://pub.dartlang.org/packages?q=image_picker_web)
- [Ionicons](https://pub.dartlang.org/packages?q=ionicons)
- [location](https://pub.dartlang.org/packages?q=location)
- [Mime](https://pub.dartlang.org/packages?q=mime)
- [Provider](https://pub.dartlang.org/packages?q=provider)

# 🛣 Project

A project created in flutter using GetX and Provider. We supports both web and mobile, follow the respective instructions here:

- For Mobile: https://github.com/
- For Web: https://github.com/

**Subject**
Name: MOCHI&GO

Description: Our application allows us to order mochi and collect them in store in click and collect. There will be the merchant part with a user (store) and customer part (with the basic user), he can connect, fill in his personal information, put a profile picture.

The user can drop a photo taken with his phone in the application to review the mochi and leave comments. We will use a minimalist approach in the design of the application with animations to bring the application to life. At first we will have one store but if we do well we will have several stores.

As a customer, he will be able to choose his mochi or a pack, add it to the card, and a dummy payment system allowing him to buy a product (choice of payment). Summary of the order in his customer area (purchase history).

As a manager, he can receive the order, say when it's ready for the collect click, sales stats (sale of mochi, users etc).

Login via email / password.

### 📂 Folder Structure

Here is the core folder structure which flutter provides.

```
flutter-app/
|- android
|- build
|- ios
|- lib/
|-- controller/ (for cotrollers)
|-- core/
|----models/
|----theme/
|-- presentation/ (screens are there)
|----widgets/
|-- providers/ (providers)
|-- services/ (for services)
|-- services/ (for storage services mainly)
|-- utils/ (used for colors)
|- test
```

### 👩🏻‍🎨 UI

This directory contains all the ui of your application.

We use ![Figma](https://img.shields.io/badge/figma-%23F24E1E.svg?style=for-the-badge&logo=figma&logoColor=white) and Photoshop to mockup our application and you can find results in the `ui` directory as shown in the example below:

```
ui/
|- login
   |- login_screen.png
|- register
    |- register_screen.png
```

### 🏚 Main

This is the starting point of the application. All the application level configurations are defined in this file i.e, theme, routes, title, orientation etc.

```dart
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mochigo/controller/login_controller.dart';
import 'package:mochigo/controller/mochi_controller.dart';
import 'package:mochigo/controller/user_controller.dart';
import 'package:mochigo/core/theme/mochigo_theme.dart';
import 'package:mochigo/firebase_options.dart';
import 'package:mochigo/models/cart.dart';
import 'package:mochigo/models/catelog.dart';
import 'package:mochigo/presentation/loading_splash_screen.dart';
import 'package:provider/provider.dart';

import 'providers/cart_provider.dart';

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
  MyApp({super.key});

  final LoginProvider controller = Get.put(LoginProvider());
  final UserProvider controllers = Get.put(UserProvider());
  final MochiProvider controllersP = Get.put(MochiProvider());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // In this sample app, CatalogModel never changes, so a simple Provider
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
          home: const MyExplicitAnimation(),
        ),
      ),
    );
  }
}

```

## 📚 Boilerplate used

Checkout [wiki](https://github.com/zubairehman/flutter-boilerplate-project/wiki)

## 🎉 Conclusion

I will be happy to answer any questions that you may have on this approach.
If you liked our work, don’t forget to ⭐ star the repo to show your support.

## 🖥️ flutter doctor result

```log
[✓] Flutter (Channel stable, 3.3.6, on macOS 13.0 22A380 darwin-arm, locale en-FR)
    • Flutter version 3.3.6 on channel stable at /Users/mohamedchara/development/flutter
    • Upstream repository https://github.com/flutter/flutter.git
    • Framework revision 6928314d50 (8 days ago), 2022-10-25 16:34:41 -0400
    • Engine revision 3ad69d7be3
    • Dart version 2.18.2
    • DevTools version 2.15.0

[✓] Android toolchain - develop for Android devices (Android SDK version 33.0.0)
    • Android SDK at /Users/mohamedchara/Library/Android/sdk
    • Platform android-33, build-tools 33.0.0
    • Java binary at: /Applications/Android Studio.app/Contents/jre/Contents/Home/bin/java
    • Java version OpenJDK Runtime Environment (build 11.0.13+0-b1751.21-8125866)
    • All Android licenses accepted.

[✓] Xcode - develop for iOS and macOS (Xcode 14.0.1)
    • Xcode at /Applications/Xcode.app/Contents/Developer
    • Build 14A400
    • CocoaPods version 1.11.3

[✓] Chrome - develop for the web
    • CHROME_EXECUTABLE = /Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge

[✓] Android Studio (version 2021.3)
    • Android Studio at /Applications/Android Studio.app/Contents
    • Flutter plugin can be installed from:
      🔨 https://plugins.jetbrains.com/plugin/9212-flutter
    • Dart plugin can be installed from:
      🔨 https://plugins.jetbrains.com/plugin/6351-dart
    • Java version OpenJDK Runtime Environment (build 11.0.13+0-b1751.21-8125866)

[✓] VS Code (version 1.72.2)
    • VS Code at /Applications/Visual Studio Code.app/Contents
    • Flutter extension version 3.52.0

[✓] Connected device (2 available)
    • macOS (desktop) • macos  • darwin-arm64   • macOS 13.0 22A380 darwin-arm
    • Chrome (web)    • chrome • web-javascript • Microsoft Edge 107.0.1418.28

[✓] HTTP Host Availability
    • All required HTTP hosts are available

• No issues found!

```

## 👨🏻‍💻 Team

https://github.com/mohamis/
https://github.com/YaoHure
![avatar](https://images.weserv.nl/?url=avatars.githubusercontent.com/u/49785625?v=4&h=300&w=300&fit=cover&mask=circle&maxage=7d)
![avatar](https://images.weserv.nl/?url=avatars.githubusercontent.com/u/37964689?v=4&h=300&w=300&fit=cover&mask=circle&maxage=7d)
