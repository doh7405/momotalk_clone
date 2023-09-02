import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:momo_talk/user_line.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(backgroundColor: Colors.amber,),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('UserList2/ZjhaUecOEjMeuyqHjtdE/user')
        .snapshots(), builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final docs = snapshot.data!.docs;
          return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index){
                return UserLine(abra: docs[index]['abracadabra'], like: docs[index]['like'], name: docs[index]['name'], url: docs[index]['url']);
                // return Container(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(
                //     children: [
                //       CircleAvatar(backgroundImage: NetworkImage(docs[index]['url'])),
                //       Text(docs[index]['name'], style: const TextStyle(fontSize: 8.0),),
                //     ],
                //   )
                // );
              });
      },
      )
    );
  }
}
