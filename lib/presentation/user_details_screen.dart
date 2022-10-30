// ignore_for_file: library_private_types_in_public_api, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mochigo/controller/login_controller.dart';
import 'package:mochigo/controller/user_controller.dart';
import 'package:mochigo/core/theme/mochigo_theme.dart';
import 'package:mochigo/presentation/admin_users_screen.dart';
import 'package:mochigo/presentation/catalog_list.dart';
import 'package:mochigo/presentation/orders_users_screen.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final UserProvider userProvider = Get.find<UserProvider>();

  @override
  void initState() {
    super.initState();
  }

  //testing purpose data
  List<String> categories = [
    'Filled',
    'Special',
    'Mystery Box',
    'Boxes',
  ];

  late String selectedCategory = 'Filled';
  late String liveCategory = 'Filled';
  final LoginProvider loginProvider = Get.find<LoginProvider>();

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

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          if (loginProvider.userData.userType.compareTo('admin') == 0)
            IconButton(
              icon: const Icon(
                Icons.person_search_sharp,
                size: 25,
                // color: Colors.grey,
              ),
              onPressed: () async {
                await Get.to(() => const GroupsScreen());
              },
            )
          else
            const Icon(
              Icons.more_vert_sharp,
              color: Color.fromARGB(255, 255, 216, 216),
            ),
        ],
        backgroundColor: MochigoTheme.PRIMARY_COLOR,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              color: MochigoTheme.PRIMARY_COLOR,
            ),
            child: Column(
              children: <Widget>[
                Hero(
                  transitionOnUserGestures: true,
                  tag: loginProvider.userData.provider,
                  child: CircleAvatar(
                    backgroundImage:
                        NetworkImage(loginProvider.userData.photoUrl),
                    maxRadius: 40,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                FutureBuilder(
                  future:
                      userProvider.findUserName(loginProvider.userData.email),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Text(
                        snapshot.data.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.none) {
                      return const Text("No data");
                    }
                    return const CircularProgressIndicator();
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  loginProvider.userData.name,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color.fromARGB(255, 221, 221, 221),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
          if (loginProvider.userData.userType.compareTo('admin') == 0)
            catgoriesWidget(size: size)
          else
            const SizedBox(
              height: 30,
            ),
          if (loginProvider.userData.userType.compareTo('admin') == 0)
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(liveCategory)
                    .snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.connectionState !=
                      ConnectionState.active) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    ); // 👈 data is loading
                  }
                  if (streamSnapshot.hasError) {
                    return const Text("Something went wrong");
                  }
                  if (streamSnapshot.hasData &&
                      streamSnapshot.data!.docs.isEmpty) {
                    return const Text("Document does not exist");
                  }
                  return MyCatalog(streamSnapshot: streamSnapshot);
                },
              ),
            )
          else
            Card(
              child: ListTile(
                onTap: () {
                  Get.to(const OrderUsersScreen());
                },
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 5.0,
                ),
                leading: const Icon(
                  Icons.shopping_basket,
                  size: 25,
                  color: Colors.pink,
                ),
                title: const Text(
                  'My orders',
                  style: TextStyle(
                    fontSize: 18,
                    color: MochigoTheme.PRIMARY_COLOR,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 25,
                  color: Colors.blue,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
