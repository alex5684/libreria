import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:libreria_flutter/services/book_model.dart';


//                                                          costanti
//colori grafica
const coloreBordo=Color(0xFF7A74B6);
const coloreSfondoScaffold=Color(0xFF454545);
const coloreSfondoContainer=Color(0xFF282424);
const coloreScritteTitoloContainer=Color(0xFFF8F8F8);
const coloreScritteMateriaContainer=Color(0xFF7D7D7D);
const coloreScritteClasseContainer=Color(0xFF7D7D7D);
const coloreScritteCognomeContainer=Color(0xFF7D7D7D);
//dimensioni
const dimMaxTelefono=500;

//                                                          variabili globali
//variabili utilizzate con firebase
var libri=<Book>[];
var proprietarioList=<dynamic>[];
late User user;

