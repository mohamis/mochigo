// ignore_for_file: library_private_types_in_public_api, avoid_unnecessary_containers, always_specify_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mochigo/controller/login_controller.dart';
import 'package:mochigo/controller/mochi_controller.dart';
import 'package:mochigo/controller/user_controller.dart';
import 'package:mochigo/core/theme/assets.dart';
import 'package:mochigo/core/theme/mochigo_theme.dart';
import 'package:mochigo/presentation/add_mochi_screen.dart';
import 'package:mochigo/presentation/login_screen.dart';
import 'package:mochigo/presentation/order_detail_screen.dart';
import 'package:mochigo/presentation/user_details_screen.dart';

final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class OrdersAdminScreen extends StatefulWidget {
  const OrdersAdminScreen({Key? key}) : super(key: key);

  @override
  State<OrdersAdminScreen> createState() => _OrdersAdminScreenState();
}

Color themeColor = const Color(0xFF43D19E);

class _OrdersAdminScreenState extends State<OrdersAdminScreen> {
  final LoginProvider loginProvider = Get.find<LoginProvider>();
  final UserProvider userProvider = Get.find<UserProvider>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Get.to(() => AddMochiScreen(size: size));
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
        elevation: 0,
        leading: IconButton(
          onPressed: () async {
            final bool outCome = await loginProvider.logoutEmail();

            //route if sign out successful
            if (outCome) {
              await Get.to(() => LoginScreen());
            }
          },
          icon: const Icon(Icons.no_accounts_sharp),
          color: Colors.white,
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
        backgroundColor: MochigoTheme.PRIMARY_COLOR,
        foregroundColor: Colors.white,
        title: const Text('Order management'),
      ),
      body: getGroupsWidget(),
    );
  }
}

Widget getGroupsWidget() {
  final MochiProvider mochiProvider = Get.find<MochiProvider>();

  return FutureBuilder(
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (!snapshot.hasData) {
        return const Center(child: CircularProgressIndicator());
      }
      if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
        return const Center(
          child: Text("No orders to prepare."),
        );
      }
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              Card(
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 5.0,
                  ),
                  title: Text(
                    '${snapshot.data.docs[index].get('name')} (total: ${snapshot.data.docs[index].get('totalPrice')}€)',
                  ),
                  subtitle: Text(
                    'Number of items: ${snapshot.data.docs[index].get('items').toString()}',
                  ),
                  trailing: snapshot.data.docs[index]
                              .get('orderStatus')
                              .compareTo('done') ==
                          0
                      ? const Icon(
                          Icons.shopping_bag_rounded,
                          size: 25,
                          color: Colors.green,
                        )
                      : IconButton(
                          icon: const Icon(
                            Icons.food_bank_rounded,
                            color: Colors.orange,
                          ),
                          onPressed: () {
                            mochiProvider.updateMochiForCollect(
                              snapshot.data.docs[index].reference.id,
                              'done',
                            );
                            Get.to(
                              () => AdminOrderPage(
                                email:
                                    snapshot.data.docs[index].get('ownerId') ??
                                        'price',
                                price:
                                    snapshot.data.docs[index].get('totalPrice'),
                                title: snapshot.data.docs[index].get('name') ??
                                    'name',
                              ),
                            );
                          },
                        ),
                ),
              )
            ],
          );
        },
        itemCount: snapshot.data.docs.length,
      );
    },
    future: loadGroups(),
  );
}

Future loadGroups() async {
  return _fireStore.collection("orders").get();
}
