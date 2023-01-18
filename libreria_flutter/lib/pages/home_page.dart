import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loaded=false;
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  Map<dynamic,dynamic> _databaseMap={};
  List<String> _databaseKeys=[];

  @override
  void initState() {
    _database.ref().onValue.listen((DatabaseEvent event) {
      _databaseMap=(event.snapshot.value as List?)!.asMap();
      _databaseKeys=_databaseMap!.keys.cast<String>()!.toList();
      loaded=true;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(loaded==false)
      {
        initState();
        return Scaffold(body: Text("non loaded"),);
      }
    else
      {
        return Scaffold(body: Text(_databaseKeys.elementAt(1)),);
      }
    /*return Scaffold(
      bottomNavigationBar: BottomNavigationBar(items: [BottomNavigationBarItem(icon: Text(_databaseKeys.elementAt(1)),label: ""),BottomNavigationBarItem(icon: Text("parola"),label: ""),],),
    );*/
  }
}
