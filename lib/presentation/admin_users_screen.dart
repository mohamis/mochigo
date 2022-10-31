// ignore_for_file: library_private_types_in_public_api, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mochigo/core/theme/mochigo_theme.dart';

final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MochigoTheme.PRIMARY_COLOR,
        foregroundColor: Colors.white,
        title: const Text('User management'),
      ),
      body: getGroupsWidget(),
    );
  }
}

Widget getGroupsWidget() {

  return FutureBuilder(
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (!snapshot.hasData) {
        return const Center(child: CircularProgressIndicator());
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
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(snapshot.data.docs[index].get('photoUrl')),
                    maxRadius: 40,
                  ),
                  title: Text(snapshot.data.docs[index].get('name')),
                  subtitle: Text(snapshot.data.docs[index].get('email')),
                  trailing: snapshot.data.docs[index]
                              .get('userType')
                              .compareTo('admin') ==
                          0
                      ? const Icon(
                          Icons.verified,
                          size: 25,
                          // color: Colors.grey,
                        )
                      : const Icon(
                          Icons.unpublished_rounded,
                          color: Color.fromARGB(255, 255, 216, 216),
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
  return _fireStore.collection("user").get();
}
