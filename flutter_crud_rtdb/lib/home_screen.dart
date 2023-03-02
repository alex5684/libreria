import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_crud_rtdb/models/book_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'main.dart';
import 'models/student_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  DatabaseReference dbRef = FirebaseDatabase.instance.ref();


  final TextEditingController _edtNomeController = TextEditingController();
  final TextEditingController _edtCognomeController = TextEditingController();
  final TextEditingController _edtEmailController = TextEditingController();
  final TextEditingController _edtTelefonoController = TextEditingController();
  final TextEditingController _edtClasseController = TextEditingController();
  final TextEditingController _edtMateriaController = TextEditingController();
  final TextEditingController _edtTitoloController = TextEditingController();
  final TextEditingController _edtCondizioniController = TextEditingController();
  final TextEditingController _edtPrezzoController = TextEditingController();
  final TextEditingController _edtDisponibileController = TextEditingController();
  List<Book> libri = [];
  bool updateBook = false;

  late String message;
  late String token;

  @override
  void initState() {
    super.initState();

    dbRef.child("libri").onChildAdded.listen((data) {
      setState(() {
        BookData bookData = BookData.fromJson(data.snapshot.value as Map);
        Book book = Book(key: data.snapshot.key!, bookData: bookData);
        libri.add(book);
      });
    });

    dbRef.child("libri").onChildChanged.listen((data) {
      setState(() {
        BookData bookData = BookData.fromJson(data.snapshot.value as Map);
        Book book = Book(key: data.snapshot.key!, bookData: bookData);
        int index = libri.indexWhere((element) => element.key == data.snapshot.key);
        libri.removeAt(index);
        libri.insert(index,book);
      });
    });

    dbRef.child("libri").onChildRemoved.listen((data) {
      setState(() {
        int index = libri.indexWhere((element) => element.key == data.snapshot.key);
        libri.removeAt(index);
      });
    });




    var initialzationSettingsAndroid =
    const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
    InitializationSettings(android: initialzationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription:  channel.description,
                icon: android.smallIcon,
              ),
            ));
      }
    });
    getToken();
  }

  getToken() async {
    token = (await FirebaseMessaging.instance.getToken())!;
    setState(() {
      token = token;
    });
    final DatabaseReference database = FirebaseDatabase.instance.ref();
    database.child('fcm-token/$token').set({"token": token});
    Map<String,String> data = {
      "stato": "no"
    };
    dbRef.child("notifica").set(data).then((value){});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("Il mercatino del libro"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: (){
                    Map<String,String> data = {
                      "stato": "si"
                    };
                    dbRef.child("notifica").set(data).then((value){
                      //Navigator.of(context).pop();
                    });
                  },
                  child: const Icon(Icons.add_alert_sharp, color: Colors.green),
                ),
                const SizedBox(width: 50,),
                FloatingActionButton(
                  onPressed: (){
                    Map<String,String> data = {
                      "stato": "no"
                    };
                    dbRef.child("notifica").set(data).then((value){
                      //Navigator.of(context).pop();
                    });
                  },
                  child: const Icon(Icons.add_alert_sharp, color: Colors.red),
                ),
              ],
            ),

            for(int i = 0 ; i < libri.length ; i++)
              bookWidget(libri[i])
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          updateBook = false;
          bookDialog();
        },
        child: const Icon(Icons.book),),
    );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }

  void bookDialog({String? key}) {
    int index = libri.indexWhere((element) => element.key == key);
    bool isChecked = false;
    if(index >= 0) {
      isChecked = libri.elementAt(index).bookData.disponibile;
    }

    showDialog(context: context, builder: (context){
      return Dialog(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: _edtNomeController, decoration: const InputDecoration(helperText: "Nome"),),
                TextField(controller: _edtCognomeController, decoration: const InputDecoration(helperText: "Cognome")),
                TextField(controller: _edtEmailController, decoration: const InputDecoration(helperText: "Email")),
                TextField(controller: _edtTelefonoController, decoration: const InputDecoration(helperText: "Telefono"),),
                TextField(controller: _edtClasseController, decoration: const InputDecoration(helperText: "Classe")),
                TextField(controller: _edtMateriaController, decoration: const InputDecoration(helperText: "Materia")),
                TextField(controller: _edtTitoloController, decoration: const InputDecoration(helperText: "Titolo")),
                TextField(controller: _edtCondizioniController, decoration: const InputDecoration(helperText: "Condizioni"),),
                TextField(controller: _edtPrezzoController, decoration: const InputDecoration(helperText: "Prezzo")),
                TextField(controller: _edtDisponibileController, decoration: const InputDecoration(helperText: "Disponibile")),
                Switch(
                  // This bool value toggles the switch.
                  value: isChecked,
                  activeColor: Colors.red,
                  onChanged: (value) {
                    setState(() {
                      libri.elementAt(index).bookData.disponibile = value;
                      isChecked = value;
                    });
                  },
                ),
                const SizedBox(height: 10,),
                ElevatedButton(onPressed: (){
                  Map<String,dynamic> bookData = {
                    "nome": _edtNomeController.text.toString(),
                    "cognome": _edtCognomeController.text.toString(),
                    "email": _edtEmailController.text.toString(),
                    "telefono": _edtTelefonoController.text.toString(),
                    "classe": _edtClasseController.text.toString(),
                    "materia": _edtMateriaController.text.toString(),
                    "titolo": _edtTitoloController.text.toString(),
                    "condizioni": _edtCondizioniController.text.toString(),
                    "prezzo": double.parse(_edtPrezzoController.text.toString()),
                    "disponibile": isChecked
                  };

                  if(updateBook){
                    dbRef.child("libri").child(key!).update(bookData).then((value) {
                      int index = libri.indexWhere((element) => element.key == key);
                      libri.removeAt(index);
                      libri.insert(index, Book(key: key, bookData: BookData.fromJson(bookData)));
                      setState(() {});

                      Navigator.of(context).pop();
                    });
                  }
                  else{
                    dbRef.child("libri").push().set(bookData).then((value){
                      Navigator.of(context).pop();
                    });
                  }
                },
                    child: Text(updateBook ? "Update Data" : "Save Data"))
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget bookWidget(Book book) {
    return  Card(
      margin: const EdgeInsets.only(left: 10,top: 5, right: 10),
      child: ListTile(
        title: Text(book.bookData.materia),
        subtitle: Text(book.bookData.prezzo.toString()),
        trailing: SizedBox(
          width: 100,
          child: Row(
            children: [
              // Press this button to edit a single product
              IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    _edtNomeController.text = book.bookData.nome;
                    _edtCognomeController.text = book.bookData.cognome;
                    _edtEmailController.text = book.bookData.email;
                    _edtTelefonoController.text = book.bookData.telefono;
                    _edtClasseController.text = book.bookData.classe;
                    _edtMateriaController.text = book.bookData.materia;
                    _edtTitoloController.text = book.bookData.titolo;
                    _edtCondizioniController.text = book.bookData.condizioni;
                    _edtPrezzoController.text = book.bookData.prezzo.toString();
                    _edtDisponibileController.text = book.bookData.disponibile.toString();
                    updateBook = true;
                    bookDialog(key: book.key);
                  }
              ),
              IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () =>
                      dbRef.child("libri").child(book.key).remove().then((value){
                        int index = libri.indexWhere((element) => element.key == book.key);
                        libri.removeAt(index);
                        setState(() {});
                      })
              )
            ],
          ),
        ),
      ),
    );
  }
}