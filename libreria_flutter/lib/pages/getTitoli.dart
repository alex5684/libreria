import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetTitoli extends StatelessWidget{
  final String idLibro;
  final String id;

  GetTitoli({required this.idLibro,required this.id});

  @override
  Widget build(BuildContext context) {

    CollectionReference libri=FirebaseFirestore.instance.collection("Libri");

    return FutureBuilder<DocumentSnapshot>(future: libri.doc(idLibro).get(),builder: (context,snapshot){
      if(snapshot.connectionState==ConnectionState.done)
        {
          Map<String,dynamic> data=snapshot.data!.data() as Map<String,dynamic>;
          return Text("titolo: ${data[id]}");
        }
      return Text("caricamento...");
    });
  }
}