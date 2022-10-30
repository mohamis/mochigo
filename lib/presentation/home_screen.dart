// ignore_for_file: library_private_types_in_public_api, always_specify_types, use_named_constants

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mochigo/controller/login_controller.dart';
import 'package:mochigo/controller/user_controller.dart';
import 'package:mochigo/core/theme/assets.dart';
import 'package:mochigo/core/theme/mochigo_theme.dart';
import 'package:mochigo/presentation/add_mochi_screen.dart';
import 'package:mochigo/presentation/admin_orders_screen.dart';
import 'package:mochigo/presentation/cart_screen.dart';
import 'package:mochigo/presentation/catalog_list.dart';
import 'package:mochigo/presentation/login_screen.dart';
import 'package:mochigo/presentation/user_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LoginProvider loginProvider = Get.find<LoginProvider>();

//testing purpose data
  List<String> categories = ['Filled', 'Special', 'Mystery Box', 'Boxes'];

  late String selectedCategory = 'Filled';
  late String liveCategory = 'Filled';

  final UserProvider userProvider = Get.find<UserProvider>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (loginProvider.userData.userType.compareTo('admin') == 0) {
      return OrdersAdminScreen();
    } else {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            loginProvider.userData.userType.compareTo('admin') == 0
                ? await Get.to(() => AddMochiScreen(size: size))
                : await Get.to(() => const MyCart());
          },
          child: loginProvider.userData.userType.compareTo('admin') == 0
              ? const ImageIcon(
                  AssetImage(Assets.ADMINVECTOR),
                  size: 28,
                  color: Color.fromARGB(255, 255, 216, 216),
                )
              : const Icon(
                  Icons.shopping_cart,
                  color: Color.fromARGB(255, 255, 216, 216),
                ),
        ),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 211, 245),
          elevation: 0,
          leading: IconButton(
            onPressed: () async {
              final bool outCome = await loginProvider.logoutEmail();

              //route if sign in successful
              if (outCome) {
                await Get.to(() => LoginScreen());
              }
            },
            icon: const Icon(Icons.no_accounts_sharp),
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
          title: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Hi ',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                TextSpan(
                  text: loginProvider.userData.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    foreground: Paint()..color = MochigoTheme.FONT_DARK_COLOR,
                  ),
                )
              ],
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Get.to(() => const UserDetailsScreen());
              },
              child: Container(
                margin: const EdgeInsets.all(10.0),
                width: 40.0, // we can adjust the width as you need
                child: CircleAvatar(
                  maxRadius: 25,
                  backgroundImage: NetworkImage(
                    loginProvider.userData.photoUrl,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              catgoriesWidget(size: size),
              mochiListWidget(size: size),
            ],
          ),
        ),
      );
    }
  }

//categories secotion
  SizedBox catgoriesWidget({required Size size}) {
    return SizedBox(
      height: 94,
      width: size.width,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: categories.map(
          (String currentCategory) {
            return InkWell(
              onTap: () => {
                setState(
                  () => selectedCategory = currentCategory,
                ),
                setState(() => liveCategory = currentCategory),
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                height: 86,
                width: 86,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(17),
                  ),
                  color: selectedCategory == currentCategory
                      ? const Color.fromARGB(255, 255, 216, 216)
                      : const Color.fromARGB(255, 40, 40, 40),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    currentCategory,
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: selectedCategory == currentCategory
                              ? const Color.fromARGB(255, 40, 40, 40)
                              : const Color.fromARGB(255, 255, 255, 255),
                        ),
                  ),
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }

  Expanded mochiListWidget({required Size size}) {
    return Expanded(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection(liveCategory).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.connectionState != ConnectionState.active) {
            return const Center(
              child: CircularProgressIndicator(),
            ); // 👈 data is loading
          }
          if (streamSnapshot.hasError) {
            return const Text("Something went wrong");
          }
          if (streamSnapshot.hasData && streamSnapshot.data!.docs.isEmpty) {
            return const Text("Document does not exist");
          }
          return MyCatalog(streamSnapshot: streamSnapshot);
        },
      ),
    );
  }
}
