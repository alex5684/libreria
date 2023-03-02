import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final utente = FirebaseAuth.instance.currentUser!;



  getModificabili() async
  {
    var listaLibri=<dynamic>[];
    var modificabili=<int>[];
    String login="pippo";

    await FirebaseDatabase.instance.ref().child("libri").get().then((snapshot) {
      if (snapshot.exists) {
        listaLibri = snapshot.value as List<dynamic>;
      }
    });

    listaLibri.asMap().forEach((key, value) {
      if(value!=null)
        {
          if(value["proprietario"]==login)
          {
            modificabili.add(key);
          }
          else
          {

          }
        }
    });

    print(modificabili);

  }


  @override
  Widget build(BuildContext context) {
    getModificabili();
    return Scaffold(
      body: Text("pippo"),
    );
  }
}
