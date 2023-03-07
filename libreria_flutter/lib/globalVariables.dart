import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:libreria_flutter/services/book_model.dart';


//                                                          costanti
//colori grafica
const coloreBordo=Color(0xFF7A74B6);
const coloreSfondoScaffold=Color(0xFF454545);
const coloreSfondoContainer=Color(0xFF282424);
//dimensioni
const dimMaxTelefono=500;

//                                                          variabili globali
//variabili utilizzate con firebase
var libri=<Book>[];
var proprietarioList=<dynamic>[];
late User user;

