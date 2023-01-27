import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:libreria_flutter/pages/getTitoli.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final utente = FirebaseAuth.instance.currentUser!;
  List<String> idLibri = [];

  Future getLibriId() async {
    await FirebaseFirestore.instance
        .collection("Libri")
        .get()
        .then((snapshot) => snapshot.docs.forEach((element) {
              idLibri.add(element.reference.id);
            }));
  }

  @override
  void initState() {
    getLibriId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          utente.email!,
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          GestureDetector(
              onTap: (){FirebaseAuth.instance.signOut();},
              child:Icon(Icons.logout)
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: FutureBuilder(
                future: getLibriId(),
                builder: (context, snapshot) {
                  return ListView.builder(
                      itemCount: idLibri.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: GetTitoli(
                            idLibro: idLibri[index],
                            id: "Titolo",
                          ),
                        );
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
