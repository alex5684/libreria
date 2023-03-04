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
      body: LayoutBuilder(builder: (BuildContext contex, BoxConstraints size) {
        if(size.maxWidth<500)
          {
            return Column(
                children: [
                  Text("Home page"),

                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: List.generate(globals.libri.length, (index) {
                      return Center(
                        child:Container(
                          height: 40,
                          width: 40,
                          child: Text("pippo"),
                          color: Colors.amber,
                        ),
                      );
                    }),
                  )
                ],
            );
          }
        else
          {
            return Text("pc");
          }
      },),
    );
  }
}
