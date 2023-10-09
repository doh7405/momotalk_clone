import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:momo_talk/chatList_screen.dart';
//import 'package:momo_talk/birth_screen.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'user_screen.dart';
import 'package:momo_talk/test_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAuth.instance.signInAnonymously();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffFB90A2)),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController =
        TabController(length: 2, vsync: this, animationDuration: Duration.zero);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 50.0,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          leading: Row(
            children: [
              const SizedBox(
                width: 5,
              ),
              const SizedBox(
                width: 35,
                child: Icon(
                  Icons.cake,
                  color: Colors.white,
                  size: 30.0,
                ),
              ),
              const SizedBox(
                width: 131,
                child: Text("MomoTalk",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
              const SizedBox(
                width: 9,
              ),
              SizedBox(
                width: 23,
                height: 23,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 3,
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.all(0)),
                  child: const Icon(
                    Icons.question_mark,
                    color: Color(0xffFB90A2),
                    size: 20,
                  ),
                  onPressed: () {
                    FirebaseFirestore.instance.collection('UserList').add(
                      {'name': DateTime.now().millisecondsSinceEpoch},
                    );
                  },
                ),
              ),
            ],
          ),
          leadingWidth: 250,
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.close,
                  size: 30,
                  color: Colors.white,
                ))
          ],
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            Container(
                color: const Color(0xffF3F7F8), child: const TestScreen()),
            Container(
                color: const Color(0xffF3F7F8), child: const ChatListScreen()),
          ],
        ),
        bottomNavigationBar: Container(
          color: const Color(0xff4A5B6F),
          height: 55,
          child: TabBar(
            padding: const EdgeInsets.all(0),
            indicator: const BoxDecoration(color: Color(0xff67788C)),
            labelPadding: const EdgeInsets.all(0),
            tabs: const <Widget>[
              SizedBox(
                width: double.infinity,
                child: Tab(
                    icon: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 44,
                )),
              ),
              SizedBox(
                width: double.infinity,
                child: Tab(
                    icon: Icon(
                  Icons.chat_bubble,
                  color: Colors.white,
                  size: 35,
                )),
              ),
            ],
            controller: _tabController,
          ),
        ));
  }
}
