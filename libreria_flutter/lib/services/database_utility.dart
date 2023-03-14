import 'package:firebase_database/firebase_database.dart';
import 'package:libreria_flutter/globalVariables.dart' as globals;
import 'book_model.dart';

  uploadChanges(dynamic index,String nome,String cognome,String email,String telefono,String classe,String materia,String titolo,String proprietario,String condizioni,double prezzo,bool disponibile,) async
  {
    print("passato");
    FirebaseDatabase.instance.ref().child("libri").child(index).set({
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
    });

  }

  setProprietarioList(String value) async
  {
    await setListaLibri();

    for (var element in globals.libri) {
        if(element.bookData.cognome==value)
          {
            globals.proprietarioList.add(element);
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
          globals.libri.add(Book(key: key, bookData: bookData));
        });
      }
    });
  }
