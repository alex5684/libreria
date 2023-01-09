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
    setState(() {
      map = Map<String, dynamic>.from(snapshot.value as Map);
      map?.forEach((key, value) {
        list.add(key);
      });
    });
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  List<BottomNavigationBarItem> _getBotNavBarItems() {
    List<BottomNavigationBarItem> itemsNav = [];

    for (String testo in list) {
      itemsNav.add(
        BottomNavigationBarItem(icon: Text(testo),label: ""),
      );
    }

    return itemsNav;
  }

  @override
  void initState() {
    super.initState();
    readData();
  }

  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            print(index);
          },
          items: _getBotNavBarItems(),
        ),
      );
    }
    catch(error)
  {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          print(index);
        },
        items: _getBotNavBarItems(),
      ),
    );
  }
  }
}
