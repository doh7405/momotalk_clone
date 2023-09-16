import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:momo_talk/user_line.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  bool orderName = false;

  void changeState() {
    setState(() {
      orderName = true;
    });
  }

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
              .orderBy('like', descending: false)
              .orderBy('name', descending: orderName)
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

            if (docs1.isNotEmpty) {
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
            }
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
                  const Text(
                    "모든 학생",
                  ),
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

            int numberStudent = docs1.length + docs2.length;

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
                          child: Text("학생($numberStudent)",
                              style: const TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold))),
                      InkWell(
                        onTap: () {
                          _showMyDialog();
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10.0),
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
                              const Text("이름"),
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
                                      borderRadius: BorderRadius.circular(1.5),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
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
      },
    );
  }

  // 77이다 50 + 74
  Future<void> _showMyDialog() async {
    return showDialog<void>(
        barrierColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 0.0,
            insetPadding: EdgeInsets.only(
                top: 101.0,
                bottom: MediaQuery.of(context).size.height / 1.8,
                right: 10.0,
                left: 10.0),
            contentPadding: const EdgeInsets.all(0.0),
            content: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 0.5,
                          spreadRadius: 0.5,
                          offset: const Offset(0, 1.5))
                    ]),
                child: Column(children: [
                  const SizedBox(
                      height: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text("정렬"), Icon(Icons.close)],
                          ),
                          Divider(
                            color: Color(0xffE4EAEA),
                            height: 1.0,
                          )
                        ],
                      )),
                  Expanded(
                      child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(onPressed: () {}, child: const Text("이름")),
                          TextButton(onPressed: () {}, child: const Text("학원"))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {}, child: const Text("인연랭크")),
                          TextButton(onPressed: () {}, child: const Text("셀렉트"))
                        ],
                      )
                    ],
                  )),
                  SizedBox(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Divider(
                        color: Color(0xffE4EAEA),
                        height: 1.0,
                      ),
                      TextButton(onPressed: () {}, child: const Text("확인")),
                    ],
                  ))
                ])),
          );
        });
  }
}
