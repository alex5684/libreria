import 'package:firebase_database/firebase_database.dart';
import 'package:libreria_flutter/globalVariables.dart' as globals;
import '../globalVariables.dart';
import 'book_model.dart';

  uploadChanges(String index,String nome,String cognome,String email,String telefono,String classe,String materia,String titolo,String condizioni,double prezzo,bool disponibile,) async
  {
    print("update");
    FirebaseDatabase.instance.ref().child("libri").child(index).update({
      "classe": classe,
      "cognome": cognome,
      "condizioni": condizioni,
      "disponibile": disponibile,
      "email": email,
      "materia": materia,
      "nome": nome,
      "prezzo": prezzo,
      "telefono": telefono,
      "titolo": titolo
    }).then((value) => { print("update") });

  }

  setProprietarioList(String value) async
  {
    await setListaLibri();

    for (var element in Globals.libri) {
        if(element.bookData.cognome==value)
          {
            Globals.proprietarioList.add(element);
          }
    }
  }

  setListaLibri() async
  {
    Map<dynamic,dynamic> listaLibri={};
    await FirebaseDatabase.instance.ref().child("libri").get().then((snapshot) {
      if (snapshot.exists) {
        listaLibri = snapshot.value as Map<dynamic,dynamic>;
        listaLibri.forEach((key, value) {
          BookData bookData = BookData.fromJson(value as Map);
          Globals.libri.add(Book(key: key, bookData: bookData));
        });
      }
    });
  }
