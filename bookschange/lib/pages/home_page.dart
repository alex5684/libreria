//import 'dart:developer';

import 'package:bookschange/pages/Input_Data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/book_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../main.dart';
import 'package:flutter/material.dart';

List<Book> libri = [];
List<Book> myLibri = [];
List<String> materie = [];
List<Config> cfgMaterie = [];
List<Config> cfgClassi = [];
List<Config> cfgCondizioni = [];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Book libretto = Book(
      key: "",
      bookData: BookData(
          nome: "nome",
          cognome: "cognome",
          email: "email",
          telefono: "telefono",
          classe: "classe",
          materia: "materia",
          titolo: "titolo",
          condizioni: "condizioni",
          prezzo: 0.0,
          disponibile: false,
          proprietario: user!.uid));

  late String message;
  late String token;

  @override
  void initState() {
    super.initState();

    cfgMaterie.clear();
    cfgClassi.clear();
    cfgCondizioni.clear();

    FirebaseDatabase.instance
        .ref()
        .child("materie")
        .onChildAdded
        .listen((data) {
      setState(() {
        cfgMaterie.add( Config(key: data.snapshot.key!, val: data.snapshot.value as String));
      });
    });

    FirebaseDatabase.instance
        .ref()
        .child("materie")
        .onChildChanged
        .listen((data) {
      setState(() {
        Config materia =  Config(key: data.snapshot.key!, val: data.snapshot.value as String);

        int idx = cfgMaterie.indexWhere((element) => element.key == data.snapshot.key);
        if(idx != -1) {
          cfgMaterie.removeAt(idx);
          cfgMaterie.insert(idx, materia);
        }
      });
    });

    FirebaseDatabase.instance
        .ref()
        .child("materie")
        .onChildRemoved
        .listen((data) {
      setState(() {
        int idx = cfgMaterie.indexWhere((element) => element.key == data.snapshot.key);
        if(idx != -1) {
          cfgMaterie.removeAt(idx);
        }
      });
    });

    FirebaseDatabase.instance
        .ref()
        .child("classi")
        .onChildAdded
        .listen((data) {
      setState(() {
        cfgClassi.add( Config(key: data.snapshot.key!, val: data.snapshot.value as String));
      });
    });

    FirebaseDatabase.instance
        .ref()
        .child("classi")
        .onChildChanged
        .listen((data) {
      setState(() {
        Config classe =  Config(key: data.snapshot.key!, val: data.snapshot.value as String);

        int idx = cfgClassi.indexWhere((element) => element.key == data.snapshot.key);
        if(idx != -1) {
          cfgClassi.removeAt(idx);
          cfgClassi.insert(idx, classe);
        }
      });
    });

    FirebaseDatabase.instance
        .ref()
        .child("classi")
        .onChildRemoved
        .listen((data) {
      setState(() {
        int idx = cfgClassi.indexWhere((element) => element.key == data.snapshot.key);
        if(idx != -1) {
          cfgClassi.removeAt(idx);
        }
      });
    });

    FirebaseDatabase.instance
        .ref()
        .child("condizioni")
        .onChildAdded
        .listen((data) {
      setState(() {
        cfgCondizioni.add( Config(key: data.snapshot.key!, val: data.snapshot.value as String));
      });
    });

    FirebaseDatabase.instance
        .ref()
        .child("condizioni")
        .onChildChanged
        .listen((data) {
      setState(() {
        Config condizione =  Config(key: data.snapshot.key!, val: data.snapshot.value as String);

        int idx = cfgClassi.indexWhere((element) => element.key == data.snapshot.key);
        if(idx != -1) {
          cfgCondizioni.removeAt(idx);
          cfgCondizioni.insert(idx, condizione);
        }
      });
    });

    FirebaseDatabase.instance
        .ref()
        .child("condizioni")
        .onChildRemoved
        .listen((data) {
      setState(() {
        int idx = cfgCondizioni.indexWhere((element) => element.key == data.snapshot.key);
        if(idx != -1) {
          cfgCondizioni.removeAt(idx);
        }
      });
    });



    FirebaseDatabase.instance
        .ref()
        .child("libri")
        .onChildAdded
        .listen((data) {
      setState(() {
        BookData bookData = BookData.fromJson(data.snapshot.value as Map);
        Book book = Book(key: data.snapshot.key!, bookData: bookData);

        if (book.bookData.proprietario == user?.uid) {
          if (myLibri.indexWhere((element) => element.key == data.snapshot.key) == -1) {
            myLibri.add(book);
          }
        } else {
          if (libri.indexWhere((element) => element.key == data.snapshot.key) == -1) {
            libri.add(book);
          }
        }
      });
    });

    FirebaseDatabase.instance
        .ref()
        .child("libri")
        .onChildChanged
        .listen((data) {
      setState(() {
        BookData bookData = BookData.fromJson(data.snapshot.value as Map);
        Book book = Book(key: data.snapshot.key!, bookData: bookData);

        int idx;
        if (book.bookData.proprietario == user?.uid) {
          idx = myLibri.indexWhere((element) => element.key == data.snapshot.key);
          if(idx != -1) {
            myLibri.removeAt(idx);
            myLibri.insert(idx, book);
          }
        } else {
          if (libri.indexWhere((element) => element.key == data.snapshot.key) == -1) {
            idx = libri.indexWhere((element) => element.key == data.snapshot.key);
            if(idx != -1) {
              libri.removeAt(idx);
              libri.insert(idx, book);
            }
          }
        }
      });
    });

    FirebaseDatabase.instance
        .ref()
        .child("libri")
        .onChildRemoved
        .listen((data) {
      setState(() {
        BookData bookData = BookData.fromJson(data.snapshot.value as Map);
        Book book = Book(key: data.snapshot.key!, bookData: bookData);

        int idx;
        if (book.bookData.proprietario == user?.uid) {
          idx = myLibri.indexWhere((element) => element.key == data.snapshot.key);
          if(idx != -1) {
            myLibri.removeAt(idx);
          }
        } else {
          if (libri.indexWhere((element) => element.key == data.snapshot.key) == -1) {
            idx = libri.indexWhere((element) => element.key == data.snapshot.key);
            if(idx != -1) {
              libri.removeAt(idx);
            }
          }
        }

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
                channelDescription: channel.description,
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
    Map<String, String> data = {"stato": "no"};
    FirebaseDatabase.instance
        .ref()
        .child("notifica")
        .set(data)
        .then((value) {});
  }

  @override
  Widget build(BuildContext context) {
    var tabIndex = 0;
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('MERCATINO\nDEL LIBRO USATO'),
            bottom: TabBar(
              onTap: (int index) {
                setState(() {
                  tabIndex = index;
                });
              },
              tabs: const <Widget>[
                Tab(
                  text: 'I TUOI',
                  //icon: Icon(Icons.cloud_outlined),
                ),
                Tab(
                  text: 'GLI ALTRI',
                  //icon: Icon(Icons.beach_access_sharp),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Center(
                child: ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: myLibri.length,
                  separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    if (myLibri[index].bookData.proprietario == user?.uid) {
                      return Card(
                        margin: const EdgeInsets.only(left: 10, top: 5, right: 10),
                        child: ListTile(
                          title: Text(myLibri[index].bookData.materia),
                          subtitle: Text(myLibri[index].bookData.classe),
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      deleteBookDialog(context, myLibri[index]);
                                    }),
                                IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => InputData(
                                              book: myLibri[index],
                                              bookOp:eBookOp.updateBook,
                                            ),
                                          )
                                      );
                                    }),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              Center(
                child: ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: libri.length,
                  separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      margin: const EdgeInsets.only(left: 10, top: 5, right: 10),
                      child: ListTile(
                        title: Text(libri[index].bookData.materia),
                        subtitle: Text(libri[index].bookData.classe),
                        trailing: SizedBox(
                          width: 100,
                          child: IconButton(
                              icon: const Icon(Icons.remove_red_eye),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => InputData(
                                        book: libri[index],
                                        bookOp: eBookOp.showBook),
                                  ),
                                );
                              }
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          floatingActionButton: (tabIndex == 0)
              ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => InputData(
                        book: libretto,
                        bookOp: eBookOp.addBook),
                  ),
                );
              },
              child: const Icon(Icons.add_box),
            )
          : null,
        ));
  }
/*
  void showDeleteBookDialog(BuildContext context, Book book, String title,
      String content, bool isAllowed) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: (isAllowed)
            ? <CupertinoDialogAction>[
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
                      int index = libri
                          .indexWhere((element) => element.key == book.key);
                      libri.removeAt(index);
                      setState(() {});
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('Si'),
                ),
              ]
            : <CupertinoDialogAction>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Esci'),
                ),
              ],
      ),
    );
  }
*/
}
