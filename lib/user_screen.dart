import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:momo_talk/user_line.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('UserList2/ZjhaUecOEjMeuyqHjtdE/user')
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final docs = snapshot.data!.docs;
        return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  UserLine(
                      abra: docs[index]['abracadabra'],
                      like: docs[index]['like'],
                      name: docs[index]['name'],
                      url: docs[index]['url']),
                  const Divider(
                    color: Color(0xffE4EAEA),
                    indent: 10.0,
                    endIndent: 10.0,
                  )
                ],
              );
            });
      },
    );
  }
}
