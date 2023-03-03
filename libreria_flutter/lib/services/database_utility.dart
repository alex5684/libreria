import 'package:firebase_database/firebase_database.dart';
import 'package:libreria_flutter/globalVariables.dart' as globals;

  setFilteredList(String valueToSearchFor,var value) async
  {
    setListaLibri();
    globals.listaLibri.asMap().forEach((key, value) {
      if(value!=null)
      {
        if(value[valueToSearchFor]==value)
        {
          globals.filteredList.add(key);
        }
      }
    });
  }

  setListaLibri() async
  {
    await FirebaseDatabase.instance.ref().child("libri").get().then((snapshot) {
      if (snapshot.exists) {
        globals.listaLibri = snapshot.value as List<dynamic>;
      }
    });
  }
