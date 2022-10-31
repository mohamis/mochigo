// ignore_for_file: library_private_types_in_public_api, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mochigo/controller/login_controller.dart';
import 'package:mochigo/core/theme/mochigo_theme.dart';

final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class OrderUsersScreen extends StatelessWidget {
  const OrderUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MochigoTheme.PRIMARY_COLOR,
        foregroundColor: Colors.white,
        title: const Text('Order history'),
      ),
      body: getGroupsWidget(),
    );
  }
}

Widget getGroupsWidget() {
  final LoginProvider loginProvider = Get.find<LoginProvider>();

  return FutureBuilder(
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (!snapshot.hasData) {
        return const Center(child: CircularProgressIndicator());
      }
      if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
        return const Center(
          child: Text("You have no order right now."),
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
                  // leading: CircleAvatar(
                  //   backgroundImage:
                  //       NetworkImage(snapshot.data.docs[index].get('photoUrl')),
                  //   maxRadius: 40,
                  // ),
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
                      : const Icon(
                          Icons.food_bank_rounded,
                          color: Colors.orange,
                        ),
                ),
              )
            ],
          );
        },
        itemCount: snapshot.data.docs.length,
      );
    },
    future: loadGroups(loginProvider.userData.email),
  );
}

Future loadGroups(String email) async {
  return _fireStore
      .collection("orders")
      .where('ownerId', isEqualTo: email)
      .get();
}
