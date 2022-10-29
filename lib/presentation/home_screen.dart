// ignore_for_file: library_private_types_in_public_api, always_specify_types, use_named_constants

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mochigo/core/models/mochi_model.dart';
import 'package:mochigo/core/theme/assets.dart';
import 'package:mochigo/core/theme/mochigo_theme.dart';
import 'package:mochigo/presentation/add_mochi_screen.dart';
import 'package:mochigo/presentation/login_screen.dart';
import 'package:mochigo/presentation/mochi_details_screen.dart';
import 'package:mochigo/presentation/user_details_screen.dart';
import 'package:mochigo/providers/login_provider.dart';
import 'package:mochigo/providers/storage_service.dart';
import 'package:mochigo/providers/user_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LoginProvider loginProvider = Get.find<LoginProvider>();
//testing purpose data
  List<String> categories = [
    'Filled mochi',
    'Special',
    'Mystery Mochi',
    'Premium'
  ];

  late String selectedCategory = 'Filled mochi';

  List<MochiModel> mochiList = [
    MochiModel(
      name: 'El Pistachio',
      id: '1',
      category: 'Premium',
      ownerId: '220',
      images: 'assets/images/products/mochi-pistachio.jpg',
      description:
          'This mochi alone is a journey between the Middle East and the Far East.',
      price: 1,
    ),
    MochiModel(
      name: 'Yuzu',
      id: '1',
      category: 'Filled mochi',
      ownerId: '220',
      images: 'assets/images/products/mochi-yuzu.jpg',
      description:
          'Yuzu is one of the most precious members of the extraordinary citrus family.',
      price: 1,
    ),
    MochiModel(
      name: 'Matcha',
      id: '1',
      category: 'Special',
      ownerId: '220',
      images: 'assets/images/products/mochi-matcha.jpg',
      description:
          'Comes with a sencha-type green tea for a tone-on-tone tasting.',
      price: 1,
    ),
  ];

  final UserProvider userProvider = Get.find<UserProvider>();
  @override
  void initState() {
    userProvider.getUserLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Get.to(() => AddMochiScreen(size: size));
          // await StorageService..uploadFiles();
          final StorageService service = StorageService();
          List<String> list = await service.uploadFiles(
              [File(Assets.ADMINVECTOR), File(Assets.MOCHIRETRIEVE)], '1');
          print(list);
          final String out =
              await service.uploadSingleFile(File(Assets.ADMINVECTOR), '1', 1);
          print(out);
        },
        child: const ImageIcon(
          AssetImage(Assets.ADMINVECTOR),
          size: 28,
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
              width: 40.0, // you can adjust the width as you need
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
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 8),
            //   child: Row(
            //     children: [
            //       IconButton(
            //           onPressed: () {},
            //           iconSize: 20,
            //           icon: Icon(Icons.location_on)),
            //       Text(
            //         // _userProvider.locationData == null
            //         //     ? ""
            //         //     : _userProvider.locationData.latitude.toString() +
            //         //         " Lat, " +
            //         //         _userProvider.locationData.longitude.toString() +
            //         //         " Lng",
            //         "",
            //         style: Theme.of(context).textTheme.headline3,
            //       )
            //     ],
            //   ),
            // ),

            catgoriesWidget(size: size),
            mochiListWidget(size: size)
          ],
        ),
      ),
    );
  }

//categories secotion
  Container catgoriesWidget({required Size size}) {
    return Container(
      height: 94,
      width: size.width,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: categories.map(
          (String currentCategory) {
            return InkWell(
              onTap: () => setState(() => selectedCategory = currentCategory),
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
                      ? const Color.fromARGB(255, 255, 250, 250)
                      // MochigoTheme.FONT_DARK_COLOR
                      : const Color.fromARGB(233, 214, 214, 214),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    currentCategory,
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: selectedCategory == currentCategory
                              ? const Color.fromARGB(255, 255, 174, 103)
                              : MochigoTheme.FONT_DARK_COLOR,
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
      child: ListView(
        children: mochiList.map((MochiModel currentMochi) {
          return Container(
            height: 180,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(
                width: 2.0,
                color: const Color.fromARGB(255, 255, 211, 245),
              ),
              borderRadius: BorderRadius.circular(10),
              color: MochigoTheme.PRIMARY_COLOR,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: const EdgeInsets.all(7),
                    height: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        currentMochi.images,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                // Spacer(),
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.only(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                currentMochi.name,
                                style: Theme.of(context).textTheme.titleMedium,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                        Flexible(
                          child: Text(
                            currentMochi.description,
                            style: Theme.of(context).textTheme.labelLarge,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => Get.to(
                            () => MochiDetailsScreen(
                              title: currentMochi.name,
                              description: currentMochi.description,
                              image: currentMochi.images,
                              price: currentMochi.price,
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 255, 211, 245),
                            ),
                          ),
                          child: Text(
                            "Product Details",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
