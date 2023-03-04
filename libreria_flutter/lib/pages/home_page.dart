import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:libreria_flutter/globalVariables.dart' as globals;
import 'package:libreria_flutter/services/database_utility.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    globals.user = FirebaseAuth.instance.currentUser!;
    setProprietarioList("pippo");
    return Scaffold(
      body: Text("pippo"),
    );
  }
}
