// ignore_for_file: library_private_types_in_public_api, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:mochigo/controller/login_controller.dart';
import 'package:mochigo/controller/user_controller.dart';
import 'package:mochigo/core/theme/mochigo_theme.dart';

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

  final LoginProvider loginProvider = Get.find<LoginProvider>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.more_horiz,
              size: 25,
              // color: Colors.grey,
            ),
            onPressed: () {},
          )
        ],
        backgroundColor: MochigoTheme.PRIMARY_COLOR,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
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
                  Text(
                    loginProvider.userData.name,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    loginProvider.userData.userId,
                    style: const TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 221, 221, 221)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              loginProvider.userData.userId,
              style: const TextStyle(
                  fontSize: 15, color: MochigoTheme.PRIMARY_COLOR),
            ),
          ],
        ),
      ),
    );
  }
}
