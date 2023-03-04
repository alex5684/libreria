import 'package:firebase_database/firebase_database.dart';
import 'package:libreria_flutter/globalVariables.dart' as globals;
import 'book_model.dart';

  setProprietarioList(String value) async
  {
    await setListaLibri();

    globals.libri.forEach((element) {
      if(element!=null)
        {
          if(element.bookData.proprietario==value)
            {
              globals.proprietarioList.add(element.key);
            }
        }
    });
  }

  setListaLibri() async
  {
    Map<dynamic,dynamic> listaLibri=Map();
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
