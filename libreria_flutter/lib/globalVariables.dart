import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:libreria_flutter/services/book_model.dart';


//                                                          costanti
//colori grafica

//dimensioni


//                                                          variabili globali
//variabili utilizzate con firebase
/*var libri=<Book>[];
var proprietarioList=<dynamic>[];
late User user;
*/

class Globals {
  //variabili utilizzate con firebase
  static List<Book> libri =<Book>[];
  static List<dynamic> proprietarioList =<dynamic>[];
  static late User user;

  static var dimMaxTelefono=500;
  static Color coloreBordo=Color(0xFF7A74B6);
  static Color  coloreSfondoScaffold=Color(0xFF454545);
  static Color  coloreSfondoContainer=Color(0xFF282424);
  static Color  coloreScritteTitoloContainer=Color(0xFFF8F8F8);
  static Color  coloreScritteMateriaContainer=Color(0xFF7D7D7D);
  static Color  coloreScritteClasseContainer=Color(0xFF7D7D7D);
  static Color  coloreScritteCognomeContainer=Color(0xFF7D7D7D);

}
