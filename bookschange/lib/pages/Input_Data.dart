import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../main.dart';
import '../models/book_model.dart';
import 'home_page.dart';

enum eBookOp { addBook, updateBook, deleteBook, showBook }

const List<String> listClassi = <String>[
  "",
  '1A',
  '1B',
  '1C',
  '1D',
  '1E',
  '1F',
  '1G',
  '1H',
  '2A',
  '2B',
  '2C',
  '2D',
  '2E',
  '2F',
  '2G',
  '2H',
  '3A',
  '3B',
  '3C',
  '3D',
  '3E',
  '3F',
  '3FA',
  '3FI',
  '3G',
  '4A',
  '4B',
  '4C',
  '4D',
  '4E',
  '4F',
  '4FA',
  '4FI',
  '4G',
  '4H',
  '5A',
  '5B',
  '5C',
  '5D',
  '5E',
  '5F'
];
const List<String> listMaterie = <String>[
  "",
  'Italiano',
  'Storia',
  'Francese',
  'Inglese',
  'Sistemi',
  'Informatica',
  'Geografia',
  'TPV'
];
const List<String> listCondizione = <String>["", 'Discreta', 'Buona', 'Ottima'];

class InputData extends StatefulWidget {
  late Book book;
  late eBookOp bookOp;

  InputData({required this.book, required this.bookOp});

  @override
  InputDataState createState() => InputDataState(book: book, bookOp: bookOp);
}

class InputDataState extends State<InputData> {
  late Book book;
  late eBookOp bookOp;

  InputDataState({required this.book, required this.bookOp});

  final TextEditingController controllerNome = TextEditingController();
  final TextEditingController controllerCognome = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerTelefono = TextEditingController();
  final TextEditingController controllerTitolo = TextEditingController();
  final TextEditingController controllerPrezzo = TextEditingController();

  String text = "";
  bool isOwner = true;
  bool status = false;
  String messaggio = 'NON Disponibile';
  String classe = "";
  String materia = "";
  String condizioni = "";
  String title = "";

  @override
  void initState() {
    super.initState();
    if (book.key.isNotEmpty) {
      controllerNome.text = book.bookData.nome;
      controllerCognome.text = book.bookData.cognome;
      controllerEmail.text = book.bookData.email;
      controllerTelefono.text = book.bookData.telefono;
      classe = book.bookData.classe;
      materia = book.bookData.materia;
      controllerTitolo.text = book.bookData.titolo;
      condizioni = book.bookData.condizioni;
      controllerPrezzo.text = book.bookData.prezzo.toString();
      status = book.bookData.disponibile;
      messaggio = status! ? 'Disponibile' : 'NON\nDisponibile';
    }
    switch(bookOp){
      case eBookOp.addBook:
        title = "Inserisci un nuovo libro";
        break;

      case eBookOp.updateBook:
        title = "Aggiorna il libro selezionato";
        break;

      case eBookOp.deleteBook:
        title = "Cancella il libro selezionato";
        break;

      case eBookOp.showBook:
        title = "Visualizza il libro selezionato";
        break;

    }
    isOwner = (book.bookData.proprietario == user?.uid);
  }



  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: new Text('AVVISO'),
        content: new Text('Vuoi uscire?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            //<-- SEE HERE
            child: new Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            // <-- SEE HERE
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      TextFormField(
                        enabled: isOwner,
                        controller: controllerNome,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'Nome',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.deepOrange,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        enabled: isOwner,
                        controller: controllerCognome,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'Cognome',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.deepOrange,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        enabled: isOwner,
                        keyboardType: TextInputType.emailAddress,
                        controller: controllerEmail,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.deepOrange,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                enabled: isOwner,
                                keyboardType: TextInputType.phone,
                                controller: controllerTelefono,
                                decoration: const InputDecoration(
                                  labelText: 'Telefono',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.deepOrange,
                                      style: BorderStyle.solid,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                decoration: const InputDecoration(
                                  labelText: 'Classe',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.deepOrange,
                                      style: BorderStyle.solid,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                ),
                                value: classe,
                                items: listClassi.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    enabled: isOwner,
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    classe = value!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                decoration: const InputDecoration(
                                  labelText: 'Materia',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.deepOrange,
                                      style: BorderStyle.solid,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                ),
                                value: materia,
                                items: listMaterie
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    enabled: isOwner,
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    materia = value!;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                decoration: const InputDecoration(
                                  labelText: 'Condizione',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.deepOrange,
                                      style: BorderStyle.solid,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                ),
                                value: condizioni,
                                items: listCondizione
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    enabled: isOwner,
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    condizioni = value!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        enabled: isOwner,
                        keyboardType: TextInputType.text,
                        controller: controllerTitolo,
                        decoration: const InputDecoration(
                          labelText: 'Titolo',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.deepOrange,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                enabled: isOwner,
                                keyboardType: TextInputType.number,
                                controller: controllerPrezzo,
                                decoration: const InputDecoration(
                                  labelText: 'Prezzo €',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.deepOrange,
                                      style: BorderStyle.solid,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: CheckboxListTile(
                                enabled: isOwner,
                                value: status,
                                title: Text(
                                  messaggio,
                                  style: TextStyle(
                                    color: status! ? Colors.green : Colors.red,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                activeColor:
                                    status! ? Colors.green : Colors.red,
                                //value: timeDilation != 1.0,
                                onChanged: (bool? value) {
                                  setState(() {
                                    messaggio = value!
                                        ? 'Disponibile'
                                        : 'NON\nDisponibile';
                                    status = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            book.bookData.nome = controllerNome.text;
            book.bookData.cognome = controllerCognome.text;
            book.bookData.email = controllerEmail.text;
            book.bookData.telefono = controllerTelefono.text;
            book.bookData.titolo = controllerTitolo.text;
            book.bookData.prezzo = double.parse(controllerPrezzo.text);
            book.bookData.disponibile = status;
            book.bookData.classe = classe;
            book.bookData.materia = materia;
            book.bookData.condizioni = condizioni;

            Map<String, dynamic> bookData = {
              "nome": book.bookData.nome,
              "cognome": book.bookData.cognome,
              "email": book.bookData.email,
              "telefono": book.bookData.telefono,
              "classe": book.bookData.classe,
              "materia": book.bookData.materia,
              "titolo": book.bookData.titolo,
              "condizioni": book.bookData.condizioni,
              "prezzo": book.bookData.prezzo,
              "disponibile": book.bookData.disponibile,
              "proprietario": book.bookData.proprietario
            };
            switch (bookOp) {
              case eBookOp.addBook:
                addBookDialog(context, book, bookData);
                //Navigator.pop(context);
                break;

              case eBookOp.updateBook:
                updateBookDialog(context, book, bookData);
                //Navigator.pop(context);
                break;

              case eBookOp.showBook:
                Navigator.pop(context);
                break;
            }

            //updateBook = false;
            //bookDialog();
          },
          child: const Icon(
            Icons.keyboard_return_rounded,
          ),
        ),
      ),
    );
  }
}

void addBookDialog(
    BuildContext context, Book book, Map<String, dynamic> bookData) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('AVVISO'),
        content: const Text('Vuoi inserire un nuovo libro?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              FirebaseDatabase.instance
                  .ref()
                  .child("libri")
                  .push()
                  .set(bookData)
                  .then((value) {});
              Navigator.pop(context);
            },
            child: const Text('Si'),
          ),
        ]),
  );
}

void updateBookDialog(
    BuildContext context, Book book, Map<String, dynamic> bookData) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('AVVISO'),
        content: const Text('Vuoi aggiornare il libro selezionato?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              FirebaseDatabase.instance
                  .ref()
                  .child("libri")
                  .child(book.key!)
                  .update(bookData)
                  .then((value) {
                int index =
                    libri.indexWhere((element) => element.key == book.key);
                if (index != -1) {
                  libri.removeAt(index);
                  libri.insert(
                      index,
                      Book(
                          key: book.key,
                          bookData: BookData.fromJson(bookData)));
                }
                //setState(() {});
                int myIndex =
                    myLibri.indexWhere((element) => element.key == book.key);
                if (myIndex != -1) {
                  myLibri.removeAt(myIndex);
                  myLibri.insert(
                      myIndex,
                      Book(
                          key: book.key,
                          bookData: BookData.fromJson(bookData)));
                }
                Navigator.pop(context);
                /*setState(() {

                });*/
              });
            },
            child: const Text('Si'),
          ),
        ]),
  );
}

void deleteBookDialog(BuildContext context, Book book) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('ATTENZIONE'),
        content: const Text('Vuoi cancellare il libro selezionato?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              FirebaseDatabase.instance
                  .ref()
                  .child("libri")
                  .child(book.key)
                  .remove()
                  .then((value) {
                int index =
                    libri.indexWhere((element) => element.key == book.key);
                if (index != -1) {
                  libri.removeAt(index);
                }
                int myIndex =
                    myLibri.indexWhere((element) => element.key == book.key);
                if (myIndex != -1) {
                  myLibri.removeAt(index);
                }
                //setState(() {});
              });
              Navigator.pop(context);
            },
            child: const Text('Si'),
          ),
        ]),
  );
}
