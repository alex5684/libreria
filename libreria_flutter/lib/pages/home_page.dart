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
  void initState() {
    //getData();
    super.initState();
  }

  getData() async
  {
    await setListaLibri();
  }

  @override
  Widget build(BuildContext context) {
    globals.user = FirebaseAuth.instance.currentUser!;
    setProprietarioList("pippo");
    return Scaffold(
      backgroundColor: globals.coloreSfondoScaffold,
      body: LayoutBuilder(
        builder: (BuildContext contex, BoxConstraints size) {
          if (size.maxWidth < globals.dimMaxTelefono) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  itemCount: globals.libri.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Text(globals.libri[index].bookData.titolo),
                        decoration: BoxDecoration(
                          color: globals.coloreSfondoContainer,
                          border: Border.all(
                              color: globals.coloreBordo,
                              width: 0.006 * size.maxWidth),
                          borderRadius:
                              BorderRadius.circular(0.06 * size.maxWidth),

                        ),
                      ),
                    );
                  }),
            );
          } else {
            return const Text("pc");
          }
        },
      ),
    );
  }
}
