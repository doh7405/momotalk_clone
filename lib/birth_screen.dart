import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:momo_talk/user_line.dart';

class BirthScreen extends StatelessWidget {
  const BirthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('UserList2/ZjhaUecOEjMeuyqHjtdE/user')
          .where('birth', isEqualTo: DateTime.now().toString().substring(0, 10))
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final docs1 = snapshot.data!.docs;
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
            final docs2 = snapshot.data!.docs;
            List<Widget> lit = [];
            lit.add(Container(
              decoration: const BoxDecoration(
                color: Color(0xffE6F0F9),
                border: Border(
                    top: BorderSide(color: Color(0xffDAE1E7)),
                    bottom: BorderSide(color: Color(0xffDAE1E7))),
              ),
              child: Row(
                children: [
                  Container(
                    color: const Color(0xff4CACD2),
                    margin: const EdgeInsets.only(left: 7.0, right: 3.0),
                    height: 12.0,
                    width: 2.0,
                  ),
                  const Text("오늘 생일인 학생"),
                ],
              ),
            ));
            for (int i = 0; i < docs1.length; i++) {
              lit.add(Column(
                children: [
                  UserLine(
                      abra: docs1[i]['abracadabra'],
                      like: docs1[i]['like'],
                      name: docs1[i]['name'],
                      url: docs1[i]['url']),
                  if (i != docs1.length - 1)
                    const Divider(
                      color: Color(0xffE4EAEA),
                      height: 1.0,
                      indent: 10.0,
                      endIndent: 10.0,
                    )
                ],
              ));
            }
            lit.add(Container(
              decoration: const BoxDecoration(
                color: Color(0xffE6F0F9),
                border: Border(
                    top: BorderSide(color: Color(0xffDAE1E7)),
                    bottom: BorderSide(color: Color(0xffDAE1E7))),
              ),
              child: Row(
                children: [
                  Container(
                    color: const Color(0xff4CACD2),
                    margin: const EdgeInsets.only(left: 7.0, right: 3.0),
                    height: 12.0,
                    width: 2.0,
                  ),
                  const Text("학생"),
                ],
              ),
            ));
            for (int i = 0; i < docs2.length; i++) {
              lit.add(Column(
                children: [
                  UserLine(
                      abra: docs2[i]['abracadabra'],
                      like: docs2[i]['like'],
                      name: docs2[i]['name'],
                      url: docs2[i]['url']),
                  if (i != docs2.length - 1)
                    const Divider(
                      color: Color(0xffE4EAEA),
                      height: 1.0,
                      indent: 10.0,
                      endIndent: 10.0,
                    )
                ],
              ));
            }
            return ListView(
              children: lit,
            );
          },
        );
      },
    );
  }
}
