# mochigo

An app for mochi lovers.

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Firebase](https://img.shields.io/badge/firebase-%23039BE5.svg?style=for-the-badge&logo=firebase)

## 📍 Getting Started

This project is made on Flutter 3.3.2 • channel stable •.

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

...

---

## 🚀 Features:

-

### 🎸 Up-Coming Features:

- Splash Screen
- Login
- Home
- Routing
- Firebase
- Logging via Crashlytics
- Dark Theme Support (new)

### 🧰 Libraries & Tools Used

TO CHANGE

- [Dio](https://github.com/flutterchina/dio)
- [Database](https://github.com/tekartik/sembast.dart)
- [MobX](https://github.com/mobxjs/mobx.dart) (to connect the reactive data of your application with the UI)
- [Provider](https://github.com/rrousselGit/provider) (State Management)
- [Encryption](https://github.com/xxtea/xxtea-dart)
- [Validation](https://github.com/dart-league/validators)
- [Logging](https://github.com/zubairehman/Flogs)
- [Notifications](https://github.com/AndreHaueisen/flushbar)
- [Json Serialization](https://github.com/dart-lang/json_serializable)
- [Dependency Injection](https://github.com/fluttercommunity/get_it)

# 🛣 Project

A project created in flutter using MobX and Provider. We supports both web and mobile, follow the respective instructions here:

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
|- lib
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
import 'package:boilerplate/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants/app_theme.dart';
import 'constants/strings.dart';
import 'ui/splash/splash.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings.appName,
      theme: themeData,
      routes: Routes.routes,
      home: SplashScreen(),
    );
  }
}
```

## 📚 Wiki

Checkout [wiki](https://github.com/zubairehman/flutter-boilerplate-project/wiki) for more info

## 🎉 Conclusion

I will be happy to answer any questions that you may have on this approach.
If you liked our work, don’t forget to ⭐ star the repo to show your support.

## 👨🏻‍💻 Team

https://github.com/mohamis/
https://github.com/YaoHure
![avatar](https://images.weserv.nl/?url=avatars.githubusercontent.com/u/49785625?v=4&h=300&w=300&fit=cover&mask=circle&maxage=7d)
![avatar](https://images.weserv.nl/?url=avatars.githubusercontent.com/u/37964689?v=4&h=300&w=300&fit=cover&mask=circle&maxage=7d)
