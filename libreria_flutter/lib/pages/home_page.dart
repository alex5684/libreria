import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  @override
  Widget build(BuildContext context) {
    _database.ref().once().then((DatabaseEvent databaseEvent) {
      Object? map = databaseEvent.snapshot.value;
      List<dynamic>? _data=databaseEvent.snapshot.value as List?;
      List<BottomNavigationBarItem> items=[];
      _data?.forEach((element) { items.add(BottomNavigationBarItem(icon: Text(element),label: ""),);});
      return Scaffold(bottomNavigationBar: BottomNavigationBar(items: items,),);
    });
    return Scaffold();
  }
}
