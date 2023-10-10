import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:momo_talk/user_line_forChat.dart';
import 'package:momo_talk/option_dialog_forChat.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreen();
}

class _ChatListScreen extends State<ChatListScreen> {
  String orderName = "chatTime";
  String orderCondition = "최신";
  bool isDesc = true;

  void changeState(String selectedOption, String selectedCondition) {
    setState(() {
      orderName = selectedOption;
      orderCondition = selectedCondition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('UserList2/ZjhaUecOEjMeuyqHjtdE/user2')
          .orderBy(orderName, descending: isDesc)
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

        lit.add(const Divider(
          color: Color(0xffE4EAEA),
          height: 1.0,
          indent: 10.0,
          endIndent: 10.0,
        ));
        for (int i = 0; i < docs2.length; i++) {
          lit.add(Column(
            children: [
              UserLineForChat(
                  lastMessage: docs2[i]['lastChat'],
                  name: docs2[i]['name'],
                  url: docs2[i]['url'],
                  isRead: docs2[i]['isRead']),
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

        // 안 읽은 메시지 개수 확인
        int lenIsNotRead = 0;
        for (int i = 0; i < docs2.length; i++) {
          if (docs2[i]['isRead'] == false) lenIsNotRead++;
        }

        return Column(
          children: [
            Container(
              height: 50,
              color: const Color(0xffF3F7F8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: const EdgeInsets.only(left: 9.0),
                      child: Text("안 읽은 메시지($lenIsNotRead)",
                          style: const TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold))),
                  SizedBox(
                    width: 190,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            _showMyDialog();
                          },
                          child: Container(
                            margin: const EdgeInsets.all(4.0),
                            transform: Matrix4.skewX(-.15),
                            width: 90,
                            height: 30,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade300,
                                      blurRadius: 0.5,
                                      spreadRadius: 0.5,
                                      offset: const Offset(-1, 1.3))
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(orderCondition),
                                Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 4.0, right: 4.0),
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                            stops: [.5, .5],
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.topRight,
                                            colors: [
                                              Colors.transparent,
                                              Color(0xff496E8B)
                                            ]),
                                        borderRadius:
                                            BorderRadius.circular(1.5),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isDesc = !isDesc;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.all(4.0),
                            transform: Matrix4.skewX(-.15),
                            width: 70,
                            height: 30,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade300,
                                      blurRadius: 0.5,
                                      spreadRadius: 0.5,
                                      offset: const Offset(-1, 1.3))
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.menu_outlined),
                                SizedBox(
                                    width: 5,
                                    child: Icon(
                                        isDesc ? Icons.south : Icons.north,
                                        size: 18,
                                        color: const Color(0xff496C8C)))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: lit,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
        barrierColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return OptionDialogForChat(
            changeState: changeState,
          );
        });
  }
}
