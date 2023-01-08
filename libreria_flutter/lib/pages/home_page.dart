import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  Map<dynamic, dynamic>? map;
  var list = [];

  void readData() async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.get();
    map = snapshot.value as Map<dynamic, dynamic>?;
    map?.forEach((key, value) { list.add(key);});
    print("passato");
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    readData();
    return Scaffold(

        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: list.elementAt(0)),
            BottomNavigationBarItem(icon: Icon(Icons.home),label: list.elementAt(1)),
            BottomNavigationBarItem(icon: Icon(Icons.home),label: list.elementAt(2)),
          ],
        ),
    );

  }
}
